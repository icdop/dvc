#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [--global|--local] [--all] <variable>"
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

if ($1 == "--script") then
   set script_mode=1
   shift argv
else if ($1 == "--tcl") then
   set tcl_mode=1
   shift argv
endif

if ($1 != "") then
   if {(test -d $env_home/.dop/env/)} then
      set env_name=$1
      set fname=$env_home/.dop/env/$env_name
      if {(test -e $fname)} then
         if ($?script_mode) then
            echo "$env_name = `cat $fname`"
         else if ($?tcl_mode) then
            echo "set env($env_name) {`cat $fname`}"
         else
            echo `cat $fname`
         endif
      else
         if ($?script_mode) then
            echo "#ERROR: env $env_name does not exist."
         else if ($?tcl_mode) then
            echo "#ERROR: env $env_name does not exist."
         else
            echo ""
         endif
      endif

   else
      echo "ERROR: '$env_home' is not a valid working directory!"
      exit 1
   endif
endif

exit 0
