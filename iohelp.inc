;  iohelp - various I/O helper routines
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


; "bput" text to #0, parameter: label TEXT (label TEXTL must be set to length of text)
	.macro BPUT0 ; LABEL
	.if %0 <> 1
	.error "BPUT0 needs 1 parameter"
	.endif
	LDX #<%1
	LDY #>%1
	LDA #%$1L
	JSR BPUT0COD
	.endm

	.macro BPUT0L ; label, length
	.if %0 <> 2
	.error "BPUT0L needs 2 parameter"
	.endif
	LDX #<[%1]
	LDY #>[%1]
	LDA #%2
	JSR BPUT0COD
	.endm

	.macro PRINT0	; address
	.if %0 <> 1
	.error "PRINT0 needs 1 parameter"
	.endif
	LDX #<[%1]
	LDY #>[%1]
	JSR PRINT0COD
	.endm

	.macro INPUT0	; address, 127 bytes
	.if %0 <> 1
	.error "INPUT0 needs 1 parameter"
	.endif
	LDA #127
	LDX #<[%1]
	LDY #>[%1]
	JSR INPUT0COD
	.endm

	.macro INPUT0L	; address, length from addressL
	.if %0 <> 1
	.error "INPUT0L needs 1 parameter"
	.endif
	LDA #%$1L
	LDX #<[%1]
	LDY #>[%1]
	JSR INPUT0COD
	.endm

