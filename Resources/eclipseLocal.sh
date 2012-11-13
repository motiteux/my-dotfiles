#!/bin/bash

# Getting absolute path to the script, and thus the workspace.
# even if launched from a symlink
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
WORKSPACE="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
GOCAD_PLUGIN_PACKAGE_PATH=$WORKSPACE

ECLIPSE_EXE_IRLIN168=/work/irlin168_1/titeuxm/Apps/eclipse/eclipse
ECLIPSE_EXE_IRLIN143=/work/irlin143_1/lecomtje/eclipse/eclipse

case "$HOSTNAME" in
    irlin168)
        ECLIPSE_EXE=$ECLIPSE_EXE_IRLIN168
        ;;
    irlin143)
        ECLIPSE_EXE=$ECLIPSE_EXE_IRLIN143
        ;;
    *)
        echo -en "Host not taken into account"
        exit $?
        ;;
esac

EXPL_DIR=/soft/irsrvsoft1/expl
export PATH=$EXPL_DIR/Subversion_1.6.9/SUBERSION/bin:$PATH

unset QTDIR QTINC QTLIB

if [ ! -z $LD_LIBRARY_PATH ]; then
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$EXPL_DIR/Subversion_1.6.9/SUBERSION/lib:$EXPL_DIR/Subversion_1.6.9/APR-UTIL/lib:$EXPL_DIR/Subversion_1.6.9/APR/lib
else
    export LD_LIBRARY_PATH=$EXPL_DIR/Subversion_1.6.9/SUBERSION/lib:$EXPL_DIR/Subversion_1.6.9/APR-UTIL/lib:$EXPL_DIR/Subversion_1.6.9/APR/lib
fi

GOCAD_LICENSE=dsl
# GOCADLMD_LICENSE_FILE=7507@irlin837
# PRDM_GEO_LICENSE_FILE=7507@irlin837
GOCADLMD_LICENSE_FILE=7507@irlin143
PRDM_GEO_LICENSE_FILE=7507@irlin143
# GOCADLMD_LICENSE_FILE=7507@irpcm300461
# PRDM_GEO_LICENSE_FILE=7507@irpcm300461
export GOCAD_TOOLKITS=/home/irsrvshare2/R13/F177/PDGM/Toolkits
export GOCAD_SVN_TOOLKITS_SERVER=http://svn-nancy.paradigmgeo.net:8080/svn/toolkits

env_kine3d3_base() {
#Kine3D3
    Kine3D3_HOME=${GOCAD_PLUGIN_PACKAGE_PATH}/Kine3D3
    
    Kine3D3_BINDIR=${Kine3D3_HOME}/bin/${GOCAD_TARGET}
    Kine3D3_LIBDIR=${Kine3D3_HOME}/lib/${GOCAD_TARGET}
    Kine3D3_INCDIR=${Kine3D3_HOME}/include

# InGrid specific variables
    InGrid_BINDIR=${InGrid_HOME}/bin/${GOCADCONF}
    InGrid_LIBDIR=${InGrid_HOME}/lib/${GOCADCONF}
    InGrid_INCDIR=${InGrid_HOME}/include
    
# Tessellations specific variables
    Tessellations_BINDIR=${Tessellations_HOME}/bin/${GOCADCONF}
    Tessellations_LIBDIR=${Tessellations_HOME}/lib/${GOCADCONF}
    Tessellations_INCDIR=${Tessellations_HOME}/include
    
# WorkflowFoundations specific variables
    WorkflowFoundations_BINDIR=${WorkflowFoundations_HOME}/bin/${GOCADCONF}
    WorkflowFoundations_LIBDIR=${WorkflowFoundations_HOME}/lib/${GOCADCONF}
    WorkflowFoundations_INCDIR=${WorkflowFoundations_HOME}/include

    GOCADPATH=${Kine3D3_HOME}:${GOCADPATH}

    CPLUS_INCLUDE_PATH=${Kine3D3_INCDIR}:${CPLUS_INCLUDE_PATH}
    CPLUS_INCLUDE_PATH=${Tessellations_INCDIR}:${CPLUS_INCLUDE_PATH}
    CPLUS_INCLUDE_PATH=${InGrid_INCDIR}:${CPLUS_INCLUDE_PATH}
    CPLUS_INCLUDE_PATH=${WorkflowFoundations_INCDIR}:${CPLUS_INCLUDE_PATH}
    
    LD_LIBRARY_PATH=${Kine3D3_LIBDIR}:${LD_LIBRARY_PATH}
    LD_LIBRARY_PATH=${Tessellations_LIBDIR}:${LD_LIBRARY_PATH}
    LD_LIBRARY_PATH=${InGrid_LIBDIR}:${LD_LIBRARY_PATH}
    LD_LIBRARY_PATH=${WorkflowFoundations_LIBDIR}:${LD_LIBRARY_PATH}
}

