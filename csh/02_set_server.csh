#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <variable> <value>"
   exit -1
endif

if ($1 == "--reset") then
   set reset=1
   shift argv
else
   set reset=0
endif

mkdir -p $HOME/.dop/server


if (($1 != "") && ($1 != ":") && ($1 != ".")) then
   set envname = $1
   if ($2 == "--reset") then
      echo "INFO: remove env('$envname')"
      rm -f $HOME/.dop/server/$envname
   else if ($2 != "") then
      set envval = $2
      echo "SETP: $1 = $2"
      echo $envval  > $HOME/.dop/server/$envname
   else if ($reset == 1) then
      echo "INFO: remove env('$envname')"
      rm -f $HOME/.dop/server/$envname
   else if {(test -e $HOME/.dop/server/$envname)} then
      echo "$envname =  `cat $HOME/.dop/server/$envname`"
   else 
      echo "ERROR: env '$envname' is not defined!"
   endif
else
   echo `ls $HOME/.dop/server/`
endif

