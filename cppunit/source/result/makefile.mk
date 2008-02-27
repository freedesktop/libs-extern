#*************************************************************************
#
#   OpenOffice.org - a multi-platform office productivity suite
#
#   $RCSfile: makefile.mk,v $
#
#   $Revision: 1.1 $
#
#   last change: $Author: lla $ $Date: 2008-02-27 16:26:48 $
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

PRJ=..$/..
# PRJINC=..$/..


PRJNAME=cppunit
TARGET=c5t_testresult
LIBTARGET=NO
ENABLE_EXCEPTIONS=TRUE
# ENABLE_RTTI=TRUE

# --- Settings -----------------------------------------------------

.INCLUDE :  settings.mk

# --- Files --------------------------------------------------------

# CXXFILES = \
# 		  querytemplate.cxx	\
# 		  stringhelper.cxx

# ENVCFLAGSCXX+=-DCPPUNIT_BUILD_DLL
SLOFILES = \
    $(SLO)$/SynchronizedObject.obj \
    $(SLO)$/TestResult.obj \
    $(SLO)$/TestResultCollector.obj \
    $(SLO)$/TestSucessListener.obj \
    $(SLO)$/emacsTestResult.obj \
    $(SLO)$/log.obj \
    $(SLO)$/optionhelper.obj \
    $(SLO)$/outputter.obj \
    $(SLO)$/signal.obj \
    $(SLO)$/testshlTestResult.obj \
    $(SLO)$/treswrapper.obj 

# currently unused
# 	$(SLO)$/TextTestResult.obj

LIB1TARGET= $(LB)$/$(TARGET).lib
LIB1OBJFILES=  $(SLOFILES)

.IF "$(GUI)"=="WNT" 
.IF "$(COM)"=="GCC"
LIB1ARCHIV=$(LB)$/lib$(TARGET)$(DLLPOSTFIX).a
.ENDIF
.ENDIF

.IF "$(GUI)" == "UNX"
LIB1ARCHIV=$(LB)$/lib$(TARGET)$(DLLPOSTFIX).a
.ENDIF

# --- Targets ------------------------------------------------------

.INCLUDE :  target.mk