case "$1" in
    "Kine3D3")
        notify-send --urgency=normal --expire-time=5000 "Loading Kine3D3-2011.1..."
        . ${WORKSPACE}/Kine3D3/setvars.sh

# Setting up specific environment variables for Eclipse
#======================================================
#Kine3D3

        env_kine3d3_base
        ;;
        
    "TemisTools")
        notify-send --urgency=normal --expire-time=5000 "Loading TemisTools-2011.1..."
        . ${WORKSPACE}/TemisTools/setvars.sh

        GOCAD_PLUGIN_PACKAGE_PATH=${GOCADHOME}/..

# Setting up specific environment variables for Eclipse
#======================================================
        env_kine3d3_base

#TemisTools

        TemisTools_BINDIR=${TemisTools_HOME}/bin/${GOCAD_TARGET}
        TemisTools_LIBDIR=${TemisTools_HOME}/lib/${GOCAD_TARGET}
        TemisTools_INCDIR=${TemisTools_HOME}/include
        
        CPLUS_INCLUDE_PATH=${TemisTools_INCDIR}:${CPLUS_INCLUDE_PATH}
        LD_LIBRARY_PATH=${TemisTools_LIBDIR}:${LD_LIBRARY_PATH}
        GOCADPATH=${TemisTools_HOME}:${GOCADPATH}
        ;;
        
    "IfpR13Plugin")
        notify-send --urgency=normal --expire-time=5000 "Loading IfpR13Plugin-2011.1..."
        . ${WORKSPACE}/IfpR13Plugin/setvars.sh

#IfpR13Plugin

        IfpR13Plugin_HOME=${GOCAD_PLUGIN_PACKAGE_PATH}/IfpR13Plugin
        
        IfpR13Plugin_BINDIR=${IfpR13Plugin_HOME}/bin/${GOCAD_TARGET}
        IfpR13Plugin_LIBDIR=${IfpR13Plugin_HOME}/lib/${GOCAD_TARGET}
        IfpR13Plugin_INCDIR=${IfpR13Plugin_HOME}/include
        
        CPLUS_INCLUDE_PATH=${IfpR13Plugin_INCDIR}:${CPLUS_INCLUDE_PATH}
        LD_LIBRARY_PATH=${IfpR13Plugin_LIBDIR}:${LD_LIBRARY_PATH}
        GOCADPATH=${IfpR13Plugin_HOME}:${GOCADPATH}
        ;;
        
    "")
        notify-send --urgency=critical --expire-time=10000 "Need to select a plugin." "Exiting..."
        exit $?
        ;;
        
    *)
        notify-send --urgency=critical --expire-time=10000 "Option $1 not implemented"
        exit $?
        ;;
esac

. ${GOCADROOT}/devtools/libraries.versions

# Doxygen documentation tools
DOXYGEN_HOME=/soft/irsrvsoft1/expl/Doxygen_1.4.7/
GRAPHVIZ_HOME=/soft/irsrvsoft1/expl/Graphviz_1.9/

#Python
PYTHON_LIBDIR=/soft/irsrvsoft1/expl/Python_2.5.2_64/lib

#QT
QT_HOME=${GOCAD_TOOLKITS}/Qt/qt-${QT_VERSION}/${GOCAD_BUILD_PLATFORM}
QT_INCDIR=${QT_HOME}/include
QT_LIBDIR=${QT_HOME}/lib

#GLM
GLM_HOME=${GOCAD_TOOLKITS}/CLL/CLL-${CLL_VERSION}/${GOCAD_BUILD_PLATFORM}

#DLIB
DLIB_HOME=/home/irsrvshare2/R13/F177/PDGM/Toolkits/dlib-17.31

# Boost
BOOST_HOME=${GOCAD_TOOLKITS}/boost/boost-${BOOST_VERSION}/${GOCAD_PLATFORM}
BOOST_LIBDIR=${BOOST_HOME}/lib

