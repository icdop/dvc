#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PROJT>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv CSH_DIR $0:h/../csh
else
   setenv CSH_DIR $DOP_HOME/dvc/csh 
endif
source $CSH_DIR/13_get_project.csh

mkdir -p .dvc/env
mkdir -p .dvc/server

if (($1 != "") && ($1 != ":") && ($1 != ".")) then
    setenv DESIGN_PROJT $1
    echo $DESIGN_PROJT > .dvc/env/DESIGN_PROJT
    echo "SETP: DESIGN_PROJT = $DESIGN_PROJT"
else if ($?DESIGN_PROJT == 0) then
    setenv DESIGN_PROJT ":"
endif

if (($2 != "") && ($2 != ":")) then
    setenv PROJT_URL  $2
    echo $PROJT_URL   > .dvc/server/PROJT_URL
    echo "SETP: PROJT_URL  = $PROJT_URL"
else if ($?SVN_URL == 1) then
    setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
    echo $PROJT_URL   > .dvc/server/PROJT_URL
    echo "SETP: PROJT_URL  = $PROJT_URL"
else
    setenv PROJT_URL ""
endif

