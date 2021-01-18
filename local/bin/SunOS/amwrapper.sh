#!/bin/ksh
#$Header: /u999/cvsadmin/cms_rep/repository/local/bin/SunOS/amwrapper.sh,v 1.3 2012/06/10 23:20:14 hongh Exp $
# -----------------------------------------------------------------------------------------------
# Script  : amwrapper.sh
# Changes :
#           Seq Name       Date       Description
#           --- ---------- ---------- -----------------------------------------------------------
# -----------------------------------------------------------------------------------------------
#

_PRG=${0}
_PRGID=`basename ${0}`
_PRG_HEADER="$Id: amwrapper.sh,v 1.3 2012/06/10 23:20:14 hongh Exp $"

if [ $# -lt 2 ]; then
	echo "Usage: ${_PRGID} <program> <program_name> [arguments]"
	exit 1
else
	_EXEC_BIN="${1}"
	_EXEC_NAME="${2}"
	shift 2
fi

if [ ! -r "${_EXEC_BIN}" ]; then
	_rt_executable=`whence "${_EXEC_BIN}"`
else
	_rt_executable="${_EXEC_BIN}"
fi

if [ $? -ne 0 ]; then
	echo "Error: cannot find executable ${_EXEC_BIN}"
	exit 1
fi

amwrapper.exe "executable=${_rt_executable}" "command_name=${_EXEC_NAME}" "${@}"

