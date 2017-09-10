#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR> <SRC_FILE> <DEST_NAME>"
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
    set dst_name = $2:t
    if ($3 != "") then
        set dst_name = $3
    endif
    if {(test -h $CONTAINER_DIR/$dst_name)} then
       # if dest is link, remove the link first
       rm -f $CONTAINER_DIR/$dst_name
    else if {(test -d $CONTAINER_DIR/$dst_name)} then
       # if dest is dir, add the link
       set destname = $dst_name/$src_name:t
    else if {(test -e $CONTAINER_DIR/$dst_name)} then
       # if dest is file, remove the orginal file
       rm -fr $CONTAINER_DIR/$dst_name
    endif
    set src_name=`realpath $src_name`
    ln -fs $src_name $CONTAINER_DIR/$dst_name
    (cd $CONTAINER_DIR; svn add $dst_name --force)
endif

