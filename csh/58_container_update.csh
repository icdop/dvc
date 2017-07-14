#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_VERSN>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DVC_BIN $0:h
else
   setenv DVC_BIN $DOP_HOME/dvc/bin
endif
source $DVC_BIN/dvc_get_version

if ($1 != "") then
    setenv DESIGN_VERSN $1
    if ($2 != "") then
        setenv DESIGN_STAGE $2
    endif
endif

setenv DVC_CONTAINER .design/$DESIGN_STAGE/$DESIGN_VERSN
if {(test -d $DVC_CONTAINER)} then
   svn update --quiet $DVC_CONTAINER
else
   echo "ERROR: Container Not Found: $DVC_CONTAINER"
endif
