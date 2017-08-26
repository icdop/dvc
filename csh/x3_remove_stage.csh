#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_STAGE>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
source $DOP_HOME/dvc/csh/12_get_server.csh
source $DOP_HOME/dvc/csh/13_get_project.csh
source $DOP_HOME/dvc/csh/14_get_version.csh

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

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
setenv STAGE_URL $BLOCK_URL/$DESIGN_STAGE
svn info $STAGE_URL >& /dev/null
if ($status == 0) then
    echo "INFO: Remove Project Design Stage - /$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE"
    svn remove $STAGE_URL -m "Remove Design Stage : $DESIGN_STAGE"
else
    echo "ERROR: Can not find Design Stage - /$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE"
endif




