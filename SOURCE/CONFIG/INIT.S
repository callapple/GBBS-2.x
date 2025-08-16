*-------------------------------
* config/init
*-------------------------------
* Date: 11/18/24
*-------------------------------

doinit ldx #<begin ; setup esc handler
 lda #>begin
 jsr escape
 jsr cls

 lda #30
 sta maxlen
 lda #%00000000
 sta inpmode

 jsr print
 asc 'What are you going to call your system?',0d
 asc ':',00
 jsr inpln

 ldx #<datadef
 lda #>datadef
 ldy #cr
 jsr copyinp ; copy name into file
 stx temp4
 sta temp4+1

 lda #20 ; limit length
 sta maxlen

 jsr print
 hex 0d
 asc 'Enter your FULL name. (20 chars max)',0d
 asc ':',00
 jsr inpln ; get name

 ldx #<user ; copy line uppercase
 lda #>user
 ldy #cr
 jsr ucopyinp
 ldy #cr
 jsr copyinp ; copy the line
 stx temp3
 sta temp3+1

 ldx temp4
 lda temp4+1
 ldy #cr
 jsr copyinp
 stx temp4
 sta temp4+1

 ldy #0
init1d lda user,y
 iny
 cmp #$20
 bne init1d
 dey
 lda #','
 sta user,y

init2 lda #%11000000
 sta inpmode

 jsr print
 hex 0d
 asc 'Enter your telephone number',0d
 asc '(XXX-XXX-XXXX): ',00

 jsr inpln ; get tele number
 cpy #12
 bne init2

 ldx #<usrtele
 lda #>usrtele
 ldy #0
 jsr copyinp ; copy the line

 lda #16
 sta maxlen ; set length for city
 lda #%00000000
 sta inpmode

 jsr print
 hex 0d
 asc 'What city do you call from? (16 char)',0d
 asc ':',00

 jsr inpln ; get where from
 ldx temp3
 lda temp3+1
 ldy #','
 jsr copyinp ; copy the input
 stx temp2
 sta temp2+1

 lda #2
 sta maxlen ;set length for state
 lda #%11000000
 sta inpmode

init2a jsr print
 hex 0d
 asc 'What state do you call from? (XX):',00

 jsr inpln ;get state
 cpy #2
 bne init2a
 ldx temp2
 lda temp2+1
 ldy #cr
 jsr copyinp ;copy to date area

 lda #8
 sta maxlen

init3 jsr cls
 jsr print
 asc 'Enter a 4-8 char password:',00


 ldx #<usrpass ;lets make sure we are 8 spaces
 lda #>usrpass
 stx temp
 sta temp+1
 ldy #8
 lda #$20
:clrpass dey
 sta (temp),y
 bne :clrpass


 jsr inpln
 cpy #4
 bcc init3

 ldx #<usrpass
 lda #>usrpass
 ldy #0
 jsr copyinp ; copy the line

 lda #20
 sta maxlen

 jsr print
 hex 0d
 asc 'Enter a second password for remote',0d
 asc 'sysop access (1-20 chars)',0d
 asc ':',00

 jsr inpln ; get second password
 ldx temp4
 lda temp4+1
 ldy #cr
 jsr copyinp ; copy password into data file
 stx temp4
 sta temp4+1 ; save new pointers

 ldy #0
init3a lda xdata,y ; copy rest of the data file
 sta (temp4),y
 iny
 cmp #0
 bne init3a

 jsr cls ; clear screen
 jsr print
 db 1,7,8
 asc '- System  Information -',0d,0d
 asc 'System Name: ',00

 ldx #<datadef
 lda #>datadef
 ldy #cr+128
 jsr prstr ; show system name
 stx temp4
 sta temp4+1

 jsr print
 hex 0d,0d
 asc 'Sysop Name: ',00

 ldx temp4
 lda temp4+1
 ldy #cr+128
 jsr prstr ; show sysop name
 stx temp4
 sta temp4+1

 jsr print
 hex 0d,0d
 asc 'Sysop Phone Number: ',00

 ldx #<usrtele
 lda #>usrtele
 ldy #13
 jsr prstr ; show tele number

 jsr print
 hex 0d,0d
 asc 'Sysop is From: ',00

 ldx temp3
 lda temp3+1
 ldy #cr+128
 jsr prstr ; show where from

 jsr print
 hex 0d,0d
 asc 'Logon Password:  ',00

 ldx #<usrpass
 lda #>usrpass
 ldy #9
 jsr prstr ; show main password

 jsr print
 hex 0d,0d
 asc 'Remote Password: ',00

 ldx temp4
 lda temp4+1
 ldy #cr+128
 jsr prstr ; show remote password

 jsr print
 hex 0d,0d
 asc 'Is this information correct [Y/N] ? ',00

 jsr inpyn
 bcc init4
 jmp doinit

