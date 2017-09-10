#!/bin/csh -f 
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR> <DESIGN_OBJECT> <DEST_NAME>"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh
source $CSH_DIR/15_get_container.csh

if ($status < 0) then 
   exit $status 
endif

if ($2 != "") then
    set src_name = $2
    if ($3 != "") then
        set dst_name = $3
        echo "INFO: mv $src_name $dst_name"
        (cd $CONTAINER_DIR; svn mv $src_name $dst_name --force --parents)
    endif
endif

