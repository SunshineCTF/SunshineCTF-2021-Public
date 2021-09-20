CC=gcc
CFLAGS=-fstack-protector-all -D_FORTIFY_SOURCE=2 -no-pie -Wl,-z,relro
LDFLAGS=-L/home/dynamic_type_librarii/lib -Wl,--rpath=/home/dynamic_type_librarii/lib -Wl,--dynamic-linker=/home/dynamic_type_librarii/lib/ld-2.28.so

all: dynamic_type_librarii

dynamic_type_librarii: dynamic_type_librarii.c
	ln -s /home/dynamic_type_librarii/lib/ld-2.28.so /home/dynamic_type_librarii/lib/ld-linux-x86-64.so.2
	ln -s /home/dynamic_type_librarii/lib/libc-2.28.so /home/dynamic_type_librarii/lib/libc.so.6
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^
	rm $^

clean:
	@rm dynamic_type_librarii
