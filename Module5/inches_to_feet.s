    .data
    inches_input:   .word 68   // Total inches input
    feet_output:    .word 0    // Feet result
    inches_output:  .word 0    // Inches result

    .text
    .global _start

_start:
    LDR r0, =inches_input     // Load input in inches
    LDR r1, [r0]              // Load the value of total inches

    MOV r2, #12               // Divisor (12 inches in a foot)

    // Divide r1 by 12 to get feet, remainder to get inches
    MOV r3, #0                // Initialize feet counter
loop:
    CMP r1, r2                // Compare inches with 12
    BLT done                  // If inches < 12, go to done

    SUB r1, r1, r2            // Subtract 12 from inches
    ADD r3, r3, #1            // Increment feet
    B loop                    // Repeat until inches < 12

done:
    LDR r0, =feet_output      // Store feet result
    STR r3, [r0]

    LDR r0, =inches_output    // Store remaining inches
    STR r1, [r0]

    // Exit program
    MOV r7, #1
    SWI 0
