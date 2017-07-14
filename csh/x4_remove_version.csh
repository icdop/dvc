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
source $DVC_BIN/dvc_get_svn
source $DVC_BIN/dvc_get_version

if ($1 != "") then
    setenv DESIGN_VERSN $1
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

setenv VERSN_URL $SVN_URL/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN
svn info $VERSN_URL >& /dev/null
if ($status == 0) then
   echo "INFO: Remove Project Design Version : $DESIGN_STAGE/$DESIGN_VERSN"
   svn remove --quiet $VERSN_URL -m "Remove Design Version $DESIGN_VERSN"
else
    echo "WARN: Design Version Not Exist : /$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN"
endif
