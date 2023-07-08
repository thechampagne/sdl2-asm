.PHONY: fasm-x86_64
fasm-x86_64:
	fasm x86_64/linux/fasm/main.asm fasm-x86_64-linux.o
	ld fasm-x86_64-linux.o -o fasm-x86_64-linux.out -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc -lSDL2


.PHONY: nasm-x86_64
nasm-x86_64:
	nasm -felf64 x86_64/linux/nasm/main.asm -o nasm-x86_64-linux.o
	ld nasm-x86_64-linux.o -o nasm-x86_64-linux.out -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc -lSDL2


.PHONY: clean
clean:
	rm -f *.o *.out
