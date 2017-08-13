#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <CONTAINER>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/12_get_version.csh

if ($1 != "") then
   setenv CONTAINER $1
   echo "PARA: CONTAINER = $CONTAINER"
   mkdir -p .dvc/env
   echo $CONTAINER > .dvc/env/CONTAINER
endif
setenv SVN_CONTAINER $DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/$CONTAINER
setenv CONTAINER_URL $SVN_URL/$SVN_CONTAINER
svn info $CONTAINER_URL >& /dev/null
if ($status == 1) then
   svn mkdir --quiet $CONTAINER_URL -m "Create Design Container $CONTAINER" --parents
else
   echo "INFO: Container already exist : $CONTAINER"
   svn info $CONTAINER_URL
endif


echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
exit 0
