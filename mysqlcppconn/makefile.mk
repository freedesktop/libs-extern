#*************************************************************************
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
# 
# Copyright 2008 by Sun Microsystems, Inc.
#
# OpenOffice.org - a multi-platform office productivity suite
#
# $RCSfile: makefile.mk,v $
#
# $Revision: 1.22 $
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

PRJNAME=mysqlcppconn
TARGET=so_mysqlcppconn

EXT_PROJECT_NAME=mysql-connector-cpp

# --- Settings -----------------------------------------------------

.INCLUDE :	settings.mk

# --- Files --------------------------------------------------------

TARFILE_NAME=$(EXT_PROJECT_NAME)
ADDITIONAL_FILES=\
 				driver$/makefile.mk \
 				driver$/nativeapi$/makefile.mk \
 				driver$/nativeapi$/binding_config.h \
 				cppconn$/config.h

CONVERTFILES=\
				cppconn$/build_config.h

PATCH_FILES=\
    $(TARFILE_NAME).patch \
    patches/default_to_protocol_tcp.patch

BUILD_DIR=driver
BUILD_ACTION = \
            cd nativeapi \
         && $(MAKE) $(MFLAGS) $(CALLMACROS) \
         && cd .. \
         && $(MAKE) $(MFLAGS) $(CALLMACROS)

# --- Targets ------------------------------------------------------

.INCLUDE : set_ext.mk
.INCLUDE : target.mk
.INCLUDE : tg_ext.mk

# --- post-build ---------------------------------------------------

# "normalize" the output structure, in that the C/C++ headers are
# copied to the canonic location in OUTPATH
# The allows, later on, to use the standard mechanisms to deliver those
# files, instead of delivering them out of OUTPATH/misc/build/..., which
# could cause problems

NORMALIZE_FLAG_FILE=so_normalized_$(TARGET)

$(PACKAGE_DIR)$/$(NORMALIZE_FLAG_FILE) : $(PACKAGE_DIR)$/$(BUILD_FLAG_FILE)
    @$(GNUCOPY) -r $(PACKAGE_DIR)$/$(EXT_PROJECT_NAME)$/driver$/mysql_driver.h $(INCCOM)
    -@$(MKDIRHIER) $(INCCOM)$/cppconn
    @$(GNUCOPY) -r $(PACKAGE_DIR)$/$(EXT_PROJECT_NAME)$/cppconn$/* $(INCCOM)$/cppconn
    @$(TOUCH) $(PACKAGE_DIR)$/$(NORMALIZE_FLAG_FILE)

normalize: $(PACKAGE_DIR)$/$(NORMALIZE_FLAG_FILE)

$(PACKAGE_DIR)$/$(PREDELIVER_FLAG_FILE) : normalize
