 .org $8000
 
 .org $8009
    lda #$1f
    sta $4015
    lda #$00
    sta $4010
    ldx #$00
    lda #$00
clrloop1:    
    sta $0700,x
    inx
    bne clrloop
    lda #$10
    sta $4000
    sta $4004
    sta $400c
    lda #$00
    sta $4008
    lda #$0f
    sta $4015
    lda #$00
    ldx #$07
clrloop2:
    sta $0702,x
    dex
    bpl clrloop2
    ldx #$01
clrloop3:
    sta $07da
    dex
    bpl clrloop3    
    rts
 
 .org $c000
start:
    sei
    ldx #$ff
    txs
    lda #$00
    sta $2000
    sta $2001
    ldx #$02
vwait1:    
    bit $2002
    bpl vwait1
vwait2:    
    bit $2002
    bmi vwait2
    dex
    bne vwait1 
    lda #$00
    sta $4010
    lda #$1f
    sta $4015
    lda #$c0
    sta $4017
    lda #$01
    sta $d0
    lda #$06
    sta $fe
    sta $2001
    jsr mmc1setup
    lda #$00
    sta $f1
    sta $f6
    sta $d2
    sta $d3
    sta $d6
    sta $f0
    lda #$ff
    sta $0101
    lda #$05
    jsr loadprgbank ;go to bank 5
    jsr $8009
    lda #$00
    sta $016f
    lda #$b0
    sta $ff
    sta $2000
    jsr c8b2
    lda #$01
    jsr c906
    jsr c8ed
    jsr cb70
    jmp c09a
1c070



 .org $c09a
 
c09a:
    lda #$03
    sta $bd
    lda #$01
    jsr c6ed
    jsr b300
    nop
    nop
    nop
    jsr c8f8
    jsr de14
    jsr ddf3
    jsr da4b
    lda #$03
    sta $d0
    jsr d78b
    lda $0153
    beq 08
    lda #$06
    jsr c6ed
    jsr a65f
    jsr c8e2
    lda $d7
    bne 08
    lda $02
    jsr c959
    jmp c0dd
    
c0dd:
    jsr cbee
    jsr c137
    jsr c302
    lda $f8
    bne 0c
    jsr c11d
    jsr c21f
    jsr c1dc
    jmp c0fb



 
mmc1setup: ;c6d7
    lda #$1e ;two 4kb chr banks, fixed upper 16k bank, vertical mirroring
    sta $9fff
    lsr a
    sta $9fff
    lsr a 
    sta $9fff
    lsr a
    sta $9fff
    lsr a
    sta $9fff
    rts
    
    
    
loadprgbank:    
    sta $f1
    lda #$ff
    sta $b6
    lda $f1
    sta $ffff
    lsr a
    sta $ffff
    lsr a
    sta $ffff
    lsr a
    sta $ffff
    lsr a
    sta $ffff
    lda #$00
    sta $b6
    rts
    
    
    
c70d:  



c739:



c8b2:
    lda #$55
    sta $f9
.loop
    lda $f9
    bne .loop
    rts
    
    
    
c8bb:
    lda #$55
    sta $f9
    lda #$ff
    sta $f0
.loop   
    lda $f9
    bne .loop
    dex
    bne .skip
    lda #$ff
    sta $f9
    lda #$ff
    sta $0
.loop2    
    lda $f9
    bne .loop2
    dex
    bne .loop
.skip   
    rts
    
    
    
c8ed:
    jsr c8b2
    lda #$00
    sta $fe
    sta $2001
    rts

    
    
c906:
    ldx #$ff
    stx $0154
    sta $f7
    tax
    jsr c8bb
    ldy #$04
.loop
    tya
    pha
    jsr c923
    ldx $f7
    jsr c8bb
    pla
    tay
    dey
    bne .loop
    rts
    
    
    
cb70:
    lda $0519
    pha
    lda #$00
    sta $06bf
    tax
.loop
    sta $00,x
    inx
    cpx #$f0
    bne .loop
    tax
.loop2    
    sta $0100
    inx
    cpx #$f0
    bne .loop2
    lda #$02
    sta $01
    lda #$00
    sta $00
    ldy #$00
    ldx #$06
.loop3    
    sta [$00],y
    iny
    bne .loop3
    inc $01
    dex
    bne .loop3
    pla 
    sta $0519
    lda #$ff
    sta $0101
    lda #$00
    sta $f1
    sta $f6
    sta $d2
    sta $d3
    sta $d6
    sta $f0
    lda #$01
    sta $d0
    lda #$00
    sta $fd
    sta $fc
    sta $f8
    jsr c739
    lda #$3f
    sta $2006
    lda #$00
    sta $2006
    ldx #$1f
    lda #$0f
.loop4    
    sta $2007
    sta $0180,x
    dex
    bpl .loop4
    lda #$3f
    sta $2006
    lda #$00
    sta $2006
    sta $2006
    sta $2006
    rts
    
    
    
 .org $fff3
irq:
reset:
    sei
    inc $fff2
    jmp start
  
 .org $fffa
  .dw nmi
  .dw reset
  .dw irq
