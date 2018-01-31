@@@ curr[64] --arr ; (8*i+j)*4
                                     @@ count - r12

ldr r0,=curr
          @ r1-i ; r2-j ; r3-current pointer
mov r1,#0
mov r2,#0
mov r3,#0
                                 @r4 may be used as loading reg

@--
mov r1,#-1
ForI:
    mov r2,#0
    add r1,r1,#1
    cmp r1,#8
    blt ForJ
    bge ForKeBaad
ForJ:

     mov r3,r1
    mov r7,#8
    mov r6,r3
    mul r3,r6,r7
    add r3,r3,r2
    mov r7,#4
    mov r6,r3
    mul r3,r6,r7
               ldr r7,=curr
               add r3,r3,r7
               mov r7,#0
               str r7,[r3]               
    add r2,r2,#1
    mov r7,#8
    cmp r2,r7
    blt ForJ
    bge ForI
@--

ForKeBaad:
ldr r0,=curr
add r0,r0,#108  @---3,3---
mov r4,#2
str r4,[r0]
add r0,r0,#36   @--4,4---
str r4,[r0]
mov r4,#1
sub r0,r0,#4  @--4,3--
str r4,[r0]
sub r0,r0,#28  @---3,3--
str r4,[r0]

ldr r0,=score1
mov r4,#2
str r4,[r0]
ldr r0,=score2
str r4,[r0]

mov r4,#0
ldr r0,=full
str r4,[r0]
ldr r0,=winner
str r4,[r0]

mov r12,#4  @@---represents COUNT----



@@@@@@ 'PRINT HERE STARTING scores '
mov r0,#0
mov r1,#13
ldr r2,=player1
swi 0x204
mov r0,#10
mov r1,#13
ldr r3,=score1
ldr r2,[r3]
swi 0x205

mov r0,#18
mov r1,#13
ldr r2,=player2
swi 0x204
mov r0,#29
mov r1,#13
ldr r3,=score2
ldr r2,[r3]
swi 0x205

Whileloop:

@@@@'SCANNING HERE X Y CHANCE *may be stored or directly used*'

@ I'm ssuming tune chance r11 mein rakha hai'
@ and x => r9, y => r10

INPUTCHANCE: 
swi 0x203
cmp r0,#0
beq INPUTCHANCE
cmp r0, #2
beq IPp1

cmp r0, #4
beq IPp2

cmp r0,#4
bgt IPp3

IPp1:
mov r11, #1
b INPUTX

IPp2:
mov r11, #2
b INPUTX

IPp3:
b invalid


@--------------------------------------

INPUTX:
swi 0x203
cmp r0,#0
beq INPUTX

cmp r0, #1
beq IPx1

cmp r0, #2
beq IPx2

cmp r0, #4
beq IPx3

cmp r0, #8
beq IPx4

cmp r0, #16
beq IPx5

cmp r0, #32
beq IPx6

cmp r0, #64
beq IPx7

cmp r0, #128
beq IPx8

cmp r0, #128
bgt invalid


IPx1:
mov r9, #0
b INPUTY


IPx2:
mov r9, #1
b INPUTY

IPx3:
mov r9, #2
b INPUTY

IPx4:
mov r9, #3
b INPUTY

IPx5:
mov r9, #4
b INPUTY

IPx6:
mov r9, #5
b INPUTY

IPx7:
mov r9, #6
b INPUTY

IPx8:
mov r9, #7
b INPUTY


@----------------------------------------

INPUTY:
swi 0x203
cmp r0,#0
beq INPUTY

cmp r0, #1
beq IPy1

cmp r0, #2
beq IPy2

cmp r0, #4
beq IPy3

cmp r0, #8
beq IPy4

cmp r0, #16
beq IPy5

cmp r0, #32
beq IPy6

cmp r0, #64
beq IPy7

cmp r0, #128
beq IPy8

cmp r0, #128
bgt invalid

IPy1:
mov r10, #0
b b4keepon
IPy2:
mov r10, #1
b b4keepon
IPy3:
mov r10, #2
b b4keepon
IPy4:
mov r10, #3
b b4keepon

IPy5:
mov r10, #4
b b4keepon

