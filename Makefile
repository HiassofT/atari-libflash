COMS = \
	ftest.com \
	mflash.com mtest.com \
	mflash8.com mflash16.com \
	mtest8.com mtest16.com \
	fflash.com \
	itest.com

all: flash.atr

ATASM ?= atasm

ASMFLAGS ?=
#ASMFLAGS ?= -v -s

LIBFLASHSRC = libflash.inc libflash.src \
	libflash-megamax8.src \
	libflash-megamax16.src \
	libflash-freezer.src \
	libflash-mega512.src

FLASHSRC = flash.src cio.inc iohelp.inc iohelp.src iohelpfl.src $(LIBFLASHSRC)
FFLASHSRC = flash2.src cio.inc iohelp.inc iohelp.src iohelpfl.src $(LIBFLASHSRC)
ITESTSRC = itest.src cio.inc iohelp.inc iohelp.src iohelpfl.src $(LIBFLASHSRC)
TESTSRC = ctest.src cio.inc iohelp.inc iohelp.src iohelpfl.src $(LIBFLASHSRC)

mflash8.com: $(FLASHSRC)
	$(ATASM) $(ASMFLAGS) -dMEGAMAX8 -o$@ $<

mtest8.com: $(TESTSRC)
	$(ATASM) $(ASMFLAGS) -dMEGAMAX8 -o$@ $<

fflash.com: $(FFLASHSRC)
	$(ATASM) -s $(ASMFLAGS) -dFREEZER -o$@ $<

ftest.com: $(TESTSRC)
	$(ATASM) $(ASMFLAGS) -dFREEZER -o$@ $<

itest.com: $(ITESTSRC)
	$(ATASM) $(ASMFLAGS) -dFREEZER -o$@ $<

mflash16.com: $(FLASHSRC)
	$(ATASM) $(ASMFLAGS) -dMEGAMAX16 -o$@ $<

mtest16.com: $(TESTSRC)
	$(ATASM) $(ASMFLAGS) -dMEGAMAX16 -o$@ $<

mflash.com: $(FLASHSRC)
	$(ATASM) $(ASMFLAGS) -dMEGA512 -o$@ $<

mtest.com: $(TESTSRC)
	$(ATASM) $(ASMFLAGS) -dMEGA512 -o$@ $<


flash.atr: $(COMS)
	mkdir -p disk
	cp -f $(COMS) disk
	dir2atr -b MyDos4534 -d 720 $@ disk

clean:
	rm -f *.com *.atr
