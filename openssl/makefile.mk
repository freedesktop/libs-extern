#*************************************************************************
#
#   OpenOffice.org - a multi-platform office productivity suite
#
#   $RCSfile: makefile.mk,v $
#
#   $Revision: 1.22 $
#
#   last change: $Author: kz $ $Date: 2007-12-12 15:38:30 $
#
#   The Contents of this file are made available subject to
#   the terms of GNU Lesser General Public License Version 2.1.
#
#
#     GNU Lesser General Public License Version 2.1
#     =============================================
#     Copyright 2005 by Sun Microsystems, Inc.
#     901 San Antonio Road, Palo Alto, CA 94303, USA
#
#     This library is free software; you can redistribute it and/or
#     modify it under the terms of the GNU Lesser General Public
#     License version 2.1, as published by the Free Software Foundation.
#
#     This library is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#     Lesser General Public License for more details.
#
#     You should have received a copy of the GNU Lesser General Public
#     License along with this library; if not, write to the Free Software
#     Foundation, Inc., 59 Temple Place, Suite 330, Boston,
#     MA  02111-1307  USA
#
#*************************************************************************

PRJ=.

PRJNAME=openssl
TARGET=openssl

# --- Settings -----------------------------------------------------

.INCLUDE :	settings.mk

# --- Files --------------------------------------------------------

.IF "$(SYSTEM_OPENSSL)" == "YES"
@all:
    @echo "Using system openssl...."
.ENDIF

.IF "$(DISABLE_OPENSSL)" == "TRUE"
@all:
    @echo "openssl disabled...."
.ENDIF

OPENSSL_NAME=openssl-0.9.8e

TARFILE_NAME=$(OPENSSL_NAME)

CONFIGURE_DIR=.
CONFIGURE_ACTION=config
CONFIGURE_FLAGS=-I$(SYSBASE)$/usr$/include -L$(SYSBASE)$/usr$/lib shared 

BUILD_DIR=.
BUILD_ACTION=make CC='$(CC)'

OUT2LIB = libssl.*
OUT2LIB += libcrypto.*
OUT2INC += include/openssl/*

.IF "$(OS)" == "LINUX"

PATCH_FILE_NAME=openssllnx.patch
ADDITIONAL_FILES:= \
    libcrypto_OOo_0_9_8e.map \
    libssl_OOo_0_9_8e.map
# if you build openssl as shared library you have to patch the Makefile.Shared "LD_LIBRARY_PATH=$$LD_LIBRARY_PATH \"
#BUILD_ACTION=make 'SHARED_LDFLAGS=-Wl,--version-script=./lib$$(SHLIBDIRS)_OOo_0_9_8e.map'
.ENDIF

.IF "$(OS)" == "SOLARIS"
PATCH_FILE_NAME=opensslsol.patch
ADDITIONAL_FILES:= \
    libcrypto_OOo_0_9_8e.map \
    libssl_OOo_0_9_8e.map
#BUILD_ACTION=make 'SHARED_LDFLAGS=-G -dy -z text -M./lib$$$$$$$$(SHLIBDIRS)_OOo_0_9_8e.map'
.ENDIF

.IF "$(OS)" == "WNT"
.IF "$(COM)" != "gcc"

PATCH_FILE_NAME=openssl.patch
.IF "$(MAKETARGETS)" == ""
# The env. vars CC and PERL are used by nmake, and nmake insists on '\'s
# If WRAPCMD is set it is prepended before the compiler, don't touch that.
.IF "$(WRAPCMD)"==""
CC!:=$(subst,/,\ $(normpath,1 $(CC)))
.EXPORT : CC
.ENDIF
PERL_bak:=$(PERL)
PERL!:=$(subst,/,\ $(normpath,1 $(PERL)))
.EXPORT : PERL
PERL!:=$(PERL_bak)
.ENDIF

#CONFIGURE_ACTION=cmd /c $(PERL:s!\!/!) configure
CONFIGURE_ACTION=$(PERL) configure
CONFIGURE_FLAGS=VC-WIN32
BUILD_ACTION=cmd /c "ms$(EMQ)\do_ms.bat $(subst,/,\ $(normpath,1 $(PERL)))" && nmake -f ms/ntdll.mak

OUT2LIB = out32dll$/ssleay32.lib
OUT2LIB += out32dll$/libeay32.lib
OUT2BIN = out32dll$/ssleay32.dll
OUT2BIN += out32dll$/libeay32.dll
OUT2INC = inc32$/openssl$/*
.ENDIF
.ENDIF

#set INCLUDE=D:\sol_temp\n\msvc7net3\PlatformSDK\include;D:\sol_temp\n\msvc7net3\include\ && set path=%path%;D:\sol_temp\r\btw\SRC680\perl\bin &&

# --- Targets ------------------------------------------------------

.INCLUDE : set_ext.mk
.INCLUDE : target.mk
.INCLUDE : tg_ext.mk

