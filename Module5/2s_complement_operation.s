    .data
    input:  .word 10   // Input value
    output: .word 0    // Output value (negative)

    .text
    .global _start

_start:
    LDR r0, =input      // Load input
    LDR r1, [r0]        // Load the value

    MVN r1, r1          // One's complement
    ADD r1, r1, #1      // Two's complement (add 1)

    LDR r0, =output     // Store the result
    STR r1, [r0]

    // Exit program
    MOV r7, #1
    SWI 0
