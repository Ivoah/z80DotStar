.binarymode TI8X
.variablename DOTSTAR

.define NUM_LEDS 5
.define led(num, red, green, blue) ld b, num \ ld c, red \ ld d, green \ ld e, blue \ call dotstar.set_led

.nolist
.include "ti83plus.inc"
.include "dcs7.inc"
.list

.org userMem - 2
.db $BB,$6D

start:
    call dotstar.init
    OpenGUIStack()
    PushGUIStacks(GUIStack)
    GUIMouse(0)

show_leds:
    MouseRecover()
    GUIFindFirst()
    push hl \ push de
        led(0, (hl), (hl), (hl))
        dotstar.show_leds
    pop de \ hl
    GUIMouse(0)

quit:
    MouseRecover()
    CloseGUIStack()
    call dotstar.clear
    call dotstar.show
    call dotstar.free
    ret

should_quit:
    .db 0

GUIStack:
    .dw {@} - GUIStack
    .db GUIRSmallWin
    .db 5, 5
    .db $70,$88,$88,$88,$70
    .db "Adafruit DotStar",0
@:
    .dw {@} - {@-1}
    .db GUIRWordInt
    .db 1, 1
    .db 127, 0, 255
@:
    .dw {@} - {@-1}
    .db GUIRWordInt
    .db 1, 9
    .db 127, 0, 255
@:
    .dw {@} - {@-1}
    .db GUIRWordInt
    .db 1, 17
    .db 127, 0, 255
@:
    .dw {@} - {@-1}
    .db GUIRButtonText
    .db 1, 25
    .dw show_leds
    .db "Show", 0
@:
    .dw {@} - {@-1}
    .db GUIRButtonText
    .db 25, 25
    .dw quit
    .db "Quit", 0
@:
    .db $FF, $FF

.include "DotStar.asm"

.global
