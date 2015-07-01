;TI-8x+ SPI library
;Copyright 2015 Noah Rosamilia

.module spi

init:
      di
      ld a, 3
      out (0), a
      ret

;Tip is data and sleeve is clock
;Inputs:
;c: byte to write
write:
      push bc
            ld b, 8
@:
            bit 7, c
            jr nz, {@}

            ld a, %00000010
            out (0), a
            jr {@+2}
@:
            ld a, %00000011
            out (0), a
@:
            in a, (0)
            res 1, a
            out (0), a

            sla c
            djnz {@-3}
      pop bc
      ret

free:
      ld a, 0
      out (0), a
      ei
      ret

.endmodule
