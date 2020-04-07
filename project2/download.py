#!/usr/bin/env python

import argparse
import logging
import os
import re

from datetime import datetime
from datetime import timedelta
from multiprocessing import Process
from multiprocessing import JoinableQueue
from multiprocessing import dummy

import requests
import wget

from bs4 import BeautifulSoup

ROOT_URL = "https://iatw.cnaf.infn.it/eee/monitor/dqmreport2"
ROOT_URL_LEN = len(ROOT_URL)
NUM_PROCESSES = 5
NUM_THREADS_PER_PROCESS = 4
DATE_REGEX = re.compile(r"[1-9][0-9]{3}(-[0-9]{2}){2}")

logger = logging.getLogger("download_all")


def fetch_record_file_urls(record_url, filetype):
    record_req = requests.get(record_url)
    soup = BeautifulSoup(record_req.text, features="html.parser")

    typelist = [filetype] if filetype != "both" else ["csv", "root"]

    for link in soup.find_all('a'):
        link_url = link.get("href")
        cur_type = None
        if link_url.endswith(".csv"):
            cur_type = "csv"
        elif link_url.endswith(".root"):
            cur_type = "root"
        if cur_type not in typelist:
            continue
        yield record_url + "/" + link_url


def _download_record(records_queue, filetype):
    threads = dummy.Pool(NUM_THREADS_PER_PROCESS)
    while True:
        next_batch = records_queue.get()
        if next_batch is None:
            break

        record_url, output_dir = next_batch
        logger.info("Downloading: %s", record_url[ROOT_URL_LEN:])

        os.makedirs(output_dir, exist_ok=True)
        downloader_args = [(url, output_dir) for url
                           in fetch_record_file_urls(record_url, filetype)]
        threads.starmap(wget.download, downloader_args)
        records_queue.task_done()
    threads.close()


def fetch_record_urls(resource_url, start_date=None, end_date=None):
    records_page_req = requests.get(resource_url)
    soup = BeautifulSoup(records_page_req.text, features="html.parser")

    for date_link in soup.find_all("a"):
        date_text = DATE_REGEX.search(date_link.text)
        if date_text is None:
            continue
        the_date = datetime.strptime(date_text.group(0), "%Y-%m-%d")
        if end_date is not None and end_date - the_date < timedelta(seconds=0):
            continue
        if start_date is not None and the_date - start_date < timedelta(seconds=0):
            return

        record_name = date_link.text
        record_url = resource_url + "/" + date_link.get("href").strip("/")
        yield record_name, record_url


def fetch_resource_urls(resources):
    for resource_name in resources:
        yield resource_name, ROOT_URL + "/" + resource_name


def get_resource_files(resources, filetype, start_date, end_date, output_dir):
    records_queue = JoinableQueue(20)
    processes = [Process(target=_download_record, args=(records_queue, filetype)) for i in range(NUM_PROCESSES)]

    for p in processes:
        p.start()

    for resource_name, resource_url in fetch_resource_urls(resources):
        for record_name, record_url in fetch_record_urls(resource_url, start_date, end_date):
            record_output_dir = os.path.join(output_dir, resource_name, record_name)
            records_queue.put((record_url, record_output_dir))

    for p in processes:
        records_queue.put(None)

    for p in processes:
        p.join()

    logger.info("Done!")


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)

    _parse_date = lambda arg: datetime.strptime(arg, "%Y-%m-%d")

    allowed_types = ["csv", "root", "both"]
    argparser = argparse.ArgumentParser()
    argparser.add_argument("resources", help="Name of resource. Example: POLA01", nargs="+")
    argparser.add_argument("-t", "--type", help="filetype to download",
                           choices=allowed_types, default="csv")
    argparser.add_argument("-s", "--start-date", help="start date Y-m-d", type=_parse_date, default=None)
    argparser.add_argument("-e", "--end-date", help="end date Y-m-d", type=_parse_date, default=None)
    argparser.add_argument("-o", "--output-dir", help="name of the output dir", default="data")
    args = argparser.parse_args()

    get_resource_files(args.resources,
                       args.type,
                       start_date=args.start_date,
                       end_date=args.end_date,
                       output_dir=args.output_dir)
