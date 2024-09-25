    .data
    C_input:   .word 25   // Input Celsius value
    F_output:  .word 0    // Output Fahrenheit value

    .text
    .global _start

_start:
    LDR r0, =C_input     // Load Celsius input
    LDR r1, [r0]         // Load the value of Celsius

    MOV r2, #9           // Load multiplier 9
    MUL r1, r1, r2       // r1 = C * 9

    MOV r2, #5           // Load divisor 5
    SDIV r1, r1, r2      // r1 = (C * 9) / 5

    ADD r1, r1, #32      // r1 = (C * 9 / 5) + 32

    LDR r0, =F_output    // Store the result in F_output
    STR r1, [r0]

    // Exit program
    MOV r7, #1           // syscall for exit
    SWI 0
