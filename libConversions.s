@ libConversions.s - ARM Assembly conversion functions
@ Author: Ron Cox
@ Date: 2024-10-20

.global miles2kilometer
.global kph
.global CToF
.global InchesToFt

@ miles2kilometer(int miles)
@ Converts miles to kilometers using integer math.
@ Formula: kilometers = (miles * 161) / 100
@ We multiply by 161 to approximate 1 mile = 1.60934 km.
@ Dividing by 100 keeps the precision manageable for integer operations.
@ Greater precision can be achieved by using larger multipliers or shifting right instead of dividing.
miles2kilometer:
    push {lr}                @ Save return address
    mov r1, #161             @ Load multiplier 161 into r1
    mul r0, r0, r1           @ r0 = miles * 161
    mov r1, #100             @ Load divisor 100 into r1
    udiv r0, r0, r1          @ r0 = (miles * 161) / 100
    pop {pc}                 @ Return

@ kph(int hours, int miles)
@ Converts miles to kilometers using miles2kilometer function, then calculates speed in kph.
kph:
    push {lr}                @ Save return address
    bl miles2kilometer       @ Call miles2kilometer with r0 as miles
    mov r1, r0               @ Store result (kilometers) in r1
    mov r2, r0               @ Load hours into r2 (passed in r0)
    udiv r0, r1, r2          @ r0 = kilometers / hours
    pop {pc}                 @ Return

@ CToF(int celsius)
@ Converts Celsius to Fahrenheit.
@ Formula: Fahrenheit = (Celsius * 9 / 5) + 32
CToF:
    push {lr}                @ Save return address
    mov r1, #9               @ Load multiplier 9
    mul r0, r0, r1           @ r0 = Celsius * 9
    mov r1, #5               @ Load divisor 5
    udiv r0, r0, r1          @ r0 = (Celsius * 9) / 5
    add r0, r0, #32          @ Add 32 to result
    pop {pc}                 @ Return

@ InchesToFt(int inches)
@ Converts inches to feet.
@ Formula: feet = inches / 12
InchesToFt:
    push {lr}                @ Save return address
    mov r1, #12              @ Load divisor 12
    udiv r0, r0, r1          @ r0 = inches / 12
    pop {pc}                 @ Return
