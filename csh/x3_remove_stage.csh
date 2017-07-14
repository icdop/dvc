#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_STAGE>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DVC_BIN $0:h
else
   setenv DVC_BIN $DOP_HOME/dvc/bin
endif
source $DVC_BIN/dvc_get_svn
source $DVC_BIN/dvc_get_version

if ($1 != "") then
    setenv DESIGN_STAGE $1
    if ($2 != "") then
        setenv DESIGN_BLOCK $2
        if ($3 != "") then
            setenv DESIGN_PHASE $3
            if ($4 != "") then
                setenv DESIGN_PROJT $4 
            endif
        endif
    endif
endif

setenv STAGE_URL $SVN_URL/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE
svn info $STAGE_URL >& /dev/null
if ($status == 0) then
    echo "INFO: Remove Project Design Stage : /$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE"
    svn remove --quiet $STAGE_URL -m "Remove Design Stage : $DESIGN_STAGE"
else
    echo "WARN: Design Stage Not Exist : /$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE"
endif




