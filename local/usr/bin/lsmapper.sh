#!/bin/ksh
#$Header: /u999/cvsadmin/cms_rep/repository/local/usr/bin/lsmapper.sh,v 1.5 2014/01/13 21:48:14 hongh Exp $
# -----------------------------------------------------------------------------------------------
# Script  : .sh
# Purpose : 
# Changes :
#           Seq Name          Date       Description
#           --- ------------- ---------- --------------------------------------------------------
# -----------------------------------------------------------------------------------------------
#

if [ $# -lt 1 ]; then
	ls -1 /dev/mapper/asm_* | grep -v "p1$" | awk '{printf("%30s\n",$0);}' | sort --field-separator=_ -k1,1 -k2,2 -k4,4 | sed 's/ //g'
else
	ls -1 "${@}" | grep -v "p1$" | awk '{printf("%30s\n",$0);}' | sort --field-separator=_ -k1,1 -k2,2 -k4,4 | sed 's/ //g'
fi

