#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
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

setenv CONTR_PATH $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/$DESIGN_CONTR
setenv CONTR_URL $SVN_URL/$DESIGN_PROJT/$CONTR_PATH
svn info $CONTR_URL >& /dev/null
if ($status != 0) then
   echo "ERROR: Cannot find container : $CONTR_PATH"
   exit 1
endif

if {(test -e $PROJT_PATH/$CONTR_PATH/.svn)} then
   if ($DESIGN_CONTR == ".") then
      rm -fr $PROJT_PATH/$CONTR_PATH/.dvc
      rm -fr $PROJT_PATH/$CONTR_PATH/.dqi
      rm -fr $PROJT_PATH/$CONTR_PATH/.htm
   endif
   svn update --quiet --force $PROJT_PATH/$CONTR_PATH --set-depth infinity
else
   svn checkout --force $CONTR_URL $PROJT_PATH/$CONTR_PATH --depth infinity
endif

if {(test -e $PTR_VERSN)} then
  rm -f $PTR_CONTR
  ln -s $PTR_VERSN/$DESIGN_CONTR $PTR_CONTR
else
  echo "ERROR: checkout version first before assigning container!" 
  exit 1
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
