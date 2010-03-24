#*************************************************************************
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
#
# Copyright 2000, 2010 Oracle and/or its affiliates.
#
# OpenOffice.org - a multi-platform office productivity suite
#
# This file is part of OpenOffice.org.
#
# OpenOffice.org is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License version 3
# only, as published by the Free Software Foundation.
#
# OpenOffice.org is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License version 3 for more details
# (a copy is included in the LICENSE file that accompanied this code).
#
# You should have received a copy of the GNU Lesser General Public License
# version 3 along with OpenOffice.org.  If not, see
# <http://www.openoffice.org/license.html>
# for a copy of the LGPLv3 License.
#
#*************************************************************************

PRJ=.

PRJNAME=lpsolve
TARGET=lpsolve

# --- Settings -----------------------------------------------------

.INCLUDE :	settings.mk

# --- Files --------------------------------------------------------

TARFILE_NAME=lp_solve_5.5

.IF "$(GUI)"=="WNT"
PATCH_FILES=lp_solve_5.5-windows.patch
.ELSE
PATCH_FILES=lp_solve_5.5.patch
ADDITIONAL_FILES=lpsolve55$/ccc.solaris lpsolve55$/ccc.os2
.ENDIF

CONFIGURE_DIR=
CONFIGURE_ACTION=
CONFIGURE_FLAGS=

BUILD_DIR=lpsolve55
.IF "$(GUI)"=="WNT"
.IF "$(COM)"=="GCC"
.IF "$(MINGW_SHARED_GCCLIB)"=="YES"
lpsolve_LDFLAGS=-shared-libgcc
.ENDIF
.IF "$(MINGW_SHARED_GXXLIB)"=="YES"
lpsolve_LIBS=-lstdc++_s
.ENDIF
BUILD_ACTION=lpsolve_LDFLAGS=$(lpsolve_LDFLAGS) lpsolve_LIBS=$(lpsolve_LIBS) cmd /c cgcc.bat
.ELSE
BUILD_ACTION=cmd /c cvc6.bat
OUT2LIB=$(BUILD_DIR)$/lpsolve55.lib
.ENDIF
OUT2BIN=$(BUILD_DIR)$/lpsolve55.dll
.ELIF "$(GUI)"=="OS2"
BUILD_ACTION=sh ccc.os2
OUT2LIB=$(BUILD_DIR)$/liblpsolve55.lib
.ELSE
.IF "$(OS)"=="MACOSX"
.EXPORT: EXTRA_CDEFS EXTRA_LINKFLAGS
BUILD_ACTION=sh ccc.osx
OUT2LIB=$(BUILD_DIR)$/liblpsolve55.dylib
.ELSE
.IF "$(COMNAME)"=="sunpro5"
BUILD_ACTION=sh ccc.solaris
.ELSE
BUILD_ACTION=sh ccc
.ENDIF
OUT2LIB=$(BUILD_DIR)$/liblpsolve55.so
.ENDIF
.ENDIF

OUT2INC=lp_lib.h lp_types.h lp_utils.h lp_Hash.h lp_matrix.h lp_mipbb.h lp_SOS.h

# --- Targets ------------------------------------------------------

.INCLUDE :	set_ext.mk
.INCLUDE :	target.mk
.INCLUDE :	tg_ext.mk

