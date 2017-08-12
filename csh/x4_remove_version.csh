#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_VERSN>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
source $DOP_HOME/dvc/csh/11_get_svn.csh
source $DOP_HOME/dvc/csh/12_get_version.csh

if (($1 != "") && ($1 != ".")) then
    setenv DESIGN_VERSN $1
    echo "PARA: DESIGN_VERSN = $DESIGN_VERSN"
    if ($2 != "") then
        setenv DESIGN_STAGE $2
        if ($3 != "") then
            setenv DESIGN_BLOCK $3
            if ($4 != "") then
                setenv DESIGN_PHASE $4
                if ($5 != "") then
                    setenv DESIGN_PROJT $5
                endif
            endif
        endif
    endif
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
setenv STAGE_URL $BLOCK_URL/$DESIGN_STAGE
setenv VERSN_URL $STAGE_URL/$DESIGN_VERSN
svn info $VERSN_URL >& /dev/null
if ($status == 0) then
   echo "INFO: Remove Project Design Version - $DESIGN_STAGE/$DESIGN_VERSN"
   svn remove $VERSN_URL -m "Remove Design Version $DESIGN_VERSN"
else
    echo "ERROR: Can not find Design Version - /$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN"
endif
