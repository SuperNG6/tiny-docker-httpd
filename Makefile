CFLAGS?=-O
LIBS=`[ \`uname\` = "SunOS" ] && echo -lsocket -lnsl`

all: darkhttpd

lib: pull-musl local-install-musl

pull-musl:
	git submodule update --init

local-install-musl: make-musl
	make -C musl install

make-musl: config-musl
	make -j5 -C musl

config-musl:
	cd musl && ./configure --prefix=$(abspath .)/lib

darkhttpd: lib darkhttpd.c
	lib/bin/musl-gcc -static darkhttpd.c -o $@
	strip darkhttpd

clean:
	rm -f darkhttpd core darkhttpd.core

.PHONY: all clean
