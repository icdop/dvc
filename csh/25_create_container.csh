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

setenv DVC_PATH $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/$DESIGN_CONTR
setenv CONTR_URL $SVN_URL/$DESIGN_PROJT/$DVC_PATH

svn info $CONTR_URL/.dvc/CONTAINER >& /dev/null
if ($status == 0) then
   echo "INFO: Exist Design Container : $DESIGN_CONTR"
   if ($?info_mode) then
      svn info $CONTR_URL
   endif
else
   svn info $CONTR_URL >& /dev/null
   if ($status != 0) then
      svn mkdir --quiet $CONTR_URL -m "Create Design Container '$DESIGN_CONTR'." --parents
      svn mkdir --quiet $CONTR_URL/.dvc -m "DVC Config Directory." --parents
#      svn mkdir --quiet $CONTR_URL/.dqi -m "Create DQI Folder." --parents
      set tmpfile=`mktemp`
      echo -n $DVC_PATH > $tmpfile
      svn import --quiet $tmpfile $CONTR_URL/.dvc/CONTAINER -m 'Design Container Path'
      rm -fr $tmpfile
   endif
   svn checkout --quiet $CONTR_URL $CURR_PROJT/$DVC_PATH --depth infinity
endif

#echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
exit 0
