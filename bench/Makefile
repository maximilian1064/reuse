#CFLAGS=-g -O0
CC=x86_64-hermit-gcc
CFLAGS=-O3 -fopenmp -march=native -mtune=native -Wall
LIBFLAGS=../../HermitHBWwork/hbwmalloc-hermit/libhbwmalloc.a

all: distgen-hbw distgen-ddr distgen-linux

distgen-hbw: distgen.c
	$(CC) -DHBW $(CFLAGS) $< $(LIBFLAGS) -o $@ 

distgen-ddr: distgen.c
	$(CC) $(CFLAGS) $< -o $@ 

distgen-linux: distgen.c
	gcc $(CFLAGS) $< -o $@


clean:
	rm -f *.o distgen-hbw distgen-ddr distgen-linux *~

install: distgen
	cp distgen ~/bin
