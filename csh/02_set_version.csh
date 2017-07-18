#!/bin/csh -f

if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_VERSN> <DESIGN_STAGE> <DESIGN_BLOCK> <DESIGN_PHASE> <DESIGN_PROJT>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DVC_CSH $0:h/../csh
else
   setenv DVC_CSH $DOP_HOME/dvc/csh 
endif
source $DVC_CSH/12_get_version.csh

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

mkdir -p .dvc/env
echo $DESIGN_VERSN > .dvc/env/DESIGN_VERSN
echo $DESIGN_STAGE > .dvc/env/DESIGN_STAGE
echo $DESIGN_BLOCK > .dvc/env/DESIGN_BLOCK
echo $DESIGN_PHASE > .dvc/env/DESIGN_PHASE
echo $DESIGN_PROJT > .dvc/env/DESIGN_PROJT

echo "==============================="
echo "DESIGN_PROJT = $DESIGN_PROJT"
echo "-------------------------------"
echo "DESIGN_PHASE = $DESIGN_PHASE"
echo "DESIGN_BLOCK = $DESIGN_BLOCK"
echo "DESIGN_STAGE = $DESIGN_STAGE"
echo "DESIGN_VERSN = $DESIGN_VERSN"
echo "==============================="
