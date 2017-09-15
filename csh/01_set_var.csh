#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <variable> <value>"
   exit -1
endif
if ($1 == "--global") then
   set local=0
   set var_home=$HOME
   shift argv
   echo "INFO: Global Parameter Setting"
else if ($1 == "--local") then
   set local=1
   set var_home=$PWD
   shift argv
else
   set local=1
   set var_home=.
endif
if ($1 == "--reset") then
   set reset=1
   shift argv
else
   set reset=0
endif
if (($1 != "") && ($1 != ":") && ($1 != ".")) then
   set varname = $1
   if ($2 == "--reset") then
      echo "INFO: remove var('$varname')"
      rm -f $var_home/.dop/var/$varname
   else if ($2 != "") then
      set varval = $2
      echo "SETP: $1 = $2"
      echo $varval  > $var_home/.dop/var/$varname
   else if ($reset == 1) then
      echo "INFO: remove var('$varname')"
      rm -f $var_home/.dop/var/$varname
   else if {(test -e $var_home/.dop/var/$varname)} then
      echo "$varname =  `cat $var_home/.dop/var/$varname`"
   else 
      echo "ERROR: var '$varname' is not defined in '$var_home'!"
   endif
else
   echo `ls $var_home/.dop/var/`
endif
