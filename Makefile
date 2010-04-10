all: testa.com testb.com bflash.com bflash.atr

ATASM=atasm

ASMFLAGS=
#ASMFLAGS = -v -s

LIBFLASHSRC = libflash.inc libflash-common.src \
	libflash-atarimax8.src \
	libflash-mega512.src

testa.com: testlib.src $(LIBFLASHSRC) iohelp.src
	$(ATASM) $(ASMFLAGS) -o$@ $<
	mkdir -p disk
	cp -f $@ disk

testb.com: testlib.src $(LIBFLASHSRC) iohelp.src arith.src getdens.src
	$(ATASM) $(ASMFLAGS) -dBERND -o$@ $<
	mkdir -p disk
	cp -f $@ disk

bflash.com: bflash.src $(LIBFLASHSRC) iohelp.src
	$(ATASM) $(ASMFLAGS) -dBERND -o$@ $<
	mkdir -p disk
	cp -f $@ disk

bflash.atr: bflash.com
	mkdir -p mdisk
	cp -f bflash.com mdisk/AUTORUN.AR0
	dir2atr -b MyDos4534 -d 720 $@ mdisk

#aflash.com: aflash.src cio.inc
#	$(ATASM) $(ASMFLAGS) -oaflash.com aflash.src
#
#aflash.atr: aflash.com
#	mkdir -p disk
#	cp -f aflash.com disk
#	dir2atr -b MyDos4534 -d 720 aflash.atr disk

clean:
	rm -f *.com *.atr
