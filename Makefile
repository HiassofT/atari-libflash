COMS = \
	aflash.com atest.com \
	ftest.com \
	mflash.com mtest.com \
	mflash8.com mflash16.com \
	mtest8.com mtest16.com

all: flash.atr

ATASM ?= atasm

ASMFLAGS ?=
#ASMFLAGS ?= -v -s

LIBFLASHSRC = libflash.inc libflash.src \
	libflash-atarimax8.src \
	libflash-freezer.src \
	libflash-mega512.src

FLASHSRC = flash.src cio.inc iohelp.src iohelpfl.src $(LIBFLASHSRC)
TESTSRC = ctest.src cio.inc iohelpfl.src $(LIBFLASHSRC)

aflash.com: $(FLASHSRC)
	$(ATASM) $(ASMFLAGS) -dATARIMAX8 -o$@ $<

atest.com: $(TESTSRC)
	$(ATASM) $(ASMFLAGS) -dATARIMAX8 -o$@ $<

mflash8.com: $(FLASHSRC)
	$(ATASM) $(ASMFLAGS) -dMEGAMAX8 -o$@ $<

mtest8.com: $(TESTSRC)
	$(ATASM) $(ASMFLAGS) -dMEGAMAX8 -o$@ $<

#fflash.com: $(FLASHSRC)
#	$(ATASM) $(ASMFLAGS) -dFREEZER -o$@ $<

ftest.com: $(TESTSRC)
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
