.model small
.stack 100h
.data
    angka db ?
    pesan db 0Dh,0Ah,'+-----------------------------+',0Dh,0Ah,'| Tebak angka antara 1 dan 9  |',0Dh,0Ah,'| (0 untuk keluar)            |',0Dh,0Ah,'+-----------------------------+',0Dh,0Ah,'Jawaban Anda: $'
    benar db 0Dh,0Ah,'+-----------------------------+',0Dh,0Ah,'| Selamat, tebakan Anda benar! |',0Dh,0Ah,'+-----------------------------+$'
    salah db 0Dh,0Ah,'+-----------------------------+',0Dh,0Ah,'| Maaf, tebakan Anda salah.    |',0Dh,0Ah,'+-----------------------------+$'
    keluar db 0Dh,0Ah,'+-----------------------------+',0Dh,0Ah,'| Terima kasih telah bermain!  |',0Dh,0Ah,'+-----------------------------+$'
.code
main proc
    mov ax, @data
    mov ds, ax

mulai:
    mov ah, 09h
    lea dx, pesan
    int 21h

    mov ah, 01h
    int 21h
    sub al, 30h
    cmp al, 0
    je selesai

    mov angka, al
    call random
    cmp al, angka
    jne tebak_salah

    mov ah, 09h
    lea dx, benar
    int 21h
    jmp mulai

tebak_salah:
    mov ah, 09h
    lea dx, salah
    int 21h
    jmp mulai

selesai:
    mov ah, 09h
    lea dx, keluar
    int 21h

    mov ax, 4C00h
    int 21h
main endp

random proc
    mov ah, 2Ch
    int 21h
    mov al, dh
    and al, 0Fh
    add al, 1
    xor ah, ah
    mov bh, 9
    div bh
    add al, 1
    ret
random endp

end main
