#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR> <DESIGN_OBJECT>"
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

if (($2 != "") && ($2 != ".")) then
    set src_name = $2
    if { (test -e $DVC_CONTAINER/$src_name) } then
       (cd $DVC_CONTAINER; svn add $src_name --force)
    else
       echo "ERROR: $src_name does not exist in container."
    endif
else
    (cd $DVC_CONTAINER; svn add `glob *` --force)
endif

