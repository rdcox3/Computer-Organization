    .data
    reg0: .word 15
    reg1: .word 10

    .text
    .global _start

_start:
    LDR r0, =reg0          // Load first register value
    LDR r1, [r0]           // Load the value of reg0 into r1

    LDR r2, =reg1          // Load second register value
    LDR r3, [r2]           // Load the value of reg1 into r3

    EOR r1, r1, r3         // r1 = r1 XOR r3
    EOR r3, r1, r3         // r3 = r1 XOR r3 (now r3 contains the value of r0)
    EOR r1, r1, r3         // r1 = r1 XOR r3 (now r1 contains the value of r1)

    STR r1, [r0]           // Store swapped values
    STR r3, [r2]

    // Exit program
    MOV r7, #1
    SWI 0
