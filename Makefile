COMS = \
	aflash.com atest.com \
	ftest.com \
	jflash.com jtest.com \
	mflash.com mtest.com

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

#fflash.com: $(FLASHSRC)
#	$(ATASM) $(ASMFLAGS) -dFREEZER -o$@ $<

ftest.com: $(TESTSRC)
	$(ATASM) $(ASMFLAGS) -dFREEZER -o$@ $<

jflash.com: $(FLASHSRC)
	$(ATASM) $(ASMFLAGS) -dJUERGEN1024 -o$@ $<

jtest.com: $(TESTSRC)
	$(ATASM) $(ASMFLAGS) -dJUERGEN1024 -o$@ $<

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
