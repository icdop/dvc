#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR>"
   exit -1
endif
#echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

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

svn info $CONTR_URL/.dvc_path >& /dev/null
if ($status == 0) then
   echo "INFO: Reuse Design Container : $DESIGN_CONTR"
   if ($?info_mode) then
      svn info $CONTR_URL
   endif
else
   svn info $CONTR_URL >& /dev/null
   if ($status != 0) then
      svn mkdir --quiet $CONTR_URL -m "Create Design Container '$DESIGN_CONTR'." --parents
   endif
   svn checkout --quiet $CONTR_URL $CURR_PROJT/$DVC_CONTAINER
   echo $DVC_CONTAINER > $CURR_PROJT/$DVC_CONTAINER/.dvc_path
   svn add --quiet --force $CURR_PROJT/$DVC_CONTAINER/.dvc_path --parents
endif

#echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
exit 0
