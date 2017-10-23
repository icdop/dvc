#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR>"
   exit -1
endif
echo "======================================================="
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_design.csh
source $CSH_DIR/05_set_container.csh

setenv DVC_PATH $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN
setenv CONTAINER_PATH $DVC_PATH/$DESIGN_CONTR
setenv CONTR_URL $SVN_URL/$DESIGN_PROJT/$CONTAINER_PATH

svn info $CONTR_URL/.dvc/DESIGN_CONTR >& /dev/null
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
      svn mkdir --quiet $CONTR_URL/.dqi -m "Design Quality Indicator" --parents
      svn mkdir --quiet $CONTR_URL/.htm -m "HTML Report" --parents
      set tmpfile=`mktemp`
      echo -n $DVC_PATH > $tmpfile
      svn import --quiet --force $tmpfile $CONTR_URL/.dvc/DESIGN_PATH -m 'Design Version Path'
      echo -n $DESIGN_CONTR > $tmpfile
      svn import --quiet --force $tmpfile $CONTR_URL/.dvc/DESIGN_CONTR -m 'Design Container Path'
      rm -fr $tmpfile
   endif
   svn checkout --quiet $CONTR_URL $PROJT_ROOT/$CONTAINER_PATH --depth infinity
endif
    
$CSH_DIR/00_set_env.csh DESIGN_CONTR $DESIGN_CONTR

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
