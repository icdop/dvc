#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_OBJECT> <DEST_NAME>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/12_get_version.csh
source $DVC_CSH/13_get_container.csh

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

