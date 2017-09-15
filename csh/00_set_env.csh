#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [--global|--local|--reset] <variable> <value>"
   exit -1
endif

if ($1 == "--global") then
   set local=0
   set env_home=$HOME
   shift argv
   echo "INFO: Global Parameter Setting"
else if ($1 == "--local") then
   set local=1
   set env_home=$PWD
   shift argv
else
   set local=1
   set env_home=.
endif

if ($1 == "--reset") then
   set reset=1
   shift argv
else
   set reset=0
endif

if (($1 == "-q") || ($1 == "--quiet")) then
   set quite_mode=1
   shift argv
endif

mkdir -p $env_home/.dop/env

if (($1 != "") && ($1 != ":") && ($1 != ".")) then
   set envname = $1
   if (($reset == 1) || ($2 == "--reset")) then
      unsetenv $envname
      rm -f $env_home/.dop/env/$envname
      if ($?quite_mode == 0) then
         echo "INFO: remove env('$envname')"
      endif
   else if ($2 != "") then
      set envval = $2
      setenv $envname $envval
      echo $envval  > $env_home/.dop/env/$envname
      if ($?quite_mode == 0) then
         echo "SETP: $1 = $2"
      endif
   else if {(test -e $env_home/.dop/env/$envname)} then
      echo "$envname =  `cat $env_home/.dop/env/$envname`"
   else 
      echo "ERROR: env '$envname' is not defined!"
   endif
else
   echo `ls $env_home/.dop/env/`
endif
