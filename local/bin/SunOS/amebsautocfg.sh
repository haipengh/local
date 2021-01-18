#!/bin/ksh
#$Header: /u999/cvsadmin/cms_rep/repository/local/bin/SunOS/amebsautocfg.sh,v 1.1 2013/06/28 03:21:32 hongh Exp $
# -----------------------------------------------------------------------------------------------
# Script  : template.sh
# Changes :
#           Seq Name       Date       Description
#           --- ---------- ---------- -----------------------------------------------------------
#           000            1997/02/17 initial creation.
# -----------------------------------------------------------------------------------------------
#

_PRG=${0}
_PRGID=`basename ${0}`
_PRG_HEADER="$Id: amebsautocfg.sh,v 1.1 2013/06/28 03:21:32 hongh Exp $"

#_EXEC_BIN="template.am"
_EXEC_BIN=`echo "${_PRGID}" | cut -d'.' -f1`.am

amwrapper.sh "${_EXEC_BIN}" "${_PRGID}" "${@}"
