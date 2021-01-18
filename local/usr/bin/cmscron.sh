#!/bin/ksh
#$Header: /u999/cvsadmin/cms_rep/repository/local/usr/bin/cmscron.sh,v 1.1 2011/01/13 02:47:02 hongh Exp $
# -----------------------------------------------------------------------------------------------
# Script  : cmscron.sh
# Author  : Haipeng Hong
# Changes :
#           Seq Name       Date       Description
#           --- ---------- ---------- -----------------------------------------------------------
#           000 H Hong     2008/02/07 initial creation.
# -----------------------------------------------------------------------------------------------
#

_PRG=${0}
_PRGID=`basename ${0}`
_PRG_HEADER="$Id: cmscron.sh,v 1.1 2011/01/13 02:47:02 hongh Exp $"

usage()
{
	echo "Usage: ${_PRGID} <desc> <SID> <command> [arguments]"
	echo ""
}

if [ $# -lt 3 -o \( $# -eq 1 -a "${1}" = "-?" \) ]; then
	usage
	exit 1
else
	_ARG_COMM_DESC="${1}"
	shift 1

	_ACC_SID=${1}
	shift 1

	_ARG_COMM_LINE="${@}"
	_RT_COMM_ARG1="${1}"
fi

if [ "${_ARG_COMM_LINE}" = "" ]; then
	usage
	exit 1
else
	_ARG_COMM_TYPE=`basename ${_RT_COMM_ARG1} | cut -d'.' -f 2 | tr '[:lower:]' '[:upper:]'`
fi


if [ "${_ARG_COMM_DESC=""}" = "" ]; then
	_ARG_COMM_DESC="${_RT_COMM_ARG1}"
fi

. /oracle/local/resource/profile_cms_host.env 1>/dev/null
. /oracle/local/resource/${_ACC_SID}/profile_${_ACC_SID}.env

_logfile="${CMS_TOP}/log/${_RT_COMM_ARG1}_`date +%Y%m%d%H%M%S`_${$}.log"

(echo "`date '+%Y/%m/%d %H:%M:%S'`"
 echo "(`hostname`): ${_ARG_COMM_LINE}"
 echo "${_logfile}"
 echo ""
) > "${_logfile}"

case "${_ARG_COMM_TYPE}" in
	"SQL")	sqlplus -s '/ as sysdba' @${_ARG_COMM_LINE} >> "${_logfile}"
		_RT_RETCODE=$?;;
	*) 	${_ARG_COMM_LINE} >> "${_logfile}"
		_RT_RETCODE=$?;;
esac
cat -s "${_logfile}"

if [ ${_RT_RETCODE} -ne 0 ]; then
	cat -s "${_logfile}" | mailx -s "Failed (`hostname`): ${_ARG_COMM_DESC}" `whoami`
fi

exit 0

