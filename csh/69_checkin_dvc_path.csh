#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DVC_PATH>"
   exit -1
endif
#echo "======================================================="
#echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh

# If DVC_PATH is defined and no args is specified
# it may be called form other dvc_checkin_* command
# this is used to preserved all option modes of parent commands 

if (($1 != "") && ($1 != ":") && ($1 != ".")) then
   setenv DVC_PATH $1
else if ($?DVC_PATH == 0) then
   source $CSH_DIR/14_get_design.csh
   setenv DVC_PATH $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN
endif

if {(test -e $PROJT_ROOT/$DVC_PATH/.dvc)} then
   (cd $PROJT_ROOT/$DVC_PATH/.dvc; \
   svn update . --quiet --force ;  \
   svn add .  --force --depth infinity ; \
   svn commit . -m 'Update version' --quiet )
else
   echo "ERROR: Cannot find Design Directory '$DVC_PATH'"
   exit 1
endif

if {(test -e $PROJT_ROOT/$DVC_PATH/.dqi)} then
   (cd $PROJT_ROOT/$DVC_PATH/.dqi; \
   svn update . --quiet --force ;  \
   svn add .  --force --depth infinity ; \
   svn commit . -m 'Update version' --quiet )
endif


exit 0
