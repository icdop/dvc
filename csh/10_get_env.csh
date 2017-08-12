#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [--global|--local] [--all] <variable>"
   exit -1
endif
set local=1
if ($1 == "--global") then
   set local = 0
   shift argv
endif
if ($1 == "--local") then
   set local = 1
   shift argv
endif

if ($1 == "--all") then
   set filepat="*"
   shift argv
else if ($1 != "") then
   set filepat="$1*"
else
   set filepat="*"
endif

if ($local == 1) then
  set filelist=`glob $PWD/.dvc/env/$filepat`
else
  set filelist=`glob $HOME/.dvc/env/$filepat`
endif

foreach fname ($filelist)
   set varname=$fname:t
   if { (test -e $fname) } then
      echo "$varname `cat $fname`"
   else
      echo "ERROR: variable '$varname' does not exist."
   endif
end


#if ($?DOP_HOME == 0) then
#   setenv DOP_HOME $0:h/../..
#endif
#setenv DVC_CSH $DOP_HOME/dvc/csh

