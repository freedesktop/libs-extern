#*************************************************************************
#
#   $RCSfile: makefile.mk,v $
#
#   $Revision: 1.2 $
#
#   last change: $Author: vg $ $Date: 2005-03-10 17:48:13 $
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

PRJNAME=xmlsec1
TARGET=so_xmlsec1

# --- Settings -----------------------------------------------------

.INCLUDE :	settings.mk

# --- Files --------------------------------------------------------

XMLSEC1VERSION=1.2.6

TARFILE_NAME=$(PRJNAME)-$(XMLSEC1VERSION)
PATCH_FILE_NAME=$(TARFILE_NAME).patch

ADDITIONAL_FILES= \
    include$/xmlsec$/nss$/akmngr.h \
    include$/xmlsec$/nss$/ciphers.h \
    include$/xmlsec$/nss$/tokens.h \
    include$/xmlsec$/mscrypto$/akmngr.h \
    src$/nss$/akmngr.c \
    src$/mscrypto$/akmngr.c \
    src$/nss$/keytrans.c \
    src$/nss$/keywrapers.c \
    src$/nss$/tokens.c \
    libxml2-config

.IF "$(GUI)"=="WNT"
CRYPTOLIB=mscrypto
#CRYPTOLIB=nss
#BASEINC=$(SOLARVERSION)$/$(INPATH)$/inc$(UPDMINOREXT)$/mozilla;$(SOLARVERSION)$/$(INPATH)$/inc$(UPDMINOREXT)$/mozilla$/nspr;$(SOLARVERSION)$/$(INPATH)$/inc$(UPDMINOREXT)$/mozilla$/nss;$(SOLARVERSION)$/$(INPATH)$/inc$(UPDMINOREXT)$/external
#BASELIB=$(SOLARVERSION)$/$(INPATH)$/lib$(UPDMINOREXT)
.ELSE
CRYPTOLIB=nss
.ENDIF

.IF "$(OS)"=="WNT"
CONFIGURE_DIR=win32
CONFIGURE_ACTION=cscript configure.js
CONFIGURE_FLAGS=crypto=$(CRYPTOLIB) xslt=no iconv=no static=no include=$(BASEINC) lib=$(BASELIB)
BUILD_ACTION=nmake
BUILD_DIR=$(CONFIGURE_DIR)
.ELSE
CONFIGURE_DIR=
CONFIGURE_ACTION=chmod 777 libxml2-config && .$/configure
CONFIGURE_FLAGS=--with-libxslt=no --with-openssl=no --with-gnutls=no --enable-pkgconfig=no
BUILD_ACTION=$(GNUMAKE)
BUILD_DIR=$(CONFIGURE_DIR)
.ENDIF


OUTDIR2INC=include$/xmlsec 

.IF "$(OS)"=="MACOSX"
OUT2LIB+=src$/.libs$/libxmlsec1.*.dylib src$/nss$/.libs$/libxmlsec1-nss.*.dylib 
.ELIF "$(OS)"=="WNT"
OUT2LIB+=win32$/binaries$/*.lib
OUT2BIN+=win32$/binaries$/*.dll
.ELSE
OUT2LIB+=src$/.libs$/libxmlsec1.so* src$/nss$/.libs$/libxmlsec1-nss.so*
.ENDIF

# --- Targets ------------------------------------------------------

.INCLUDE : set_ext.mk
.INCLUDE : target.mk
.INCLUDE : tg_ext.mk


