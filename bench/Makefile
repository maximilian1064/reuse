#CFLAGS=-g -O0
CC=icc
CFLAGS=-O3 -openmp -xHost -march=native -mtune=native

all: distgen

clean:
	rm -f *.o distgen *~

install: distgen
	cp distgen ~/bin
