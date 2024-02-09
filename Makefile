.PHONY: fasm-x86_64-linux
fasm-x86_64-linux:
	fasm x86_64/linux/fasm/main.asm fasm-x86_64-linux.o
	ld fasm-x86_64-linux.o -o fasm-x86_64-linux.out -dynamic-linker /lib64/ld-linux-x86-64.so.* -lc -lSDL2


.PHONY: nasm-x86_64-linux
nasm-x86_64-linux:
	nasm -felf64 x86_64/linux/nasm/main.asm -o nasm-x86_64-linux.o
	ld nasm-x86_64-linux.o -o nasm-x86_64-linux.out -dynamic-linker /lib64/ld-linux-x86-64.so.* -lc -lSDL2


.PHONY: nasm-x86_32-linux
nasm-x86_32-linux:
	nasm -felf32 x86_32/linux/nasm/main.asm -o nasm-x86_32-linux.o
	ld nasm-x86_32-linux.o -o nasm-x86_32-linux.out -dynamic-linker /lib/ld-linux.so.* -lc -lSDL2


.PHONY: fasm-x86_32-linux
fasm-x86_32-linux:
	fasm x86_32/linux/fasm/main.asm fasm-x86_32-linux.o
	ld fasm-x86_32-linux.o -o fasm-x86_32-linux.out -dynamic-linker /lib/ld-linux.so.* -lc -lSDL2


.PHONY: gas-x86_64-linux
gas-x86_64-linux:
	as --64 x86_64/linux/gas/main.asm -o gas-x86_64-linux.o
	ld gas-x86_64-linux.o -o gas-x86_64-linux.out -dynamic-linker /lib64/ld-linux-x86-64.so.* -lc -lSDL2

.PHONY: gas-x86_32-linux
gas-x86_32-linux:
	as --32 x86_32/linux/gas/main.asm -o gas-x86_32-linux.o
	ld gas-x86_32-linux.o -o gas-x86_32-linux.out -dynamic-linker /lib/ld-linux.so.* -lc -lSDL2

.PHONY: nasm-x86_64-freebsd
nasm-x86_64-freebsd:
	nasm -felf64 x86_64/freebsd/nasm/main.asm -o nasm-x86_64-freebsd.o
	ld nasm-x86_64-freebsd.o -o nasm-x86_64-freebsd.out -dynamic-linker /libexec/ld-elf.so.* -L/usr/lib -L/usr/local/lib -lc -lSDL2

.PHONY: fasm-x86_64-freebsd
fasm-x86_64-freebsd:
	fasm x86_64/freebsd/fasm/main.asm fasm-x86_64-freebsd.o
	ld fasm-x86_64-freebsd.o -o fasm-x86_64-freebsd.out -dynamic-linker /libexec/ld-elf.so.* -L/usr/lib -L/usr/local/lib -lc -lSDL2


.PHONY: clean
clean:
	rm -f *.o *.out
