#*************************************************************************
#
#   OpenOffice.org - a multi-platform office productivity suite
#
#   $RCSfile: makefile.mk,v $
#
#   $Revision: 1.12 $
#
#   last change: $Author: kz $ $Date: 2006-07-05 21:13:42 $
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

PRJNAME=so_hsqldb
TARGET=so_hsqldb

# --- Settings -----------------------------------------------------

.INCLUDE :	settings.mk
.INCLUDE : antsettings.mk

.INCLUDE :  version.mk
.INCLUDE :	minor.mk

.IF "$(SOLAR_JAVA)" != ""
# --- Files --------------------------------------------------------

TARFILE_NAME=hsqldb_$(HSQLDB_VERSION)
      
TARFILE_ROOTDIR=hsqldb

CONVERTFILES=build$/build.xml\
        doc/changelist_1_8_0.txt\
        src/org/hsqldb/resources/sql-error-messages_it.properties
PATCH_FILE_NAME=hsqldb_1_8_0

# ADDITIONAL_FILES=   src$/org$/hsqldb$/Collation.java \
#                     src$/org$/hsqldb$/TxManager.java \
#                     src$/org$/hsqldb$/lib$/LongKeyIntValueHashMap.java \
#                     src$/org$/hsqldb$/persist$/ScaledRAFileInJar.java \
#                     src$/org$/hsqldb$/test$/TestCollation.java

# override buildfile
ANT_BUILDFILE=build$/build.xml

.IF "$(JAVACISGCJ)"=="yes"
JAVA_HOME=
.EXPORT : JAVA_HOME
BUILD_ACTION=$(ANT) -Dbuild.label="build-$(RSCREVISION)" -Dbuild.compiler=gcj -f $(ANT_BUILDFILE) jar
.ELSE
BUILD_ACTION=$(ANT) -Dbuild.label="build-$(RSCREVISION)" -f $(ANT_BUILDFILE) jar
.ENDIF

.ENDIF # $(SOLAR_JAVA)!= ""

# --- Targets ------------------------------------------------------

.INCLUDE : set_ext.mk
.INCLUDE : target.mk

.IF "$(SOLAR_JAVA)" != ""
.INCLUDE : tg_ext.mk
.ENDIF

