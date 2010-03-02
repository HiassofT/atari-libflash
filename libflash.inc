;  libflash.inc - common flash definitions and macros
;
;  Copyright (C) 2004-2010 Matthias Reichl <hias@horus.com>
;
;  This program is free software; you can redistribute it and/or modify
;  it under the terms of the GNU General Public License as published by
;  the Free Software Foundation; either version 2 of the License, or
;  (at your option) any later version.
;
;  This program is distributed in the hope that it will be useful,
;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;  GNU General Public License for more details.
;
;  You should have received a copy of the GNU General Public License
;  along with this program; if not, write to the Free Software
;  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

FLASHVEC	= $E0 ; ,$E1: absolute flash address
DATAVEC		= $E2 ; ,$E3: data buffer vector
TMPVEC		= $E4 ; ,$E5: temproary vector

; setup internal flash address from 3-byte linear address
	.MACRO SETFADR
	.IF %0 <> 1
	.ERROR "SETFADR requires 1 parameter"
	.ELSE
	LDA #<[%1]
	STA TMPVEC
	LDA #>[%1]
	STA TMPVEC+1
	JSR FSETADR
	.ENDIF
	.ENDM

; setup internal flash address from immediate address
	.MACRO SETFADRI
	.IF %0 <> 2
	.ERROR "SETFADRI requires 2 parameters"
	.ELSE
	LDA #<TBUF
	STA TMPVEC
	LDA #>TBUF
	STA TMPVEC+1
	JSR FSETADR
	JMP TEND
TBUF	.WORD %2	; lo, mid
	.BYTE %1	; hi
TEND
	.ENDIF
	.ENDM

; setup data address from 2-byte memory location
	.MACRO SETDADR
	.IF %0 <> 1
	.ERROR "SETDADR requires 1 parameter"
	.ENDIF
	LDA %1
	STA DATAVEC
	LDA %1+1
	STA DATAVEC+1
	.ENDM

; setup data address from 2-byte memory location
	.MACRO SETDADRI
	.IF %0 <> 1
	.ERROR "SETDADRI requires 1 parameter"
	.ENDIF
	LDA #<[%1]
	STA DATAVEC
	LDA #>[%1]
	STA DATAVEC+1
	.ENDM

; flash types
TAMD10	= 0	; AMD 29F010
TAMD10B	= 1	; AMD 29F010B
TAMD40B	= 2	; AMD 29F040B
TST10B	= 3	; ST 29F010B
TST40B	= 4	; ST 29F040B
TBM40	= 5	; BM 29F040

