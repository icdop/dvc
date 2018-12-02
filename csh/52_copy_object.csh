#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <SRC_FILE> <DEST_NAME>"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_folder.csh
source $CSH_DIR/16_get_object.csh

if ($status < 0) then 
   exit $status 
endif

if ($1 != "") then
    set src_name = $1
    set dst_name = $1:t
    if ($2 != "") then
        set dst_name = $2
    endif
    if {(test -d $CONTAINER_DIR/$dst_name)} then
       if {(test -d $src_name)} then
          # if both src and dest are directory, remove dest directory first
          rm -fr $CONTAINER_DIR/$dst_name
          cp -r $src_name $CONTAINER_DIR/$dst_name
       else if {(test -e $src_name)} then
          cp -r $src_name $CONTAINER_DIR/$dst_name
       endif
    else
       rm -fr $CONTAINER_DIR/$dst_name
       cp -fr $src_name $CONTAINER_DIR/$dst_name
    endif 
    (cd $CONTAINER_DIR; svn add $dst_name --force)
endif

