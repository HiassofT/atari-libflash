COMS = \
	ftest.com \
	mflash.com mtest.com \
	m4flash.com m4test.com \
	aflash.com mflash16.com \
	aflash1.com \
	atest.com mtest16.com \
	fflash.com fflash5.com \
	uflash.com \
	itest.com

all: flash.atr

ATASM ?= atasm

ASMFLAGS ?=
#ASMFLAGS ?= -v -s

LIBFLASHSRC = libflash.inc libflash.src \
	libflash-inc-target.inc \
	libflash-atarimax8.src \
	libflash-megamax16.src \
	libflash-freezer2005.src \
	libflash-freezer2011.src \
	libflash-mega512.src \
	libflash-u1mb.src

FLASHSRC = flash.src cio.inc cio.src iohelp.src iohelpfl.src $(LIBFLASHSRC)
FFLASHSRC = flash2.src cio.inc cio.src iohelp.src iohelpfl.src $(LIBFLASHSRC)
ITESTSRC = itest.src cio.inc cio.src iohelp.src iohelpfl.src $(LIBFLASHSRC)
TESTSRC = ctest.src cio.inc cio.src iohelp.src iohelpfl.src $(LIBFLASHSRC)

aflash.com: $(FLASHSRC)
	$(ATASM) $(ASMFLAGS) -dATARIMAX8 -o$@ $<

aflash1.com: $(FLASHSRC)
	$(ATASM) $(ASMFLAGS) -dATARIMAX8 -dONECHIP -o$@ $<

atest.com: $(TESTSRC)
	$(ATASM) $(ASMFLAGS) -dATARIMAX8 -o$@ $<

fflash5.com: $(FFLASHSRC)
	$(ATASM) $(ASMFLAGS) -dFREEZER2005 -o$@ $<

fflash.com: $(FFLASHSRC)
	$(ATASM) $(ASMFLAGS) -dFREEZER2011 -o$@ $<

ftest.com: $(TESTSRC)
	$(ATASM) $(ASMFLAGS) -dFREEZER2005 -o$@ $<

itest.com: $(ITESTSRC)
	$(ATASM) $(ASMFLAGS) -dFREEZER2005 -o$@ $<

mflash16.com: $(FLASHSRC)
	$(ATASM) $(ASMFLAGS) -dMEGAMAX16 -o$@ $<

mtest16.com: $(TESTSRC)
	$(ATASM) $(ASMFLAGS) -dMEGAMAX16 -o$@ $<

mflash.com: $(FLASHSRC)
	$(ATASM) $(ASMFLAGS) -dMEGA512 -o$@ $<

mtest.com: $(TESTSRC)
	$(ATASM) $(ASMFLAGS) -dMEGA512 -o$@ $<

m4flash.com: $(FLASHSRC)
	$(ATASM) $(ASMFLAGS) -dMEGA4096 -o$@ $<

m4test.com: $(TESTSRC)
	$(ATASM) $(ASMFLAGS) -dMEGA4096 -o$@ $<

uflash.com: $(FFLASHSRC)
	$(ATASM) $(ASMFLAGS) -dU1MB -o$@ $<


flash.atr: $(COMS) mydos-dos.sys mydos-dup.sys
	mkdir -p disk
	cp -f mydos-dos.sys disk/DOS.SYS
	cp -f mydos-dup.sys disk/DUP.SYS
	cp -f $(COMS) disk
	dir2atr -b MyDos4534 -d 720 $@ disk

clean:
	rm -rf *.com *.atr disk
