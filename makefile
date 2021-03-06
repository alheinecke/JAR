CC=gcc
CCAVX512=icc
CFLAGS=-I.
DEPS = jar_sim.h jar_type.h jar_utils.h 
OBJ = demo.o jar_utils.o jar_sim.o 
OBJAVX512 = demo.o.avx512 jar_utils.o.avx512 jar_sim.o.avx512 

default: demo demoavx512

clean:
	rm -rf *.o
	rm -rf *.o.avx512
	rm -rf demo
	rm -rf demoavx512

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

demo: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) -lm

%.o.avx512: %.c $(DEPS)
	$(CCAVX512) -c -o $@ $< $(CFLAGS) -xCOMMON-AVX512 -fopenmp

demoavx512: $(OBJAVX512)
	$(CCAVX512) -o $@ $^ $(CFLAGS) -lm -fopenmp