IPy6:
mov r10, #5
b b4keepon

IPy7:
mov r10, #6
b b4keepon

IPy8:
mov r10, #7
b b4keepon










b4keepon:

@@@@'x- r9 ; y-r10 ; chance-r11 ; count - r12'


ldr r0,=curr
      mov r1,r9      @now both r1 r9 have val[x]
      mov r7,#8
      mov r6,r1
      mul r1,r6,r7
      add r1,r1,r10             @ 8x+y 
      mov r7,#4
      mov r6,r1
      mul r1,r6,r7             @4(8x+y)
      mov r2,r1
      add r2,r2,r0        @r2 have addr curr[x][y]
      ldr r4,[r2]         @NOW R4 have val(curr[x][y])
      mov r1,#0     

cmp r4,r1              @if loop
bne invalid

b Elsestartmain

 invalid:
          mov r0,#14
          mov r1,#14
          ldr r2,=invalidstatement
          swi 0x204
        @@@'PRINT-NOT A VALID CHOICE'
        b nexti

Elsestartmain:
                 @pls dont change addr of r2 here
  str r11,[r2]
  add r12,r12,#1
      mov r4,#64
      cmp r12,r4
      bne keepon
        ldr r0,=full
        mov r4,#1
        str r4 ,[r0]

keepon:
         @@@@'all funcs-up/down kinda will be here'@@@

ldr r0,=curr     
      mov r2,r9 @now both r2 r9 have val[x]
      mov r7,#8
      mov r6,r2
      mul r2,r6,r7
      add r2,r2,r10             @ 8x+y 
      mov r7,#4
      mov r6,r2
      mul r2,r6,r7             @4(8x+y)
      add r2,r2,r0
      ldr r4,[r2]        @'NOW R4 have val(curr[x][y]) '
     
ldr r0,=curr


UP:     
@ r1-i|r4-curr[x][y]|r3-diff |r5-'loading' | r2-curr

mov r1,r10
add r1,r1,#1 @y+1

forup:

mov r5,r9
mov r7,#8
mov r6,r5
mul r5,r6,r7 @8x
add r5,r5,r1
mov r7,#4
mov r6,r5
mul r5,r6,r7
ldr r7,=curr
add r5,r5,r7    @@---r5=addr (curr[x][i])
ldr r2,[r5] @@----now r2=val(curr[x][i])

mov r7,#0
cmp r2,r7
beq DOWN
cmp r2,r4
bne forcondup

mov r3,r1
sub r3,r3,r10
sub r3,r3,#1
mov r7,#0
cmp r3,r7
ble DOWN
  
  whileup:
          mov r5,r9
  mov r7,#8
  mov r6,r5
  mul r5,r6,r7   @8x
  add r5,r5,r10
  add r5,r5,r3
  mov r7,#4
    mov r6,r5
  mul r5,r6,r7
  ldr r7,=curr
  add r5,r5,r7    @@---r5=addr (curr[x][y+diff])
  
  str r11,[r5]
  sub r3,r3,#1
  mov r7,#0
  cmp r3, r7
  bgt whileup
b DOWN

forcondup:
add r1,r1,#1
mov r7,#8
cmp r1,r7
blt forup


DOWN:
@ r1-i|r4-curr[x][y]|r3-diff |r5-'loading' | r2-curr

mov r1,r10
sub r1,r1,#1 @y+1

Fordown:

mov r5,r9
mov r7,#8
  mov r6,r5
mul r5,r6,r7 @8x
add r5,r5,r1
mov r7,#4
  mov r6,r5
mul r5,r6,r7
ldr r7,=curr
add r5,r5,r7    @@---r5=addr (curr[x][i])
ldr r2,[r5] @@----now r2=val(curr[x][i])

mov r7,#0
cmp r2,r7
beq LEFT
cmp r2,r4
bne forconddown

mov r3,r10
sub r3,r3,r1
sub r3,r3,#1
mov r7,#0
cmp r3,r7
ble LEFT
  
  whiledown:
          mov r5,r9
  mov r7,#8
    mov r6,r5
  mul r5,r6,r7   @8x
  add r5,r5,r10
  sub r5,r5,r3
  mov r7,#4
    mov r6,r5
  mul r5,r6,r7
  ldr r7,=curr
  add r5,r5,r7    @@---r5=addr (curr[x][y-diff])
  
  str r11,[r5]
  sub r3,r3,#1
  mov r7,#0
  cmp r3, r7
  bgt whiledown
