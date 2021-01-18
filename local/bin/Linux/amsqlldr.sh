#!/bin/ksh
#$Header: /u999/cvsadmin/cms_rep/repository/local/bin/Linux/amsqlldr.sh,v 1.3 2012/06/13 21:31:40 hongh Exp $
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
_PRG_HEADER="$Id: amsqlldr.sh,v 1.3 2012/06/13 21:31:40 hongh Exp $"

#_EXEC_BIN="template.am"
_EXEC_BIN=`echo "${_PRGID}" | cut -d'.' -f1`.am

amwrapper.sh "${_EXEC_BIN}" "${_PRGID}" "${@}"
