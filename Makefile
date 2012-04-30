#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#

#
# Copyright (c) 2012 Joyent, Inc.
#
CC=/opt/gcc/4.4.4/bin/gcc
CTFCONVERT=/opt/onbld/bin/i386/ctfconvert
CFLAGS=-Wall -Wextra -std=c99 -pedantic -m64 -D__EXTENSIONS__ -g
CSOFLAGS=-fPIC
CTFLAGS=-L VERSION
CMD=pcilookup
CMDLIBS=-L. -R. -lpcidb

all: libpcidb.so pcilookup

libpcidb.so: pcidb.c pcidb.h
	$(CC) $(CFLAGS) $(CSOFLAGS) -o pcidb.o -c pcidb.c
	$(CC) $(CFLAGS) -shared -o libpcidb.so pcidb.o
	$(CTFCONVERT) $(CTFLAGS) libpcidb.so

pcilookup: pcilookup.c pcidb.h
	$(CC) $(CFLAGS) -o $(CMD) $(CMD).c $(CMDLIBS)
	$(CTFCONVERT) $(CTFLAGS) $(CMD)

clean:
	rm -f *.o
	rm -f libpcidb.so
	rm -f $(CMD)