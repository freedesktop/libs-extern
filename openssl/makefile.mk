#*************************************************************************
#
#   $RCSfile: makefile.mk,v $
#
#   $Revision: 1.2 $
#
#   last change: $Author: hjs $ $Date: 2001-10-11 15:24:05 $
#
#   The Contents of this file are made available subject to the terms of
#   either of the following licenses
#
#          - GNU Lesser General Public License Version 2.1
#          - Sun Industry Standards Source License Version 1.1
#
#   Sun Microsystems Inc., October, 2000
#
#   GNU Lesser General Public License Version 2.1
#   =============================================
#   Copyright 2000 by Sun Microsystems, Inc.
#   901 San Antonio Road, Palo Alto, CA 94303, USA
#
#   This library is free software; you can redistribute it and/or
#   modify it under the terms of the GNU Lesser General Public
#   License version 2.1, as published by the Free Software Foundation.
#
#   This library is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   Lesser General Public License for more details.
#
#   You should have received a copy of the GNU Lesser General Public
#   License along with this library; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place, Suite 330, Boston,
#   MA  02111-1307  USA
#
#
#   Sun Industry Standards Source License Version 1.1
#   =================================================
#   The contents of this file are subject to the Sun Industry Standards
#   Source License Version 1.1 (the "License"); You may not use this file
#   except in compliance with the License. You may obtain a copy of the
#   License at http://www.openoffice.org/license.html.
#
#   Software provided under this License is provided on an "AS IS" basis,
#   WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING,
#   WITHOUT LIMITATION, WARRANTIES THAT THE SOFTWARE IS FREE OF DEFECTS,
#   MERCHANTABLE, FIT FOR A PARTICULAR PURPOSE, OR NON-INFRINGING.
#   See the License for the specific provisions governing your rights and
#   obligations concerning the Software.
#
#   The Initial Developer of the Original Code is: Sun Microsystems, Inc.
#
#   Copyright: 2000 by Sun Microsystems, Inc.
#
#   All Rights Reserved.
#
#   Contributor(s): _______________________________________
#
#
#
#*************************************************************************

PRJ=.

PRJNAME=openssl
TARGET=openssl

# --- Settings -----------------------------------------------------

.INCLUDE :	settings.mk

# --- Files --------------------------------------------------------

TARFILE_NAME=openssl-0.9.5a

PATCH_FILE_NAME=openssl-0.9.5a.patch

.IF "$(GUI)"=="UNX"
#relative to CONFIGURE_DIR
CONFIGURE_ACTION=config
.IF "$(OS)$(CPU)$(COM)"=="SOLARISSC52"
CONFIGURE_FLAGS=-DPIC -KPIC
.ENDIF			# "$(OS)$(CPU)$(COM)"=="SOLARISSC52"

BUILD_DIR=$(CONFIGURE_DIR)
BUILD_ACTION=make

OUT2LIB= \
    libcrypto.a \
    libssl.a
    
OUTDIR2INC= \
    include$/openssl$

.ENDIF			# "$(GUI)"=="UNX"

.IF "$(GUI)"=="WNT"

.EXPORT : PERL

CONFIGURE_ACTION=$(PERL) Configure VC-WIN32 ^ ms\do_ms.btm

BUILD_DIR=$(CONFIGURE_DIR)
BUILD_ACTION=*nmake -f ms/ntdll.mak

OUT2LIB= \
    out32dll$$/libeay32.lib \
    out32dll$$/ssleay32.lib
    
OUT2BIN= \
    out32dll$$/libeay32.dll \
    out32dll$$/ssleay32.dll
    
OUTDIR2INC= \
    inc32$/openssl

.ENDIF			# "$(GUI)"=="WNT"

# --- Targets ------------------------------------------------------

.INCLUDE : set_ext.mk
.INCLUDE :	target.mk
.INCLUDE :	tg_ext.mk

.IF "$(GUI)"=="WNT"
$(MISC)$/so_custom_patch :  $(PACKAGE_DIR)$/$(ADD_FILES_FLAG_FILE)
    +win32_custom.bat $(OUT) $(TARFILE_NAME) ms && $(TOUCH) $@
    
$(PACKAGE_DIR)$/$(CONFIGURE_FLAG_FILE) : $(MISC)$/so_custom_patch
.ENDIF          # "$(GUI)"=="WNT"

TG_DELIVER : build$/$(INPATH)$/so_predeliver
        $(DELIVER)

.IF "$(BUILD_SOSL)"!=""
ALLTAR : TG_DELIVER
.ENDIF			# "$(BUILD_SOSL)"!=""

