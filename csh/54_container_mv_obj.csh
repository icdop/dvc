#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_OBJECT> <DEST_NAME>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
source $DOP_HOME/dvc/csh/12_get_version.csh

setenv DVC_CONTAINER .design/$DESIGN_STAGE/$DESIGN_VERSN
if {(test -d $DVC_CONTAINER)} then
else
   echo "ERROR: Container Not Found: $DVC_CONTAINER"
   exit -1
endif

if ($1 != "") then
    set src_name = $1
    if ($2 != "") then
        set dst_name = $2
        svn mv --quiet $DVC_CONTAINER/$src_name $DVC_CONTAINER/$dst_name --force --parents
    endif
endif

