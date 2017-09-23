#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [-root <dir>] [--all] <variable>"
   exit -1
endif

if ($1 == "--root") then
   shift argv
   set dqi_root=$1
   shift argv
else if {(test -e .dop/env/DQI_ROOT)} then
   set dqi_root=`cat .dop/env/DQI_ROOT`
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

if ($1 == "--script") then
   set script_mode=1
   shift argv
else if ($1 == "--tcl") then
   set tcl_mode=1
   shift argv
else if ($1 == "--info") then
   set info_mode=1
   shift argv
endif

if {(test -d $dqi_root/.dqi/)} then
   if {(test -d $dqi_root/.dqi/$dqi_group)} then
   else
      echo "ERROR: DQI Group '$dqi_group' not found!"
      exit -1
   endif
else
#   echo "ERROR: '$dqi_root' is not a dqi root directory!"
   echo "NO DQI extracted."
   exit 1
endif


if ($1 == "--all") then
   shift argv
   set dqi_list = `(cd $dqi_root/.dqi/$dqi_group/; ls -a . )`
else
   set dqi_list=""
   while ($1 != "")
      set dqi_list =($dqi_list $1)
      shift argv
   endif
endif

foreach dqi_name ( $dqi_list )
   if (($dqi_name != ".") && ($dqi_name != "..")) then
      if {(test -e $dqi_root/.dqi/$dqi_group/$dqi_name)} then
         set dqi_file=$dqi_root/.dqi/$dqi_group/$dqi_name
         if { (test -d $dqi_file) } then
            #
         else if { (test -e $dqi_file) } then
            if ($?script_mode) then
               echo "$dqi_group/$dqi_name = `cat $dqi_file`"
            else if ($?tcl_mode) then
               echo "set dqi($dqi_group/$dqi_name) {`cat $dqi_file`}"
            else
               echo `cat $dqi_file`
            endif
         else
            if ($?script_mode) then
               echo "#ERROR: dqi($dqi_group,$dqi_name) does not exist."
            else if ($?tcl_mode) then
               echo "#ERROR: dqi($dqi_group,$dqi_name) does not exist."
            else
             #  echo ""
            endif
         endif
      endif
   endif
end

exit 0
