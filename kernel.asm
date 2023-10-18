jmp 0x1000:kernel_start

kernel_start:
	mov ax, cs
	mov ds, ax
	
	mov bx, kernel_msg
	call kprint
	
	jmp $
	
kprint:
	pusha
.kputchar:
	mov al, [bx]
	cmp al, 0
	je .kfinally
	mov ah, 0x0e
	int 0x10
	add bx, 1
	jmp .kputchar
.kfinally:
	popa
	ret

kernel_msg db 'Enable Kernel', 0

times 512-($-$$) db 0