#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <variable> <value>"
   exit -1
endif
if ($1 == "--global") then
   set local=0
   set dvcpath=$HOME
   shift argv
   echo "INFO: Global Parameter Setting"
else if ($1 == "--local") then
   set local=1
   set dvcpath=$PWD
   shift argv
else
   set local=1
   set dvcpath=.
endif
if ($1 == "--reset") then
   set reset=1
   shift argv
else
   set reset=0
endif

mkdir -p $dvcpath/.dop/env

if (($1 != "") && ($1 != ":") && ($1 != ".")) then
   set envname = $1
   if ($2 == "--reset") then
      echo "INFO: remove env('$envname')"
      rm -f $dvcpath/.dop/env/$envname
   else if ($2 != "") then
      set envval = $2
      echo "SETP: $1 = $2"
      echo $envval  > $dvcpath/.dop/env/$envname
   else if ($reset == 1) then
      echo "INFO: remove env('$envname')"
      rm -f $dvcpath/.dop/env/$envname
   else if {(test -e $dvcpath/.dop/env/$envname)} then
      echo "$envname =  `cat $dvcpath/.dop/env/$envname`"
   else 
      echo "ERROR: env '$envname' is not defined in '$dvcpath'!"
   endif
else
   echo `ls $dvcpath/.dop/env/`
endif