*-------------------------------

init4 lda #-1
 sta init ; set init mode

einit0 jsr re_vid
einit1 ldx #<einit0
 lda #>einit0
 jsr escape
 jsr re_mdm
einit2 ldx #<einit1
 lda #>einit1 ; if esc, go back 1 level
 jsr escape
 jsr re_pr
einit3 ldx #<einit2
 lda #>einit2
 jsr escape
 jsr re_clk

*-------------------------------

 ldy #<devnam
 lda #0
:loop sta confbuf,y ; zero out pathname buffer
 iny
 bne :loop

*-------------------------------
* start the hardware config

hard1 ldx #<einit3
 lda #>einit3 ; backup 1 level
 jsr escape

* stx x_save ;check for enhanced //e or later
 lda $fbb3
 cmp #$06
 bne :notenhanced

 lda $fbc0
 cmp #$e0
 bne :notenhanced

 lda $bf98 ;prodos machid
 and #$30 ;checking for 128k system
 cmp #$30 is it 128k?
 beq :xfer yep!

:notenhanced
* ldx x_save
 lda #0
 sta setxfer
 jmp :nostac

:xfer jsr TopBox
 jsr print
 db 1,3,4
 asc '- Choose File Transfer System -',00

* stx x_save
* ldx $fbb3
* cpx #$ea ;//e ?
* bne :notplus ;nope


* ldx x_save
* lda #0
* sta setxfer
* jmp :nostac

*:notplus
* ldx x_save
 jsr cls
 jsr print
 asc 'GBBS "Pro" v2.4 comes with a basic file',0d
 asc 'transfer  system built-in.  Do you want',0d
 asc 'to install the  more  advanced SuperTac',0d
 asc 'file transfer system [Y/N] ? ',00

 jsr inpyn
 bcc :stac
 lda #0
 sta setxfer
 jmp :nostac

