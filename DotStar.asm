.local
.nestmodules
.module dotstar

.include "spi.asm"

.varloc saveSScreen, 768
.var byte[NUM_LEDS*3], leds

init:
      call spi.init
      call clear
      call show
      ret

;Inputs:
;b = led
;c = red, d = green, e = blue
set_led:
    ld hl, leds
    push de
        ld d, 0 \ ld e, b \ add hl, de \ add hl, de \ add hl, de
    pop de
    ld (hl), e \ inc hl
    ld (hl), d \ inc hl
    ld (hl), c
    ret

show:
    push bc
        ld hl, leds
        ld c, $00 \ ld b, 4 \ call spi.write \ djnz $-3 ; send $00 out 4 times
        ld b, NUM_LEDS
        ld c, $FF
@:
        push bc
            ld b, 3
            call spi.write
@:
            ld c, (hl)
            call spi.write
            inc hl
            djnz {@-1}
        pop bc
        djnz {@-2}
        ld c, $FF \ ld b, 4 \ call spi.write \ djnz $-3 ; send $FF out 4 times
    pop bc
    ret

shift:
    push bc \ push de
    ld hl, leds + NUM_LEDS*3 - 1
    ld de, leds + NUM_LEDS*3 + 2
    ld bc, sizeof(leds)
    lddr
    pop de \ pop bc
    ret

clear:
    push bc \ push de
    ld a, 0
    ld (leds), a
    ld hl, leds
    ld de, leds + 1
    ld bc, sizeof(leds) - 1
    ldir
    pop de \ pop bc
    ret

free .equ spi.free

.endmodule
