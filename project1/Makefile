.PHONY: invmass scattering report all purge

all: report

invmass:
	make -C invmass/ all

scattering:
	make -C scattering/ all

report: invmass scattering
	make -C report/ all

purge:
	make -C invmass/ purge
	make -C scattering/ purge
	make -C report/ purge