b LEFT

forconddown:
sub r1,r1,#1
mov r7,#0
cmp r1,r7
bge Fordown




LEFT:
@ r1-i|r4-curr[x][y]|r3-diff |r5-'loading' | r2-curr

mov r1,r9
sub r1,r1,#1 @x-1

Forleft:

mov r5,r1
mov r7,#8
  mov r6,r5
mul r5,r6,r7 @8x
add r5,r5,r10
mov r7,#4
  mov r6,r5
mul r5,r6,r7
ldr r7,=curr
add r5,r5,r7    @@---r5=addr (curr[i][y])
ldr r2,[r5] @@----now r2=val(curr[i][y])

mov r7,#0
cmp r2,r7
beq RIGHT
cmp r2,r4
bne forcondleft

mov r3,r9
sub r3,r3,r1
sub r3,r3,#1
mov r7,#0
cmp r3,r7
ble RIGHT
  
  whileleft:
          mov r5,r9
          sub r5,r5,r3
  mov r7,#8
    mov r6,r5
  mul r5,r6,r7   @8x
  add r5,r5,r10

  mov r7,#4
    mov r6,r5
  mul r5,r6,r7
  ldr r7,=curr
  add r5,r5,r7    @@---r5=addr (curr[x-diff][y])
  
  str r11,[r5]
  sub r3,r3,#1
  mov r7,#0
  cmp r3, r7
  bgt whileleft
b RIGHT

forcondleft:
sub r1,r1,#1
mov r7,#0
cmp r1,r7
bge Forleft





RIGHT:
@ r1-i|r4-curr[x][y]|r3-diff |r5-'loading' | r2-curr

mov r1,r9
add r1,r1,#1 @x+1

Forright:

mov r5,r1
mov r7,#8
  mov r6,r5
mul r5,r6,r7 @8x
add r5,r5,r10
mov r7,#4
  mov r6,r5
mul r5,r6,r7
ldr r7,=curr
add r5,r5,r7    @@---r5=addr (curr[i][y])
ldr r2,[r5] @@----now r2=val(curr[i][y])

mov r7,#0
cmp r2,r7
beq UPRIGHT
cmp r2,r4
bne forcondright

mov r3,r1
sub r3,r3,r9
sub r3,r3,#1
mov r7,#0
cmp r3,r7
ble UPRIGHT
  
  whileright:
          mov r5,r9
          add r5,r5,r3
  mov r7,#8
    mov r6,r5
  mul r5,r6,r7   @8x
  add r5,r5,r10

  mov r7,#4
    mov r6,r5
  mul r5,r6,r7
  ldr r7,=curr
  add r5,r5,r7    @@---r5=addr (curr[x+diff][y])
  
  str r11,[r5]
  sub r3,r3,#1
  mov r7,#0
  cmp r3, r7
  bgt whileright
b UPRIGHT

forcondright:
add r1,r1,#1
mov r7,#8
cmp r1,r7
blt Forright




UPRIGHT:        @r0-i | xcopy-r1 | val(cur[xcopy][i])-r2 |diff-r3 |r4-valcurr[x][y] 
                

                    mov r0,r10
                    add r0,r0,#1   @y+1
                    mov r1,r9      @xcopy=x

         Forupright:
         add r1,r1,#1
         mov r3,#8
         cmp r1,r3            @ 1st if 
         beq UPLEFT
         @r3|r2|r5|r7|r8|
         mov  r5,r1 
         mov r7,#8
           mov r6,r5
         mul r5,r6,r7    @(8*xcopy)
         add r5,r5,r0
         mov r7,#4
           mov r6,r5
         mul r5,r6,r7
         ldr r7,=curr
         add r5,r5,r7  @r5 =addr(curr[xcopy][i])
          ldr r2,[r5]
         mov r3,#0

         cmp r2,r3            @2nd if
         beq UPLEFT

         cmp r2,r4                  @3rd if 
         bne forcondupright      

               mov r3,r0 @diff
               sub r3,r3,r10
               sub r3,r3,#1
               mov r6,#0
                cmp r3,r6      @while loop condition
                ble afterwhileupr
         whileupright:
