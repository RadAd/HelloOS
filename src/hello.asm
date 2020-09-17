.8086
.model tiny

.data
hello_str db "Hello World!", 0

.code
org 0000h

main PROC
    mov ax, cs
    mov ds, ax
    mov es, ax
    cld

IF 0
    mov ah, 00h             ; BIOS Sets the video display mode
    mov al, 03h             ; Mode Text 80x25 16-color
    int 10h
ENDIF

IF 0
    mov ah, 11h             ; BIOS Text mode chargen
    mov al, 12h             ; Load 8x8 font for 80x50 mode
    xor bx, bx
    int 10h
ENDIF
    
    mov si, offset hello_str
    call print_string
    
    ; End with a HLT loop
    cli
endloop:
    hlt
    jmp endloop
main ENDP

; Function: print_string
;           Display a string to the console on display page 0
;
; Inputs:   SI = Offset of address to print
; Clobbers: AX, BX, SI

print_string PROC
    mov ah, 0eh             ; BIOS tty Print
    xor bx, bx              ; Set display page to 0 (BL)
    jmp getch
chloop:
    int 10h                 ; print character
getch:
    lodsb                   ; Get character from string
    test al,al              ; Have we reached end of string?
    jnz chloop              ;     if not process next character

    ret
print_string ENDP

END main