:stac lda #1
 sta setxfer

 jsr print
 hex 0d,0d,0d
 asc 'Please enter the number of volumes that',0d
 asc 'should  be  allocated  to the  SuperTac',0d
 asc 'file transfer system.',0d,0d,0d
 asc 'Number of volumes? [1-99] ',00

 ldx #99 ;max is 99
 jsr inpnum
 sta volumes

 jsr bindec8
 sta stacacc+2 ;sysop high (10's)
 stx stacacc+3 ;sysop high (1's)
 sta stacacc+7 ;user high
 stx stacacc+8 ;user high
 sta stacacc+12 ;elite high
 stx stacacc+13 ;elite high
 sta stacacc+17 ;priv high
 stx stacacc+18 ;priv high
 sta stacacc+22 ;board manager high
 stx stacacc+23 ;board manager high

:nostac
 jsr TopBox
 jsr print
 db 1,3,7
 asc '- Choose Slot and Drive -',00

 jsr cls
 jsr print
 asc 'Please enter the slot and drive of your',0d
 asc 'mass storage  device.  If your media is',0d
 asc 'removable, then  please make sure there',0d
 asc 'is formatted media in place.',0d,0d,0d
 asc '     Slot? [1-7] ',00
 ldx #7
 jsr inpnum
 sta slot ; save the slot

 jsr print
 hex 0d
 asc '    Drive? [1-2] ',00
 ldx #2
 jsr inpnum
 sta drive ; save the drive
 dec drive ; make into [0-1] range

 jsr print
 hex 0d,0d,0d
 asc 'Is the above correct [Y/N] ? ',00
 jsr inpyn
 bcc :doit
 jmp :nostac ;nope

:doit lda #0 ; no more turning away..
 jsr escape ; [p. floyd]

 jsr chkspc ; check drive space
 cmp #3 ; are there are at least 768 blocks free?
 bcc :nospace ; not enough room
 jmp :pfxlength

:nospace jsr TopBox
 jsr print
 db 1,3,6
 asc '- Not Enough Storage Space -',00

 jsr cls
 jsr print
 asc 'The  storage  device checked  does  not',0d
 asc 'contain enough storage space to run the',0d
 asc 'system. You need to make some more room',0d
 asc 'on  this  device,  or  choose   another',0d
 asc 'device.',00

 jsr getcr
 jmp :nostac ; goto hard/floppy question

:pfxlength
 lda dstpfx
 cmp #9
 bcs :longpfx
 jmp hard2

:longpfx jsr TopBox
 jsr print
 db 1,3,6
 asc '- Volume Name is too Long -',00

 jsr cls
 jsr print
 asc 'The volume name of the selected storage',0d
 asc 'is too long. You  will  need to  choose',0d
 asc 'a volume name with a length less than 8',0d
 asc 'characters.',00

 jsr getcr
 jmp :nostac ; goto hard/floppy question

setxfer db 0

hard2
 jsr TopBox
 jsr print
 db 1,3,4
 asc '- Copy Files to Storage Device -',00

 jsr cls
 jsr print
 asc 'The configuration program is now going',0d
 asc 'to copy  all the files  needed  to run',0d
 asc 'GBBS Pro.',0d0d

 asc 'The directory GBBS.PRO will be created'0d
 asc 'on  your storage  device. All required'0d
 asc 'files will be copied to the directory.',0d
 asc 'No existing files will be deleted.'00

 jsr getg ; get permission
 jsr cls

 jsr setgbbs ;create xxx/gbbs.pro/
 jsr setspec ;update the drive spec list

 jsr chkspc ;reset path to original drive
 jsr setprg ;create & log xxx/gbbs.pro/program

 jsr make1 ;do copy in 2 parts
 jsr make1a
 jsr make2

 jsr chkspc ;reset path to original drive
 jsr setsys ;create & log xxx/gbbs.pro/system
 jsr make2a
 jsr make3

 jsr chkspc ;reset path to original drive
 jsr setgfile ;create & log xxx/gbbs.pro/gfiles
 jsr make3a

 jsr chkspc ;reset path to original drive
 jsr setdnload ;create & log xxx/gbbs.pro/download
 jsr make3b

 jsr chkspc ;reset path to original drive
 jsr setupload ;create xxx/gbbs.pro/upload

 jsr chkspc ;reset path to original drive
 jsr setbltn ;create & log xxx/gbbs.pro/bulletins
 jsr make3c

 jsr chkspc ;reset path to original drive
 jsr setmail ;create xxx/gbbs.pro/mail

 jsr chkspc ;reset path to original drive
 jsr settemp ;create /RAM

 jsr chkspc ;reset path to original drive
 jsr setprg
 jsr make3d

 lda setxfer ;did they want a transfer system?
 bne :doit ;yes, set it up
 jmp noxfer ;nope, skip the next step

:doit jsr chkspc
 jsr setstac
 jsr make3e

 jsr chkspc ;reset path to original drive
 jsr setprg ;create & log xxx/gbbs.pro/program
 jsr make4

 jsr chkspc ;reset path to original drive
 jsr setstac ;create & log xxx/gbbs.pro/stac/vol.
 jsr make4a

* setup supertac volumes

 lda #0
 sta curvol ;start at volume 1
 inc dstpfx ;add one to length of destination prefix

:loop inc curvol ;add one to current volume
 lda curvol ;which volume are we at?
 cmp #10 ;did we do 10 yet?
 bcc :less10 ;nope, we have less than 10
 cmp #11 ;more than 9, but how much more?
 bcs :over10 ;>= 11, so we not right on 10
 inc dstpfx ;smack dab on 10, so length is one greater

:over10 jsr bindec8 ;convert volume we're on to decimal

 ldy dstpfx ;get current length
 dey ;character before the end
 sta dstpfx,y ;store 10's
 txa ;get 1's
 iny ;next character forward
 sta dstpfx,y ;store 1's

 jsr mli ; create /xxx/gbbs.pro/stac/vol.XX
 db $c0 ; create new path
 dw p_crpth
 jmp :over

:less10 ldx dstpfx ;add single number to end of prefix
 clc
 adc #'0' ;make it ascii
 sta dstpfx,x

 jsr mli ; create /xxx/gbbs.pro/stac/vol.X
 db $c0 ; create new path
 dw p_crpth

:over lda curvol ;how many volumes done
 cmp volumes ;done 'em all yet?
 bne :loop ;nope, do some more

*-------------------------------

noxfer
 jsr TopBox
 jsr print
 db 1,3,14
 asc '- Finished -',00
 jsr cls

 jsr print
 asc 'Your  system  is now  configured and is'0d
 asc 'ready to run. To bring  up your  system',0d
 asc 'for operation, do the following:',0d,0d
 asc 'Boot up  your mass  storage  device and',0d
 asc 'type "PREFIX GBBS.PRO/PROGRAM".',0d,0d
 asc 'Type "-ACOS" to start your system.',00

 jsr getcr
 jmp do_quit

curvol db 0
volumes db 0

*-------------------------------
* copy files from disk 1
*-------------------------------

make1 ldx #<disk1 ; is first disk online?

 lda #>disk1
 jsr verify
 bcc :online ; yes, it is

 jsr cls
 jsr print
 asc 'Please place GBBS Pro Disk #1,',0d
 asc '/GBBS.PRO.1 online.',00

 jsr getg ; wait for ok
 jmp make1 ;check it to make sure

:online jsr cls
 jsr print
 asc 'Copying ACOS...',00

 ldx #<list1 ; copy acos, acos.obj, & encode
 lda #>list1
 jsr copy

*-------------------------------

 jsr logdst ; log to destination
 ldx #<gname2
 lda #>gname2 ; open file
 jsr movname
 jsr open

 ldx #<confbuf
 lda #>confbuf ; write configured system out
 ldy #20 ; write 10 pages (5 blocks)
 jsr wrblk
 jmp close

*-------------------------------
* copy segments into XXX/GBBS.PRO/PROGRAM

make1a jsr cls
 jsr print
 asc 'Copying GBBS "Pro" Program Segments...',00

 ldx #<list1a ; copy segments to xxx/gbbs.pro/program
 lda #>list1a
 jmp copy

*-------------------------------
* copy files from disk 2
*-------------------------------

make2 ldx #<disk2 ; is second disk online?
 lda #>disk2
 jsr verify
 bcc :online ; yes, it is

 jsr cls
 jsr print
 asc 'Please place GBBS Pro Disk #2,',0d
 asc '/GBBS.PRO.2 online.',00

 jsr getg ; wait for ok
 jmp make2

:online jsr cls
 jsr print
 asc 'Copying GBBS "Pro" Program Segments...',00

 ldx #<list2 ; copy files to xxx/gbbs.pro/program
 lda #>list2
 jmp copy

*-------------------------------
* make XXX/GBBS.PRO/SYSTEM

make2a jsr cls
 jsr print
 asc 'Copying System Files...',00

 ldx #<list2a ; copy system files
 lda #>list2a
 jsr copy

 jsr logdst ; log to seg sub
 ldx #<usrname ; open user file
 lda #>usrname
 jsr movname
 jsr open

 ldx #<user-128 ; write out sysop data
 lda #>user-128
 ldy #2 ; write 1 page (2 blocks)
 jsr wrblk

 jsr close ; finish up

 ldx #<dtanam1
 lda #>dtanam1 ; open data1 file
 jsr movname
 jsr open

 ldx #<datadef
 lda #>datadef
 ldy #4 ; write 2 pages (4 blocks)
 jsr wrblk
 jsr close
 jmp logcon ; log back

*-------------------------------
* copy files from disk 3
*-------------------------------

make3 ldx #<disk3 ; is system disk in place?
 lda #>disk3
 jsr verify
 bcc :online ; yes, it is

 jsr cls
 jsr print
 asc 'Please place GBBS Pro Disk #3,',0d
 asc '/GBBS.PRO.3 online.',00

 jsr getg ; wait for ok
 jmp make3

:online jsr cls
 jsr print
 asc 'Copying System Files...',00

 ldx #<list3 ; copy system files
 lda #>list3
 jmp copy

*-------------------------------
* copy files into XXX/GBBS.PRO/GFILES

make3a jsr cls
 jsr print
 asc 'Copying General Files...',00

 ldx #<list3a ; copy files to xxx/gbbs.pro/gfiles
 lda #>list3a
 jmp copy

*-------------------------------
* copy files into XXX/GBBS.PRO/DOWNLOAD

make3b jsr cls
 jsr print
 asc 'Copying Download Files...',00

 ldx #<list3b ; copy files to xxx/gbbs.pro/download
 lda #>list3b
 jmp copy

*-------------------------------
* copy files into XXX/GBBS.PRO/BULLETINS

make3c jsr cls
 jsr print
 asc 'Copying Message File...',00

 ldx #<list3c ; copy file to xxx/gbbs.pro/bulletins
 lda #>list3c
 jmp copy

*-------------------------------
* copy files into XXX/GBBS.PRO/GAMES

make3d jsr cls
 jsr print
 asc 'Copying Games...',00

 ldx #<list3d ; copy file to xxx/gbbs.pro/bulletins
 lda #>list3d
 jmp copy

*-------------------------------
* copy supertac stuff

make3e jsr cls
 jsr print
 asc 'Copying SuperTAC...',00

 ldx #<list3e
 lda #>list3e
 jmp copy

*-------------------------------
* copy files from disk 4
*-------------------------------

make4 ldx #<disk4 ; is supertac disk in place?
 lda #>disk4
 jsr verify
 bcc :online ; yes, it is

 jsr cls
 jsr print
 asc 'Please place GBBS Pro Disk #4,',0d
 asc '/GBBS.PRO.4 online.',00

 jsr getg ; wait for ok
 jmp make4

:online jsr cls
 jsr print
 asc 'Copying SuperTAC...',00

 ldx #<list4 ; copy files to xxx/gbbs.pro/program
 lda #>list4
 jmp copy

*-------------------------------
* copy supertac support files

make4a jsr cls
 jsr print
 asc 'Copying SuperTAC...',00

 ldx #<list4a ; copy files to xxx/gbbs.pro/stac/vol.
 lda #>list4a
 jsr copy

* copy the access file to the supertac stuff

 jsr logdst

 ldx #<access ;open access file
 lda #>access
 jsr movname
 jsr open

 ldx #<stacacc ;write out data
 lda #>stacacc
 ldy #1 ;write 128 bytes
 jsr wrblk

 jsr close ;finish up
 jsr logcon ;log back to config
 rts ;oi, we be done!

*-------------------------------
* print the slot or drive

prslot lda slot
 clc
 adc #'0' ; print slot
 jmp cout

prdriv lda drive
 clc ; print drive
 adc #'1'
 jmp cout

*-------------------------------
* variables
*-------------------------------

diskid db $a2,$20,$a0,$00

gname2 str 'ACOS.OBJ'
access str 'ACCESS'

slot db 0
drive db 0
dtanam1 str 'DATA1'

user ds 70,0
usrpass asc '        '
usrtele asc 'xxx-xxx-xxxx'
 dw 0 ;when$
 db %11111110,%11111111,%11111111
 db %11111111,%00000111
 db $50,$00,$00,$00,$00,$00,$00,$00,$00,$00
 ds 20,0 ;bytes

datadef asc 'System Name',0d
 asc 'Sysop Name',0d
 asc 'Second Password',0d

 ds 120,0

xdata asc '---------------------------------------',0d
 asc 'Ctrl-S Stop/Start  Spacebar to Exit',0d
 asc 'Press N for Next Bulletin',0d
 asc '1,0',0d
 db 0

condata asc ' '
 asc 'N'
 db 2
 db 32,40,64,80

stacacc asc '1',0d ;sysop low access
 asc '50',0d ;sysop high access
 asc '1',0d ;user low access
 asc '50',0d ;user high access
 asc '1',0d ;elite low access
 asc '50',0d ;elite high access
 asc '1',0d ;priv low access
 asc '50',0d ;priv high access
 asc '1',0d ;board manager low access
 asc '50',0d ;board manager high access
 hex 0d,0d

*-------------------------------
* lists for identifying files

disk1 str '/GBBS.PRO.1'
disk2 str '/GBBS.PRO.2'
disk3 str '/GBBS.PRO.3'
disk4 str '/GBBS.PRO.4'

* files on disk1

list1 asc 'acos',00
 asc 'acos.obj',00
 asc 'encode',00
 db 00

list1a asc 'bbslist.seg.s',00
 asc 'logon.seg.s',00
 asc 'main.seg.s',00
 asc 'mail.seg.s',00
 db 00

* files on disk2

list2 asc 'msg.seg.s',00
 asc 'system.seg.s',00
 asc 'system2.seg.s',00
 asc 'userpurge.seg.s',00
 db 00

list2a asc 'data',00
 asc 'data1',00
 asc 'data2',00
 asc 'error.list',00
 asc 'hlp.creature',00
 asc 'hlp.darts',00
 asc 'hlp.edit',00
 asc 'hlp.main',00
 asc 'hlp.msg',00
 asc 'hlp.user',00
 asc 'hlp.xfer',00
 asc 'mnu.bbslist',00
 asc 'mnu.game.40',00
 asc 'mnu.game.80',00
 asc 'mnu.mail.40',00
 asc 'mnu.mail.80',00
 asc 'mnu.mails.40',00
 asc 'mnu.mails.80',00
 asc 'mnu.new',00
 asc 'mnu.system.40',00
 asc 'mnu.system.80',00
 asc 'mnu.val.40',00
 asc 'mnu.val.80',00
 asc 'sys.autoval',00
 asc 'sys.info',00
 asc 'sys.newinfo',00
 asc 'sys.news',00
 asc 'sys.questions',00
 asc 'users',00
 asc 'v1.1',00
 asc 'v1.2',00
 asc 'v1.3',00
 asc 'v1.4',00
 asc 'welcome.email',00
 db 00

* files on disk3

list3 asc 'acos.time',00
 asc 'prot.down',00
 asc 'prot.up',00
 asc 'snapshot',00
 asc 'xcat',00
 asc 'xcopy',00
 asc 'xdos',00
 asc 'xshow',00
 db 00

list3a asc 'g1',00
 asc 'g1.1',00
 asc 'g1.2',00
 db 00

list3b asc 'd1',00
 asc 'd1.1',00
 asc 'd1.2',00
 asc 'd1.3',00
 asc 'd1.4',00
 db 00

list3c asc 'b1',00
 db 00

list3d asc 'blackjack.s',00
 asc 'creature.s',00
 asc 'darts.s',00
 db 00

list3e asc 'protocol.down',00
 asc 'protocol.up',00
 asc 'rz.load',00
 asc 'sz.load',00
 asc 'rz',00
 asc 'sz',00
 asc 'xcat',00
 asc 'xdos',00
 asc 'xshow',00
 asc 'access',00
 asc 'error.prots',00
 asc 'menu.batch',00
 asc 'menu.con',00
 asc 'menu.supertac',00
 asc 'menu.system',00
 asc 'menu.translog',00
 asc 'where.supertac',00
 db 00

* files on disk4

list4 asc 'supertac.s',00
 asc 'supertac.aux.s',00
 asc 'supertac.con.s',00
 asc 'supertac.log.s',00
 asc 'supertac.sys.s',00
 asc 'purge.seg.s',00
 db 00

list4a asc 'about.uploads',00
 asc 'new.uploads',00
 asc 'downloads',00
 asc 'vol.headers',00
 asc 'translog',00
 db 00
