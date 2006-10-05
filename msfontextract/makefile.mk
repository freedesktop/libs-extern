#*************************************************************************
#
#   OpenOffice.org - a multi-platform office productivity suite
#
#   $RCSfile: makefile.mk,v $
#
#   $Revision: 1.6 $
#
#   last change: $Author: kz $ $Date: 2006-10-05 10:59:33 $
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

PRJNAME=msfontextract
TARGET=libmspack
NO_DEFAULT_STL=TRUE
LIBSALCPPRT=

# --- Settings -----------------------------------------------------

.INCLUDE :	settings.mk

# --- Files --------------------------------------------------------

.IF "$(WITH_FONTOOO)" != "YES"
@all:
    @echo "FontOOo disabled... Nothing to build here."
.ENDIF

TARFILE_NAME=libmspack
PATCH_FILE_NAME=msfontextract.patch

ADDITIONAL_FILES=mspack$/makefile.mk mspack$/msfontextract.c mspack$/ministub.c

CONFIGURE_ACTION=none
CONFIGURE_FLAGS=

BUILD_DIR=mspack
BUILD_FLAGS=
BUILD_ACTION=dmake subdmak=true $(MFLAGS) $(MAKEFILE) $(CALLMACROS)

.INCLUDE : 	set_ext.mk
.INCLUDE :	target.mk
.INCLUDE :	tg_ext.mk

