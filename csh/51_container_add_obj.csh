#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_OBJECT>"
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
    set filename =  $1
    rm -fr $DVC_CONTAINER/$filename
    cp -r $filename $DVC_CONTAINER/$filename
    svn add --quiet $DVC_CONTAINER/$filename --force
endif

