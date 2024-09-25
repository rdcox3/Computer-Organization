    .data
    F_input:   .word 77   // Input Fahrenheit value
    C_output:  .word 0    // Output Celsius value

    .text
    .global _start

_start:
    LDR r0, =F_input     // Load Fahrenheit input
    LDR r1, [r0]         // Load the value of Fahrenheit

    SUB r1, r1, #32      // r1 = F - 32

    MOV r2, #5           // Load multiplier 5
    MUL r1, r1, r2       // r1 = (F - 32) * 5

    MOV r2, #9           // Load divisor 9
    SDIV r1, r1, r2      // r1 = ((F - 32) * 5) / 9

    LDR r0, =C_output    // Store the result in C_output
    STR r1, [r0]

    // Exit program
    MOV r7, #1           // syscall for exit
    SWI 0
