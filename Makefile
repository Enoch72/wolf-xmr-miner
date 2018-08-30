CC	= gcc
LD	= $(CC)
OPT 	= -O2 -s
IPATH	= -I/usr/local/src/openssl-1.1.0h
LPATH	= -L/usr/local/src/openssl-1.1.0h
CFLAGS 	= -D_POSIX_SOURCE -D_GNU_SOURCE $(OPT) -std=c11 -pthread $(IPATH) -g
LDFLAGS	= -DPTW32_STATIC_LIB $(LPATH) -L/usr/local/ssl/lib
LIBS	= -ljansson -lOpenCL -pthread -ldl -lssl -lcrypto 

PLAT	= X86
OBJX86	= crypto/aesb.o crypto/aesb-x86-impl.o crypto/oaes_lib.o
AESX86	= -maes
OBJARM	=
AESARM	=
OBJPLAT = $(OBJ$(PLAT))
AES	= $(AES$(PLAT))

OBJS	= $(OBJPLAT) crypto/c_blake256.o \
	crypto/c_groestl.o crypto/c_keccak.o crypto/c_jh.o crypto/c_skein.o \
	cryptonight.o log.o net.o minerutils.o gpu.o main.o

all: $(OBJS)
	$(LD) $(LDFLAGS) -o miner $(OBJS) $(LIBS)

cryptonight.o:	cryptonight.c
	$(CC) $(CFLAGS) $(AES)  -c -o $@ $?

clean:
	rm -f *.o crypto/*.o miner