@-----------------------------------------------
     
      mov r5,r9          @now both r5 r9 have val[x]
      add r5,r5,r3
      mov r7,#8
        mov r6,r5
      mul r5,r6,r7
      add r5,r5,r3
      add r5,r5,r10             @ 8x+y 
      mov r7,#4
        mov r6,r5
      mul r5,r6,r7             @4(8x+y)
      ldr r7,=curr
      add r5,r5,r7
      str r11,[r5]        @ addr(curr[x+diff][y+diff]) have chance
 
@-----------------------------------------------         
               sub r3,r3,#1
               mov r6,#0
               cmp r3,r6
               bgt whileupright
         afterwhileupr:
               b UPLEFT

         forcondupright:
         add r0,r0,#1
         mov r6,#8
         cmp r0,r6              @for looop condition
          blt Forupright
     


UPLEFT:
 @r0-i | xcopy-r1 | val(cur[xcopy][i])-r2 |diff-r3 |r4-valcurr[x][y] 
                

                    mov r0,r10
                    add r0,r0,#1   @y+1
                    mov r1,r9      @xcopy=x

         Forupleft:
         
         sub r1,r1,#1
         mov r3,#-1
         cmp r1,r3            @ 1st if 
         beq DOWNLEFT
         
         @r3|r2|r5|r7|r8|
         mov  r5,r1 
         mov r7,#8
           mov r6,r5
         mul r5,r6,r7    @(8*xcopy)
         add r5,r5,r0
         mov r7,#4
           mov r6,r5
         mul r5,r6,r7
         ldr r7,=curr
         add r5,r5,r7  @r5 =addr(curr[xcopy][i])
          ldr r2,[r5]   

         mov r3,#0
         cmp r2,r3            @2nd if
         beq DOWNLEFT


         cmp r2,r4                  @3rd if 
         bne forcondupleft      

               mov r3,r0 @diff
               sub r3,r3,r10
               sub r3,r3,#1
               mov r6,#0
                cmp r3,r6      @while loop condition
                ble afterwhileuple
         whileupleft:
@-----------------------------------------------
     
      mov r5,r9          @now both r5 r9 have val[x]
      sub r5,r5,r3
      mov r7,#8
        mov r6,r5
      mul r5,r6,r7
      add r5,r5,r3
      add r5,r5,r10             @ 8x+y 
      mov r7,#4
        mov r6,r5
      mul r5,r6,r7             @4(8x+y)
      ldr r7,=curr
      add r5,r5,r7
      str r11,[r5]        @ addr(curr[x+diff][y+diff]) have chance
 
@-----------------------------------------------         
               sub r3,r3,#1
               mov r6,#0
               cmp r3,r6
               bgt whileupleft
         afterwhileuple:
               b DOWNLEFT

         forcondupleft:
         add r0,r0,#1
         mov r6,#8
         cmp r0,r6              @for looop condition
          blt Forupleft
     



DOWNLEFT:
 @r0-i | xcopy-r1 | val(cur[xcopy][i])-r2 |diff-r3 |r4-valcurr[x][y] 
                

                    mov r0,r10
                    sub r0,r0,#1   @y-1
                    mov r1,r9      @xcopy=x

         Fordownleft:
         
         sub r1,r1,#1
         mov r3,#-1
         cmp r1,r3            @ 1st if 
         beq DOWNRIGHT
         
         @r3|r2|r5|r7|r8|
         mov  r5,r1 
         mov r7,#8
           mov r6,r5
         mul r5,r6,r7    @(8*xcopy)
         add r5,r5,r0
         mov r7,#4
           mov r6,r5
         mul r5,r6,r7
         ldr r7,=curr
         add r5,r5,r7  @r5 =addr(curr[xcopy][i])
          ldr r2,[r5]   

         mov r3,#0
         cmp r2,r3            @2nd if
         beq DOWNRIGHT


         cmp r2,r4                  @3rd if 
         bne forconddownleft      

               mov r3,r10 @diff=y-i-1
               sub r3,r3,r0
               sub r3,r3,#1
               mov r6,#0
                cmp r3,r6      @while loop condition
                ble afterwhiledownle
         whiledownleft:
