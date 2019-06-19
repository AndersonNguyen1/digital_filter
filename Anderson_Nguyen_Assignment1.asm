org 50H ; set location counter
ARRAY1: db 10, 5, 120,255, 240, 70, 40, 255 ; array a
org 60H ; set location counter
ARRAY2: db 5, 20, 2, 50, 100, 240, 250, 200 ; array x
org 0
mov r0, #8h
mov r1, #0
mov r3, #0
mov r4, #0
mov r5, #0
mov dptr, #0h
mov r6, #50h ; store initial addr
mov r7, #60h ; store initial addr

start:
mov A, #0
mov B, #0

; access element from array 1
mov A, r6
movc A, @A+dptr
mov B, A

; access element from array 2
mov A, r7
movc A, @A+dptr
mul AB

; jumps if adding A and r3 results in a carry bit
add A, r3
jc carry1

; restart1 stores result of A+r3 and adds the 8 higher bits of mul to r4
restart1:
mov r3, A
mov A, B
add A, r4
jc carry2 ; jumps if r4+A has carry bit

; restart2 stores result of A+r4 and increments addr
restart2:
mov r4, A
inc r6
inc r7
mov A, r0

; if r0 > 0,go back to start
djnz r0, start
mov A, #0
jz finish

carry1:
inc r4
clr C
jnc restart1

carry2:
inc r5
clr C
jnc restart2

finish:
end







