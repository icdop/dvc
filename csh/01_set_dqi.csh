#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [--dqi_pool <dir>] <dqi_name> <value>"
   exit -1
endif

if (($1 == "-q") || ($1 == "--quiet")) then
   set quiet_mode=1
   shift argv
endif

if ($1 == "--root") then
   shift argv
   set dqi_root=$1
   shift argv
   echo $dqi_root > .dop/env/DQI_ROOT
else if {(test -e .dop/env/DQI_ROOT)} then
   set dqi_root=`cat .dop/env/DQI_ROOT`
else if {(test -d :container)} then
   set dqi_root=:container
else if {(test -d :version)} then
   set dqi_root=:version
else if {(test -d :)} then
   set dqi_root=:
else
   echo "ERROR: Current directory (`pwd`) is not a valid working directory!"
   exit 1
endif

if ($1 == "--group") then
   shift argv
   set dqi_group=$1
   shift argv
else
   set dqi_group=""
endif

if ($1 == "--reset") then
   set reset_mode=1
   shift argv
endif


mkdir -p $dqi_root/.dqi/$dqi_group

if ($1 == "") then
   if ($?quiet_mode == 0) then
      tree $dqi_root/.dqi
   endif
else
   set dqi_name  = $1
   set dqi_value = $2
   set dqi_file  = $dqi_root/.dqi/$dqi_group/$dqi_name

   if ($?reset_mode) then
      rm -fr $dqi_root/.dqi/$dqi_group/$dqi_name
      if ($?quite_mode == 0) then
         echo "INFO: remove dqi('$dqi_name')"
      endif
   else
      mkdir -p $dqi_file:h
      echo "$dqi_value"  >  $dqi_file
      if {(test -e $dqi_file)} then
         if ($?quite_mode == 0) then
            echo "DQI: $dqi_name = `cat $dqi_file`"
         else
            echo `cat $dqi_file`
         endif
      else
         echo "ERROR: Fail to set dqi($dqi_name) at ths moment."
      endif
      
   endif

endif
