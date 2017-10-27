#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <variable> <value>"
   exit -1
endif

if ($1 == "--reset") then
   set reset_mode=1
   shift argv
endif

if ($1 == "SVN_ROOT") then
   shift argv
   if ($1 != "") then
      setenv SVN_ROOT $1
      shift argv
      $CSH_DIR/00_set_env.csh SVN_ROOT $SVN_ROOT
   endif
   exit 0
endif

if ($1 == "SVN_MODE") then
   shift argv
   if ($1 != "") then
      setenv SVN_MODE $1
      shift argv
      $CSH_DIR/00_set_env.csh SVN_MODE $SVN_MODE
   endif
   exit 0
endif

if ($?SVN_ROOT == 0) then
   echo "ERROR: env variable (SVN_ROOT) is not set yet."
   exit 1
endif

mkdir -p $SVN_ROOT/.dop/env


if (($1 != "") && ($1 != ".") && ($1 != "..") && ($1 != "/")) then
   set envname = $1
   if (($?reset_mode)||($2 == "--reset")) then
      echo "INFO: remove server env($envname)"
      rm -f $SVN_ROOT/.dop/env/$envname
   else if ($2 != "") then
      set envval = $2
      echo "SETP: $1 = $2"
      echo $envval  > $SVN_ROOT/.dop/env/$envname
   else if {(test -e $SVN_ROOT/.dop/env/$envname)} then
      echo "$envname =  `cat $SVN_ROOT/.dop/env/$envname`"
   else 
      echo "ERROR: server env($envname) variable is not defined!"
   endif
else
#   echo "SETP: SVN_ROOT = $SVN_ROOT"
endif