@-----------------------------------------------
     
      mov r5,r9          @now both r5 r9 have val[x]
      sub r5,r5,r3
      mov r7,#8
        mov r6,r5
      mul r5,r6,r7
      add r5,r5,r10             @ 8x+y 
       sub r5,r5,r3
       mov r7,#4
        mov r6,r5
      mul r5,r6,r7             @4(8x+y)
      ldr r7,=curr
      add r5,r5,r7
      str r11,[r5]        @ addr(curr[x+diff][y+diff]) have chance
 
@-----------------------------------------------         
               sub r3,r3,#1
               mov r6,#0
               cmp r3,r6
               bgt whiledownleft
         afterwhiledownle:
               b DOWNRIGHT

         forconddownleft:
         sub r0,r0,#1
         mov r6,#0
         cmp r0,r6              @for looop condition
          bge Fordownleft
     



DOWNRIGHT:
 @r0-i | xcopy-r1 | val(cur[xcopy][i])-r2 |diff-r3 |r4-valcurr[x][y] 
                

                    mov r0,r10
                    sub r0,r0,#1   @y-1
                    mov r1,r9      @xcopy=x

         Fordownright:
         
         add r1,r1,#1
         cmp r1,#8            @ 1st if 
         beq whilelast
         
         @r3|r2|r5|r7|r8|
         mov  r5,r1 
         mov r7,#8
           mov r6,r5
         mul r5,r6,r7    @(8*xcopy)
         add r5,r5,r0
         mov r7,#4
           mov r6,r5
         mul r5,r6,r7
         ldr r7,=curr
         add r5,r5,r7  @r5 =addr(curr[xcopy][i])
          ldr r2,[r5]   

         mov r3,#0
         cmp r2,r3            @2nd if
         beq whilelast


         cmp r2,r4                  @3rd if 
         bne forconddownright      

               mov r3,r10        @diff=y-i-1
               sub r3,r3,r0
               sub r3,r3,#1
               mov r6,#0
                cmp r3,r6      @while loop condition
                ble afterwhiledownright
         whiledownright:
@-----------------------------------------------
     
      mov r5,r9          @now both r5 r9 have val[x]
      add r5,r5,r3
      mov r7,#8
        mov r6,r5
      mul r5,r6,r7
      sub r5,r5,r3
      add r5,r5,r10             @ 8x+y 
      mov r7,#4
        mov r6,r5
      mul r5,r6,r7             @4(8x+y)
      ldr r7,=curr
      add r5,r5,r7
      str r11,[r5]        @ addr(curr[x+diff][y+diff]) have chance
 
@-----------------------------------------------         
               sub r3,r3,#1
               mov r6,#0
               cmp r3,r6
               bgt whiledownright
         afterwhiledownright:
               b whilelast

         forconddownright:
         sub r0,r0,#1
         mov r6,#0
         cmp r0,r6              @for looop condition
          bge Fordownright





                @@@here all will be end of funcs@@@

whilelast:

    @--2 for loop
    @--score updation

     @@ r0-i r1-j r4-val[curr[i][j]] r5-score1 r6-score2
     @@  store at last just add it now
 mov r5,#0
 mov r6,#0
 mov r0,#0
 mov r1,#0
  mov r7,#8 @just for comparison
  ldr r2,=curr
 @---------
      @@ r0-i r1-j r4-val[curr[i][j]] r5-score1 r6-score2
     @@  store at last just add it now
 mov r5,#0
 mov r6,#0
 mov r0,#0
 mov r1,#0
  mov r7,#8 @just for comparison
 
 
          mov r0,#-1
 scoreI:
          mov r1,#0
     add r0,r0,#1

     cmp r0,#8
     blt scoreJ
     bge whilecheck

 scoreJ:
      mov r3,r0
      mov r7,#8
        mov r4,r3
      mul r3,r4,r7
      add r3,r3,r1
      mov r7,#4
        mov r4,r3
      mul r3,r4,r7      @@4(8i+j)
       ldr r2,=curr
      add r3,r3,r2
      ldr r4,[r3]       @ r4- val(curr[i][j])
      
      mov r3,#1
      cmp r4,r3
      addeq r5,r5,#1
      mov r3,#2
      cmp r4,r3
      addeq r6,r6,#1

      add r1,r1,#1
      cmp r1,#8
      blt scoreJ
      bge scoreI
 @---------

 
