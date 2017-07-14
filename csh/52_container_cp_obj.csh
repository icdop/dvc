#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_OBJECT> <DEST_NAME>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DVC_BIN $0:h
else
   setenv DVC_BIN $DOP_HOME/dvc/bin
endif
source $DVC_BIN/dvc_get_version

setenv DVC_CONTAINER .design/$DESIGN_STAGE/$DESIGN_VERSN
if {(test -d $DVC_CONTAINER)} then
else
   echo "ERROR: Container Not Found: $DVC_CONTAINER"
   exit -1
endif

if ($1 != "") then
    set src_name = $1
    set dst_name = $1:t
    if ($2 != "") then
        set dst_name = $2
    endif
    if {(test -d $DVC_CONTAINER/$dst_name)} then
        svn rm --quiet $DVC_CONTAINER/$dst_name --force
        rm -fr $DVC_CONTAINER/$dst_name
    endif 
    cp -r $src_name $DVC_CONTAINER/$dst_name
    svn add --quiet $DVC_CONTAINER/$dst_name --force
endif

