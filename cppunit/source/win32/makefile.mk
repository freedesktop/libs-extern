#*************************************************************************
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
# 
# Copyright 2008 by Sun Microsystems, Inc.
#
#   OpenOffice.org - a multi-platform office productivity suite
#
#   $RCSfile: makefile.mk,v $
#
# $Revision: 1.2 $
#
# This file is part of OpenOffice.org.
#
# OpenOffice.org is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License version 3
# only, as published by the Free Software Foundation.
#
# OpenOffice.org is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
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
PRJ=..$/..
PRJINC=..

PRJNAME=cppunit
TARGET=c5t_winstuff
LIBTARGET=NO
ENABLE_EXCEPTIONS=TRUE

# --- Settings -----------------------------------------------------
.INCLUDE :  settings.mk

# ------------------------------------------------------------------

SLOFILES = \
        $(SLO)$/winstuff.obj

#-------------------------------------------------------------------------------
# This is a static lib
LIB1TARGET= $(LB)$/$(TARGET).lib
LIB1OBJFILES= \
    $(SLOFILES)

.IF "$(GUI)"=="WNT" 
.IF "$(COM)"=="GCC"
LIB2ARCHIV=$(LB)$/lib$(TARGET)$(DLLPOSTFIX).a
.ENDIF
.ENDIF

.IF "$(GUI)" == "UNX"
LIB2ARCHIV=$(LB)$/lib$(TARGET)$(DLLPOSTFIX).a
.ENDIF

# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk
