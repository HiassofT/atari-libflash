.if .def ATARIMAX8
	.include "libflash-atarimax8.src"
.endif

.if .def MEGAMAX16
	.include "libflash-megamax16.src"
.endif

.if .def FREEZER2005
	.include "libflash-freezer2005.src"
.endif

.if .def FREEZER2011
	.include "libflash-freezer2011.src"
.endif

.if .def MEGA512
	.include "libflash-mega512.src"
.endif

.if .def MEGA4096
	.include "libflash-mega4096.src"
.endif

.if .def U1MB
	.include "libflash-u1mb.src"
.endif
