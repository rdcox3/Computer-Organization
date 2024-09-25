    .data
    input:   .word 6       // Input number
    result:  .word 0       // Output result (input * 10)

    .text
    .global _start

_start:
    LDR r0, =input         // Load input value
    LDR r1, [r0]           // Load the value into r1

    LSL r2, r1, #3         // r2 = input * 8 (left shift by 3)
    LSL r3, r1, #1         // r3 = input * 2 (left shift by 1)
    ADD r1, r2, r3         // r1 = input * 10 (input * 8 + input * 2)

    LDR r0, =result        // Store the result
    STR r1, [r0]

    // Exit program
    MOV r7, #1
    SWI 0
