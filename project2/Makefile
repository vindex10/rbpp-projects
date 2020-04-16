.PHONY: data

data/POLA-01/2018-07-21/POLA-01_2018-07-21_2018-07-21_summary_Trending.csv:
	./download.py POLA-01 POLA-02 POLA-03 -t "csv" --start-date "2018-07-21" --end-date "2018-09-04"

data: data/POLA-01/2018-07-21/POLA-01_2018-07-21_2018-07-21_summary_Trending.csv

report: ananyev-project2-report.html

ananyev-project2-report.html:
	jupyter nbconvert --to=html --output=$@ project2-plots.ipynb

report_clean: ananyev-project2-report-clean.html

ananyev-project2-report-clean.html:
	jupyter nbconvert --template=nbextensions --to=html --output=$@ project2-plots.ipynb
