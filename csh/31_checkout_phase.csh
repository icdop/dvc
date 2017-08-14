#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PHASE>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if (($1 == "--data")) then
   set all_data = 1
   shift argv
else
   set all_data = 0
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
setenv DVC_ETC $DOP_HOME/dvc/etc
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/12_get_version.csh


if (($1 != "") && ($1 != ":") && ($1 != ".")) then
   setenv DESIGN_PHASE $1
   echo "INFO: DESIGN_PHASE = $DESIGN_PHASE"
   mkdir -p .dvc/env
   echo $DESIGN_PHASE > .dvc/env/DESIGN_PHASE
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
svn info $PHASE_URL >& /dev/null
if ($status == 1) then
   echo "ERROR: Cannot find Project Design Phase : $DESIGN_PHASE"
   exit 1
endif

echo "INFO: Checkout Project Design Phase : $DESIGN_PHASE"

mkdir -p .project/$DESIGN_PROJT/$DESIGN_PHASE
svn checkout --quiet $PROJT_URL/.dvc .project/$DESIGN_PROJT/.dvc
if ($all_data == 1) then
   svn checkout --quiet $PHASE_URL .project/$DESIGN_PROJT/$DESIGN_PHASE
else
   svn checkout --quiet $PHASE_URL/.dvc .project/$DESIGN_PROJT/$DESIGN_PHASE/.dvc
endif
rm -f .project/$DESIGN_PROJT/:
ln -s $DESIGN_PHASE .project/$DESIGN_PROJT/:

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0