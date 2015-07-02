.binarymode TI8X
.variablename DOTSTAR

.define NUM_LEDS 5
.define led(num, red, green, blue) ld b, num \ ld c, red \ ld d, green \ ld e, blue \ call dotstar.set_led

.define CSE

.ifdef CSE
.include "ti84pcse.inc"
.else
.include "ti83plus.inc"
.endif

.org userMem - 2
.ifdef CSE
.db tExtTok, tAsm84CCmp
.else
.db $BB,$6D
.endif

start:
    call dotstar.init
    ld a, $FF
    out (1), a
    ld a, $FD
    out (1), a

    led(0, $FF, $00, $00)
    led(1, $00, $FF, $00)
    led(2, $00, $00, $FF)
    led(3, $00, $FF, $00)
    led(4, $FF, $00, $00)
    call dotstar.show
loop:
    in a, (1) ;loop code
    bit 6, a
    jr nz, loop
    call dotstar.free
    ret

.include "DotStar.asm"

.global
