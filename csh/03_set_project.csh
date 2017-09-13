#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PROJT>"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/
endif
setenv CSH_DIR $DVC_HOME/csh 
source $CSH_DIR/13_get_project.csh

mkdir -p .dop/env

if (($1 != "") && ($1 != ":") && ($1 != ".")) then
    setenv DESIGN_PROJT $1
    echo $DESIGN_PROJT > .dop/env/DESIGN_PROJT
    echo "SETP: DESIGN_PROJT = $DESIGN_PROJT"
else if ($?DESIGN_PROJT == 0) then
    setenv DESIGN_PROJT ":"
endif

if (($2 != "") && ($2 != ":")) then
    setenv PROJT_URL  $2
    echo $PROJT_URL   > .dop/env/PROJT_URL
    echo "SETP: PROJT_URL  = $PROJT_URL"
else if ($?SVN_URL == 1) then
    setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
    echo $PROJT_URL   > .dop/env/PROJT_URL
    echo "SETP: PROJT_URL  = $PROJT_URL"
else
    setenv PROJT_URL ""
endif

