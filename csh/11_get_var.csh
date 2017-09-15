#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [--global|--local] [--all] <variable>"
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

if ($1 == "--all") then
   set varpat="*"
   shift argv
else if ($1 != "") then
   set varpat=$1
else
   set varpat="*"
endif

foreach fname ( `ls $var_home/.dvc/var/$varpat` )
   set varname=$fname:t
   if { (test -e $fname) } then
      echo "$varname = `cat $fname`"
   else
      echo "ERROR: variable '$varname' does not exist."
   endif
end
