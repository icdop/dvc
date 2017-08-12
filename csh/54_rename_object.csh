#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <CONTAINER> <DESIGN_OBJECT> <DEST_NAME>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/12_get_version.csh
source $DVC_CSH/13_get_container.csh

if ($2 != "") then
    set src_name = $2
    if ($3 != "") then
        set dst_name = $3
        echo "INFO: mv $src_name $dst_name"
        (cd $DVC_CONTAINER; svn mv $src_name $dst_name --force --parents)
    endif
endif

