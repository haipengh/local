#$Header: /u999/cvsadmin/cms_rep/repository/local/bin/envalias.sh,v 1.5 2017/11/03 08:57:16 cvsadmin Exp $
# -----------------------------------------------------------------------------------------------
# Script  : envalias.sh
# Changes :
#           Seq Name          Date       Description
#           --- ------------- ---------- --------------------------------------------------------
# -----------------------------------------------------------------------------------------------
#_BUILD_ID="022"
#

# get/set SHELL
_RT_SHELL=${AM_SHELL:-`echo ${SHELL} | awk  -F"/" '{print $NF}'`}
case "${_RT_SHELL}" in
        "-bash"|"bash"|"/bin/bash"|*"/bin/bash")        _RT_SHELL="bash";;
        "-ksh"|"ksh"|"/bin/ksh"|*"/bin/ksh")            _RT_SHELL="ksh";;
        *)      # other shell
		case "${AM_PLATFORM}" in
			"SunOS")	# sunos
				_RT_SHELL="ksh";;
			*)	# others
				_RT_SHELL="bash";;
		esac                
		:;;
esac
export _RT_SHELL

case "${_RT_SHELL}" in 
	"ksh")	# ksh
		. ${AM_LOCAL_TOP}/bin/envalias-ksh.sh "${@}";;
	"bash")	# bash
		. ${AM_LOCAL_TOP}/bin/envalias-bash.sh "${@}";;
	*)	# default
		. ${AM_LOCAL_TOP}/bin/envalias-bash.sh "${@}";;
esac

