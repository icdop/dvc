#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh
source $CSH_DIR/05_set_container.csh

setenv DVC_CONTAINER $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/$DESIGN_CONTR
setenv CONTR_URL $SVN_URL/$DESIGN_PROJT/$DVC_CONTAINER
svn info $CONTR_URL >& /dev/null
if ($status == 1) then
   echo "ERROR: Cannot find container : $DVC_CONTAINER"
   echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
   exit 1
endif

svn checkout --quiet $CONTR_URL .project/$DVC_CONTAINER

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
exit 0
