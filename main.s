@ main.s - Main program to test conversion functions
@ Author: Ron Cox
@ Date: 2024-10-20

.global _start

.equ SYSCALL_READ, 0x3
.equ SYSCALL_WRITE, 0x4
.equ SYSCALL_EXIT, 0x1

@ Buffers for input and output
.bss
buffer: .space 32

.text
_start:
    @ Prompt and read miles
    ldr r7, =SYSCALL_WRITE
    mov r0, #1
    ldr r1, =prompt_miles
    mov r2, #20
    svc #0

    ldr r7, =SYSCALL_READ
    mov r0, #0
    ldr r1, =buffer
    mov r2, #32
    svc #0
    bl atoi                    @ Convert input to integer (miles in r0)

    @ Store miles in r4
    mov r4, r0

    @ Prompt and read hours
    ldr r7, =SYSCALL_WRITE
    mov r0, #1
    ldr r1, =prompt_hours
    mov r2, #20
    svc #0

    ldr r7, =SYSCALL_READ
    mov r0, #0
    ldr r1, =buffer
    mov r2, #32
    svc #0
    bl atoi                    @ Convert input to integer (hours in r0)

    @ Store hours in r5
    mov r5, r0

    @ Call kph function
    mov r0, r5                 @ Load hours into r0
    mov r1, r4                 @ Load miles into r1
    bl kph                     @ Call kph function

    @ Print result (kph)
    bl itoa                    @ Convert integer result to string
    ldr r7, =SYSCALL_WRITE
    mov r0, #1
    ldr r1, =buffer
    mov r2, #32
    svc #0

    @ Exit program
    ldr r7, =SYSCALL_EXIT
    mov r0, #0
    svc #0

@ Helper function: atoi - Converts string to integer
atoi:
    push {r4, lr}              @ Save registers
    mov r4, #0                 @ Initialize result
atoi_loop:
    ldrb r1, [r0], #1          @ Load byte from string and increment pointer
    cmp r1, #'0'               @ Check if character is a digit
    blt atoi_done              @ If not, exit loop
    cmp r1, #'9'
    bgt atoi_done              @ If not, exit loop
    sub r1, r1, #'0'           @ Convert ASCII to integer
    mul r4, r4, #10            @ Shift left by 10 (multiply by 10)
    add r4, r4, r1             @ Add digit to result
    b atoi_loop                @ Repeat for next character
atoi_done:
    mov r0, r4                 @ Store result in r0
    pop {r4, pc}               @ Restore registers and return

@ Helper function: itoa - Converts integer to string
itoa:
    push {r4, lr}              @ Save registers
    mov r4, r0                 @ Store integer in r4
    ldr r0, =buffer            @ Load buffer address
itoa_loop:
    mov r1, r4                 @ Load integer into r1
    mov r2, #10
    udiv r1, r1, r2            @ Divide by 10
    mls r2, r1, #10, r4        @ Compute remainder
    add r2, r2, #'0'           @ Convert integer to ASCII
    strb r2, [r0], #1          @ Store character in buffer and increment pointer
    cmp r1, #0
    bne itoa_loop              @ Repeat until all digits are processed
    mov r0, #0
    strb r0, [r0]              @ Null-terminate string
    pop {r4, pc}               @ Restore registers and return

.data
prompt_miles: .asciz "Enter miles: "
prompt_hours: .asciz "Enter hours: "