# PDGMSC
PDGMSC_HOME=${GOCAD_TOOLKITS}/pdgmsc/pdgmsc-${PDGMSC_VERSION}/${GOCAD_PLATFORM}
PDGMSC_INCDIR=${PDGMSC_HOME}/include
PDGMSC_LIBDIR=${PDGMSC_HOME}/lib

#SQLite
SQLITE_HOME=${GOCAD_TOOLKITS}/SQLite/sqlite-${SQLITE_VERSION}/${GOCAD_PLATFORM}
SQLITE_INCDIR=${SQLITE_HOME}/include
SQLITE_LIBDIR=${SQLITE_HOME}/lib

# Numeric solvers
NUMERICSOLVERS_HOME=${GOCAD_TOOLKITS}/NumericSolvers/NumericSolvers-${NUMERICSOLVERS_VERSION}/${GOCAD_PLATFORM}

# PluginFoundations specific variables

PluginFoundations_BINDIR=${PluginFoundations_HOME}/bin/${GOCADCONF}
PluginFoundations_LIBDIR=${PluginFoundations_HOME}/lib/${GOCADCONF}
PluginFoundations_INCDIR=${PluginFoundations_HOME}/include

# Filters specific variables

Filters_HOME=${GOCADROOT}/../Filters
Filters_BINDIR=${Filters_HOME}/bin/${GOCADCONF}
Filters_LIBDIR=${Filters_HOME}/lib/${GOCADCONF}
Filters_INCDIR=${Filters_HOME}/include

# Gocad specific variables

Gocad_BINDIR=${Gocad_HOME}/bin/${GOCADCONF}
Gocad_LIBDIR=${Gocad_HOME}/lib/${GOCADCONF}
Gocad_INCDIR=${Gocad_HOME}/include


PATH=/soft/irsrvsoft1/expl/Jre_1.6_01_64/bin:${PATH}

CPLUS_INCLUDE_PATH=${QT_INCDIR}/QtCore:${QT_INCDIR}/QtGui:${QT_INCDIR}/QtOpenGL:${QT_INCDIR}/QtDesigner:${QT_INCDIR}/QtXml:${CPLUS_INCLUDE_PATH}
CPLUS_INCLUDE_PATH=${QT_INCDIR}/Qt3Support:${CPLUS_INCLUDE_PATH}
CPLUS_INCLUDE_PATH=${Gocad_INCDIR}:${CPLUS_INCLUDE_PATH}
CPLUS_INCLUDE_PATH=${Filters_INCDIR}:${CPLUS_INCLUDE_PATH}
CPLUS_INCLUDE_PATH=${PluginFoundations_INCDIR}:${CPLUS_INCLUDE_PATH}
CPLUS_INCLUDE_PATH=${PDGMSC_INCDIR}:${CPLUS_INCLUDE_PATH}
CPLUS_INCLUDE_PATH=${DLIB_HOME}:${CPLUS_INCLUDE_PATH}
CPLUS_INCLUDE_PATH=${SQLITE_INCDIR}:${CPLUS_INCLUDE_PATH}

LD_LIBRARY_PATH=${Gocad_LIBDIR}:${LD_LIBRARY_PATH}
LD_LIBRARY_PATH=${QT_LIBDIR}:${LD_LIBRARY_PATH}
LD_LIBRARY_PATH=${PluginFoundations_LIBDIR}:${LD_LIBRARY_PATH}
LD_LIBRARY_PATH=${Filters_LIBDIR}:${LD_LIBRARY_PATH}
LD_LIBRARY_PATH=${BOOST_LIBDIR}:${LD_LIBRARY_PATH}
LD_LIBRARY_PATH=${PYTHON_LIBDIR}:${LD_LIBRARY_PATH}
LD_LIBRARY_PATH=${SQLITE_LIBDIR}:${LD_LIBRARY_PATH}
LD_LIBRARY_PATH=${PDGMSC_LIBDIR}:${LD_LIBRARY_PATH}

GOCAD_PLUGIN_PATH=${GOCADROOT}

export LD_LIBRARY_PATH 
export PATH GOCAD_PLUGIN_PATH GOCAD_LICENSE GOCADLMD_LICENSE_FILE PRDM_GEO_LICENSE_FILE GOCAD_PLUGIN_PACKAGE_PATH
export GOCADPATH

env CPLUS_INCLUDE_PATH=${CPLUS_INCLUDE_PATH}  ${ECLIPSE_EXE} -data ${WORKSPACE} &
