#!/bin/ksh
#$Header: /u999/cvsadmin/cms_rep/repository/local/bin/Linux/amcronjob.sh,v 1.6 2019/05/02 02:37:48 cvsadmin Exp $
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
_PRG_HEADER="$Id: amcronjob.sh,v 1.6 2019/05/02 02:37:48 cvsadmin Exp $"

PATH=${_PRGDIR}:${PATH}

#_EXEC_BIN="amcronjob.exe"
_EXEC_BIN=`echo "${_PRGID}" | cut -d'.' -f1`.am

amwrapper.sh "${_EXEC_BIN}" "${_PRGID}" "${@}"

