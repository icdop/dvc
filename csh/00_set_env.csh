#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [--local|--global|--server] [--design <dir>] [--reset] <variable> <value>"
   exit -1
endif

if (($1 == "-q") || ($1 == "--quiet")) then
   set quiet_mode=1
   shift argv
endif

if ($1 == "--global") then
   set env_root=$HOME/.dop
   shift argv
   echo "INFO: Global Parameter Setting"
else if ($1 == "--server") then
   set env_root=$SVN_ROOT/.dop
   shift argv
else if ($1 == "--local") then
   set env_root=$PWD/.dop
   shift argv
else if ($1 == "--design") then
   shift argv
   set env_root=$1/.dvc
   shift argv
else
   set env_root=.dop
endif

if ($1 == "--reset") then
   set reset_mode=1
   shift argv
else
   set reset_mode=0
endif


mkdir -p $env_root/env

if (($1 != "") && ($1 != ".") && ($1 != "..") && ($1 != "/")) then
   set envname = $1
   if (($reset_mode == 1) || ($2 == "--reset")) then
      unsetenv $envname
      rm -f $env_root/env/$envname
      if ($?quiet_mode == 0) then
         echo "INFO: remove env('$envname')"
      endif
   else if ($2 != "") then
      set envval = $2
      setenv $envname $envval
      echo $envval  > $env_root/env/$envname
      if ($?quiet_mode == 0) then
         echo "SETP: $envname = $envval"
      else
         echo $envval
      endif
   else if {(test -e $env_root/env/$envname)} then
      if ($?quiet_mode) then
         echo "`cat $env_root/env/$envname`"
      else
         echo "$envname =  `cat $env_root/env/$envname`"
      endif
   else if ($?quiet_mode == 0) then
      echo "ERROR: env '$envname' is not defined!"
   endif
else if ($?quiet_mode == 0) then
   echo `ls $env_root/env/`
endif
