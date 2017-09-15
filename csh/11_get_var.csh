#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [--all] <variable>"
   exit -1
endif

if ($1 == "--dir") then
   shift argv
   set var_home=$1
   shift argv
else
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
