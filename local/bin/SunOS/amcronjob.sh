#!/bin/ksh
#$Header: /u999/cvsadmin/cms_rep/repository/local/bin/SunOS/amcronjob.sh,v 1.1 2011/01/12 21:42:40 hongh Exp $
# -----------------------------------------------------------------------------------------------
# Script  : exec.sh
# Changes :
#           Seq Name       Date       Description
#           --- ---------- ---------- -----------------------------------------------------------
# -----------------------------------------------------------------------------------------------
#

_PRG=${0}
_PRGID=`basename "${0}"`
_PRGDIR=`dirname "${0}"`
_PRG_HEADER="$Id: amcronjob.sh,v 1.1 2011/01/12 21:42:40 hongh Exp $"

_LOCAL_TOP=${HOME}/local
PATH=${_LOCAL_TOP}/bin:${_PRGDIR}:${PATH}

#_EXEC_BIN="amcronjob.exe"
_EXEC_BIN=`echo "${_PRGID}" | cut -d'.' -f1`.am

amwrapper.sh "${_EXEC_BIN}" "${_PRGID}" "${@}"

