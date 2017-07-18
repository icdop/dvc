#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_BLOCK> <DESIGN_PHASE>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
source $DOP_HOME/dvc/csh/11_get_svn.csh
source $DOP_HOME/dvc/csh/12_get_version.csh

if ($1 != "") then
    setenv DESIGN_BLOCK $1
    if ($2 != "") then
        setenv DESIGN_PHASE $2
        if ($3 != "") then
            setenv DESIGN_PROJT $3
        endif
    endif
endif

setenv BLOCK_URL $SVN_URL/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK
svn info $BLOCK_URL >& /dev/null
if ($status == 0) then
    echo "INFO: Remove Project Design Block : /$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK"
    svn remove --quiet $BLOCK_URL -m "Remove Design Block : $DESIGN_BLOCK"
else
    echo "WARN: Design Block Not Exist : /$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK"
endif
