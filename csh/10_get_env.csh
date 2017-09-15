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

while ($1!="")

   set flist = `glob $env_home/.dop/env/$1`
   foreach fname ( $flist  )
      set envname=$fname:t
      if { (test -e $fname) } then
         echo "$envname = `cat $fname`"
      else
         echo "ERROR: env '$envname' does not exist."
      endif
   end
   shift argv
   
end
