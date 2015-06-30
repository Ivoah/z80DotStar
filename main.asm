.binarymode TI8X
.variablename DOTSTAR

#include "ti83plus.inc"

#define NUM_LEDS 5

.org userMem - 2
.db $BB,$6D

start:
      call dotstar.init
      ld a, $FF
      out (1), a
      ld a, $FD
      out (1), a
loop:
      in a, (1) ;loop code
      bit 6, a
      jp nz, loop
      call dotstar.end
      ret

#include "DotStar.asm"

.global
