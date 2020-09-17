DISK_RETRIES EQU 3

.8086
.model tiny

IFDEF WITH_BPB
    include bpb.inc
ENDIF

.code
org 7c00h

main PROC

IFDEF WITH_BPB
    jmp short start
    nop
    bpb bpb_s<>
ENDIF

start:
    xor ax, ax                 ; AX=0
    mov ds, ax                 ; DS=0
;   cli                        ; Only need STI/CLI around SS:SP change on buggy 8088
    mov ss, ax                 ; SS:SP = 0000h:7c00h
    mov sp, 7c00h
;   sti

    mov ax, 1000h              ; Reading sectors into memory address (ES:BX) 1000h:0000h
    mov es, ax                 ; ES=1000h
    xor bx, bx                 ; BX=0000h
    mov cx, 0002               ; From cylinder #0
                               ; Starting from sector #2
    mov dh, 00h                ; Using head #0
    mov si, DISK_RETRIES+1     ; Retry count
    jmp read                   ; Jump to reading (don't need reset first time)

reset:
    dec si                     ; Decrement retry count
    jz error                   ; If zero we reached the retry limit, goto error
    mov ah, 0h                 ; If not, reset the drive before retrying operation
    int 13h

read:
    mov ax, 0201h              ; BIOS disk read function
                               ; Reading 1 sector
    int 13h                    ; BIOS disk read call
                               ;     This call only clobbers AX
    jc reset                   ; If error reset drive and try again

    ; Early versions of MASM don't support FAR JMP syntax like 'jmp 1000h:0000h'
    ; Manually encode the FAR JMP instruction
    db 0eah                    ; 0EAh is opcode for a FAR JMP
    dw 0000h, 1000h            ; 0000h = offset, 1000h segment of the FAR JMP

; Error - end with HLT loop or you could use 'jmp $' as an infinite loop
error:
    cli
endloop:
    hlt
    jmp endloop

main ENDP

; Boot sector data between code and boot signature.
; Don't put in data section as the linker will place that section after boot sig

org 7c00h+510                  ; Pad out boot sector up to the boot sig
dw 0aa55h                      ; Add boot signature

END main
