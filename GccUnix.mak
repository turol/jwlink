
# This makefile creates the jwlink Elf binary for Linux/FreeBSD.
# not finished yet!!!

.PHONY: all install clean

VPATH = c dwarf/c sdk/rc/rc/c sdk/rc/wres/c

TARGET1=jwlink

ifndef DEBUG
DEBUG=0
endif

inc_dirs  = -Ih -Idwarf/h -Iwatcom/h -I. -I../open-watcom-v2/bld/watcom/h -Isdk/rc/rc/h -Isdk/rc/wres/h -Ilib_misc/h -Iorl/h

#cflags stuff

ifeq ($(DEBUG),0)
extra_c_flags = -DNDEBUG -O2
else
extra_c_flags = -DDEBUG_OUT -g
endif

c_flags =-D__UNIX__ -std=c99 $(extra_c_flags)

CC = gcc

.SUFFIXES:
# .SUFFIXES: .c .o

include gccmod.inc

#.c.o:
#	$(CC) -c $(inc_dirs) $(c_flags) -o $@ $<
%.o: %.c
	$(CC) -c $(inc_dirs) $(c_flags) -o $@ $<

all:  $(TARGET1)

$(TARGET1) : $(proj_obj)
	$(CC) $(proj_obj) -o $@ -Wl,-Map,$(TARGET1).map

######

install:
	@install $(TARGET1) /usr/local/bin

clean:
	@rm $(TARGET1)
	@rm *.o
	@rm *.map

