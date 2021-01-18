#$Header: /u999/cvsadmin/cms_rep/repository/local/bin/Linux/amsessinit.sh,v 1.7 2019/04/27 10:52:29 cvsadmin Exp $
# -----------------------------------------------------------------------------------------------
# Script  : amsessinit.sh
# -----------------------------------------------------------------------------------------------
#_BUILD_ID="000"
#
_PRG_HEADER="$Id: amsessinit.sh,v 1.7 2019/04/27 10:52:29 cvsadmin Exp $"
_PRG=${0}				
_PRG_BASH_SOURCE=${BASH_SOURCE}		

_RT_SHELL="`echo ${SHELL} | awk  -F"/" '{print $NF}'`"	
_RT_SHELL=${_RT_SHELL:-"`ps --no-headers -p $$ -o cmd`"}	
_RT_O_PATH=${PATH}
case "${_RT_SHELL}" in
        "-ksh"|"ksh"|"/bin/ksh"|*"/bin/ksh")            # ksh
		_RT_SHELL="ksh"
		_RT_SCRIPT_P=${_PRG_BASH_SOURCE:-${PWD}}	
		PATH=${_RT_SCRIPT_P}:/usr/bin:/bin:/usr/local/sbin:/usr/local/bin:/sbin:/usr/sbin:${PATH}
		:;;
        "-bash"|"bash"|"/bin/bash"|*"/bin/bash")	# bash
	        _RT_SHELL="bash"
		_RT_SCRIPT_N=${_PRG_BASH_SOURCE##*/}
		_RT_SCRIPT_P=${_PRG_BASH_SOURCE%/*}
		PATH=${_RT_SCRIPT_P}:/usr/bin:/bin:/usr/local/sbin:/usr/local/bin:/sbin:/usr/sbin:${PATH}
		:;;
	"-sh"|"sh"|"/bin/sh"|*"/bin/sh")		# sh
		_RT_SHELL="sh"
		_RT_SCRIPT_N=${_PRG_BASH_SOURCE##*/}
		_RT_SCRIPT_P=${_PRG_BASH_SOURCE%/*}
		PATH=${_RT_SCRIPT_P}:/usr/bin:/bin:/usr/local/sbin:/usr/local/bin:/sbin:/usr/sbin:${PATH}
		:;;
        *)      # other shell
		case "${AM_PLATFORM:-`uname -s`}" in
			"SunOS")	# sunos
				_RT_SHELL="ksh";;
			*)	# others
				_RT_SHELL="bash";;
		esac                
		_RT_SCRIPT_N=${_PRG_BASH_SOURCE##*/}
		_RT_SCRIPT_P=${_PRG_BASH_SOURCE%/*}
		PATH=${_RT_SCRIPT_P}:/usr/bin:/bin:/usr/local/sbin:/usr/local/bin:/sbin:/usr/sbin:${PATH}
		:;;
esac
export _RT_SHELL

case "${_RT_SHELL}" in 
	*)	# default
		cd ${_RT_SCRIPT_P}; . amsessinit-bash.sh "${@}"; cd ${OLDPWD}
		:;;
esac

