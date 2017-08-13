#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/12_get_version.csh
source $DVC_CSH/05_set_container.csh

setenv SVN_CONTAINER $DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/$DESIGN_CONTR
setenv CONTR_URL $SVN_URL/$SVN_CONTAINER
svn info $CONTR_URL >& /dev/null
if ($status == 1) then
   svn mkdir --quiet $CONTR_URL -m "Create Design Container $DESIGN_CONTR" --parents
   svn mkdir --quiet $CONTR_URL/.dqi -m "Design Quality Indicator" --parents
else
   echo "INFO: Container already exist : $DESIGN_CONTR"
   svn info $CONTR_URL
endif


echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
exit 0
