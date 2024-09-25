    .data
    feet_input:   .word 5     // Feet input
    inches_input: .word 8     // Inches input
    result:       .word 0     // Output total inches

    .text
    .global _start

_start:
    LDR r0, =feet_input       // Load feet input
    LDR r1, [r0]              // Load the value of feet

    MOV r2, #12               // Multiplication factor (12 inches in a foot)
    MUL r1, r1, r2            // r1 = feet * 12

    LDR r0, =inches_input     // Load inches input
    LDR r2, [r0]              // Load the value of inches

    ADD r1, r1, r2            // r1 = feet * 12 + inches

    LDR r0, =result           // Store the result
    STR r1, [r0]

    // Exit program
    MOV r7, #1
    SWI 0