whilecheck:   @@@ storing scores and checking exception here


ldr r0,=curr     
      mov r2,r9 @now both r2 r9 have val[x]
      mov r7,#8
        mov r3,r2
      mul r2,r3,r7
      add r2,r2,r10             @ 8x+y 
      mov r7,#4
        mov r3,r2
      mul r2,r3,r7             @4(8x+y)
      add r2,r2,r0
      mov r4,r2 
@@'r4 have addr(curr[x][y] '
@@@keep r4 r5 r6 only 

mov r7,#1
     cmp r11,r7          @chance==1
     bne secondif
         ldr r0,=score2
         ldr r2,[r0]
         cmp r6,r2
         bne secondif
         mov r3,#0
         str r3,[r4]
         b afterifcheckwhile
secondif:
          mov r7,#2
          cmp r11,r7
          bne thirdif
         
              ldr r0,=score1
              ldr r2,[r0]
              cmp r5,r2
              bne thirdif
              mov r3,#0
              str r3,[r4]
              b afterifcheckwhile

thirdif:

ldr r0,=score1
str r5,[r0]
ldr r0,=score2
str r6,[r0]



afterifcheckwhile:

@last input print
mov r0,#0
mov r1,#10
ldr r2,=infostr
swi 0x204

mov r0,#24
mov r1,#10
mov r2,r11
swi 0x205


mov r0,#28
mov r1,#10
mov r2,r9
swi 0x205

mov r0,#32
mov r1,#10
mov r2,r10
swi 0x205


mov r0,#14
swi 0x208 @clear line 14

mov r0,#10
mov r1,#13
ldr r3,=score1
ldr r2,[r3]
swi 0x205
mov r0,#29
mov r1,#13
ldr r3,=score2
ldr r2,[r3]
swi 0x205

mov r0,#2
mov r1,#0
mov r2,#0

Printrow:
     swi 0x205
     add r2,r2,#1
     add r0,r0,#2
     cmp r2,#7
     ble Printrow
mov r0,#0
mov r1,#1
mov r2,#0
Printcol:
     swi 0x205
     add r2,r2,#1
     add r1,r1,#1
     cmp r2,#7
     ble Printcol


          @@@'print grid here'
          @@ r0-x|r1-y|r2 -int
mov r0,#0
ldr r3,=curr
print:

     mov r1,#1
     mov r4,#17
     add r0,r0,#2
     cmp r0,r4
     blt col
     bge nexti 
col:
     ldr r2,[r3]
     swi 0x205
     add r3,r3,#4  
     add r1,r1,#1
     mov r4,#9
     cmp r1,r4
     blt col
     bge print

nexti:

ldr r0,=full
ldr r4,[r0]
mov r0,#1
cmp r4,r0
bne Whileloop

endlast:

ldr r0,=score1
ldr r1,[r0]
ldr r0,=score2
ldr r2,[r0]
ldr r0,=winner

cmp r1,r2
bgt win1
blt win2
beq draw
b endend

win1:
mov r1,#1
str r1,[r0]  
b endend  

win2:
mov r1,#2
str r1,[r0]
b endend

draw:
mov r1,#3
str r1,[r0]
b endend

endend:

mov r0,#6
mov r1,#13
ldr r2,=winneris

swi 0x204

@'print here winner'
mov r0,#20
mov r1,#13
ldr r3,=winner
ldr r2,[r3]
swi 0x205

.data 
curr: .space 256
score1: .space 4
score2: .space 4
full: .space 4
winner: .space 4
winneris: .asciz "Winner is-\n"
player1: .asciz "score1- "
player2: .asciz "score2- "
infostr: .asciz "last chance,x,y-"
invalidstatement: .asciz "invalid choice"

@@@chance x y are pasing in by value in r0
@that doesn't need to be stored' .

