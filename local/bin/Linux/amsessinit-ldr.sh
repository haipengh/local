#!/bin/ksh
# -----------------------------------------------------------------------------------------------
# Script  : amsessinit-ldr.sh
# -----------------------------------------------------------------------------------------------
#

_PRG=${0}
_PRGID=`basename ${0}`
_PRG_HEADER="$Id: amsessinit-ldr.sh,v 1.2 2019/06/25 23:02:36 cvsadmin Exp $"

#_EXEC_BIN="template.am"
_EXEC_BIN=`echo "${_PRGID}" | cut -d'.' -f1 | cut -d'-' -f1`.env

amwrapper.sh "${_EXEC_BIN}" "${_EXEC_BIN}" "${@}"
