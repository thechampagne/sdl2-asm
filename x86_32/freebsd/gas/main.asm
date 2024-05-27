.intel_syntax noprefix
.global _start

.extern printf
.extern SDL_Init
.extern SDL_CreateWindow
.extern SDL_CreateRenderer
.extern SDL_LoadBMP_RW
.extern SDL_RWFromFile
.extern SDL_CreateTextureFromSurface
.extern SDL_FreeSurface
.extern SDL_RenderClear
.extern SDL_RenderCopy
.extern SDL_RenderPresent
.extern SDL_Delay	
.extern SDL_DestroyTexture
.extern SDL_DestroyRenderer
.extern SDL_DestroyWindow
.extern SDL_Quit
.extern SDL_GetError

.section .text

_start:
	push 62001
	call SDL_Init
	add esp, 4
	cmp eax, 0
	jl init_err
	push 4
	push 720
	push 960
	push 100
	push 100
	push offset create_window_arg0
	call SDL_CreateWindow
	add esp, 24
	cmp eax, 0
	je create_window_err
	mov ebx, eax
	push 6
	push -1
	push eax
	call SDL_CreateRenderer
	add esp, 12
	cmp eax, 0
	je create_renderer_err
	mov esi, eax
	push offset readbin
	push offset bmp_path
	call SDL_RWFromFile
	add esp, 8
	push 1
	push eax
	call SDL_LoadBMP_RW
	add esp, 8
	cmp eax, 0
	je load_bmp_err
	mov edi, eax
	push eax
	push esi
	call SDL_CreateTextureFromSurface
	add esp, 8
	cmp eax, 0
	je create_tfs_err
	push edi
	mov edi, eax
	call SDL_FreeSurface
	add esp, 4
	push ebx
	xor ebx, ebx
loop0:
	push esi
	call SDL_RenderClear
	add esp, 4
	push 0
	push 0
	push edi
	push esi
	call SDL_RenderCopy
	add esp, 16
	push esi
	call SDL_RenderPresent
	add esp, 4
	push 1000
	call SDL_Delay
	add esp, 4
	inc ebx
	cmp ebx, 5
	jl loop0
	pop ebx
	push edi
	call SDL_DestroyTexture
	add esp, 4
	push esi
	call SDL_DestroyRenderer
	add esp, 4
	push ebx
	call SDL_DestroyWindow
	add esp, 4
	call SDL_Quit
	push 0
	jmp exit
init_err:
	call SDL_GetError
	push eax
	push offset init_err_msg
	call printf
	add esp, 8
	push 8
	jmp exit
create_window_err:
	call SDL_GetError
	push eax
	push offset create_window_err_msg
	call printf
	add esp, 8
	push 8
	jmp exit
create_renderer_err:
	call SDL_GetError
	push eax
	push offset create_renderer_err_msg
	call printf
	add esp, 8
	push ebx
	call SDL_DestroyWindow
	add esp, 4
	call SDL_Quit
	push 8
	jmp exit
load_bmp_err:
	call SDL_GetError
	push eax
	push offset load_bmp_err_msg
	call printf
	add esp, 8
	push esi
	call SDL_DestroyRenderer
	add esp, 4
	push ebx
	call SDL_DestroyWindow
	add esp, 4
	call SDL_Quit
	push 8
	jmp exit
create_tfs_err:
	call SDL_GetError
	push eax
	push offset create_tfs_err_msg
	call printf
	add esp, 8
	push edi
	call SDL_FreeSurface
	add esp, 4
	push esi
	call SDL_DestroyRenderer
	add esp, 4
	push ebx
	call SDL_DestroyWindow
	add esp, 4
	call SDL_Quit
	push 8
exit:
	mov eax, 1
	int 0x80


.section .data

.global environ
.global __progname

environ: .long 0
__progname: .asciz "sdl2_example"

init_err_msg:			.asciz "SDL_Init Error: %s\n"

create_window_arg0:		.asciz "Hello World!"

create_window_err_msg:		.asciz "SDL_CreateWindow Error: %s\n"

create_renderer_err_msg:	.asciz "SDL_CreateRenderer Error: %s\n"

bmp_path:			.asciz ".github/assets/image.bmp"

readbin:			.asciz "rb"

load_bmp_err_msg:		.asciz "SDL_LoadBMP Error: %s\n"

create_tfs_err_msg:		.asciz "SDL_CreateTextureFromSurface Error: %s\n"
