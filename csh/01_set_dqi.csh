#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [-d <dir>] <variable> <value>"
   exit -1
endif

if (($1 == "-q") || ($1 == "--quiet")) then
   set quiet_mode=1
   shift argv
endif

if ($1 == "--dir") then
   shift argv
   set var_home=$1
   shift argv
else
   set var_home=.
endif

if ($1 == "--reset") then
   set reset=1
   shift argv
else
   set reset=0
endif

mkdir -p $var_home/.dop/var

if (($1 != "") && ($1 != ":") && ($1 != ".")) then
   set varname = $1
   if ($2 == "--reset") then
      rm -f $var_home/.dop/var/$varname
      if ($?quiet_mode == 0) then
         echo "INFO: remove var('$varname')"
      endif
   else if ($2 != "") then
      set varval = $2
      set $varname=$varval
      echo $varval  > $var_home/.dop/var/$varname
      if ($?quiet_mode) then
         echo $varval
      else
         echo "SETP: $varname = $varval"
      endif
   else if ($reset == 1) then
      echo "INFO: remove var('$varname')"
      rm -f $var_home/.dop/var/$varname
   else if {(test -e $var_home/.dop/var/$varname)} then
      if ($?quiet_mode) then
         echo "`cat $var_home/.dop/var/$varname`"
      else
         echo "$varname =  `cat $var_home/.dop/var/$varname`"
      endif
   else if ($?quiet_mode == 0) then
      echo "ERROR: var '$varname' is not defined in '$var_home'!"
   endif
else if ($?quiet_mode == 0) then
   echo `ls $var_home/.dop/var/`
endif
