#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_OBJECT>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/12_get_version.csh
source $DVC_CSH/13_get_container.csh

if ($1 != ".") then
    set filename =  $1
    rm -fr $DVC_CONTAINER/$filename
    cp -r $filename $DVC_CONTAINER/$filename
    svn add --quiet $DVC_CONTAINER/$filename --force
endif

