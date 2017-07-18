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
    set src_name = `realpath $1`
    set dst_name = $1:t
    if ($2 != "") then
        set dst_name = $2
    endif
    if {(test -h $DVC_CONTAINER/$dst_name)} then
       rm -f $DVC_CONTAINER/$dst_name
       ln -f -s $src_name $DVC_CONTAINER/$dst_name
       svn add --quiet $DVC_CONTAINER/$dst_name --force
    else if {(test -d $DVC_CONTAINER/$dst_name)} then
       ln -f -s $src_name $DVC_CONTAINER/$dst_name/$src_name:t
       svn add --quiet $DVC_CONTAINER/$dst_name/$src_name:t --force
    else
       ln -f -s $src_name $DVC_CONTAINER/$dst_name
       svn add --quiet $DVC_CONTAINER/$dst_name --force
    endif
endif

