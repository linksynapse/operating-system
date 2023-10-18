[org 0]
[bits 16]

jmp 0x07c0:boot

boot:
	mov ax, cs
	mov ds, ax

	mov bx, greeting
	call print
	
	mov bx, newline
	call print
	
	mov bx, system
	call print
	
	mov bx, newline
	call print
	
halt:
	jmp $

print:
	pusha
.putchar:
	mov al, [bx]
	cmp al, 0
	je .finally
	mov ah, 0x0e
	int 0x10
	add bx, 1
	jmp .putchar
.finally:
	popa
	ret

;Message
greeting db 'Hello, World!', 0
system db 'Basic Operating System', 0

;System Value
newline db 0x0A, 0x0D, 0

times 510-($-$$) db 0

dw 0xAA55