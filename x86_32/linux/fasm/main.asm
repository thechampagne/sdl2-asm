format ELF
	
section '.text' executable
public _start

extrn printf
extrn SDL_Init
extrn SDL_CreateWindow
extrn SDL_CreateRenderer
extrn SDL_LoadBMP_RW
extrn SDL_RWFromFile
extrn SDL_CreateTextureFromSurface
extrn SDL_FreeSurface
extrn SDL_RenderClear
extrn SDL_RenderCopy
extrn SDL_RenderPresent
extrn SDL_Delay	
extrn SDL_DestroyTexture
extrn SDL_DestroyRenderer
extrn SDL_DestroyWindow
extrn SDL_Quit
extrn SDL_GetError

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
	push create_window_arg0
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
	push readbin
	push bmp_path
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
	mov ebx, 0
	jmp exit
init_err:
	call SDL_GetError
	push eax
	push init_err_msg
	call printf
	add esp, 8
	mov ebx, 8
	jmp exit
create_window_err:
	call SDL_GetError
	push eax
	push create_window_err_msg
	call printf
	add esp, 8
	mov ebx, 8
	jmp exit
create_renderer_err:
	call SDL_GetError
	push eax
	push create_renderer_err_msg
	call printf
	add esp, 8
	push ebx
	call SDL_DestroyWindow
	add esp, 4
	call SDL_Quit
	mov ebx, 8
	jmp exit
load_bmp_err:
	call SDL_GetError
	push eax
	push load_bmp_err_msg
	call printf
	add esp, 8
	push esi
	call SDL_DestroyRenderer
	add esp, 4
	push ebx
	call SDL_DestroyWindow
	add esp, 4
	call SDL_Quit
	mov ebx, 8
	jmp exit
create_tfs_err:
	call SDL_GetError
	push eax
	push create_tfs_err_msg
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
	mov ebx, 8
	jmp exit
exit:
	mov eax, 1
	int 80h


section '.data' writeable

init_err_msg            db "SDL_Init Error: %s", 10, 0

create_window_arg0      db "Hello World!", 0
	
create_window_err_msg   db "SDL_CreateWindow Error: %s", 10, 0

create_renderer_err_msg db "SDL_CreateRenderer Error: %s", 10, 0

bmp_path                db ".github/assets/image.bmp", 0

readbin                 db "rb", 0

load_bmp_err_msg        db "SDL_LoadBMP Error: %s", 10, 0

create_tfs_err_msg      db "SDL_CreateTextureFromSurface Error: %s", 10, 0	
