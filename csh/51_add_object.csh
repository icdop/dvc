#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <CONTAINER> <DESIGN_OBJECT>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/12_get_version.csh
source $DVC_CSH/13_get_container.csh

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

