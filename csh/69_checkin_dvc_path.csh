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

if (($1 != "") && ($1 != "_") && ($1 != ".")) then
   setenv DVC_PATH $1
else if ($?DVC_PATH == 0) then
   source $CSH_DIR/14_get_folder.csh
   setenv DVC_PATH $DESIGN_BLOCK/$DESIGN_PHASE/$DESIGN_STAGE/$DESIGN_VERSN
endif

if (($PROJT_PATH == "")||($PROJT_PATH == ".")) then
   setenv DESIGN_PATH ./$DVC_PATH
else
   setenv DESIGN_PATH $PROJT_PATH/$DVC_PATH
endif

if ($?depth_mode == 0) then
   set depth_mode=files
endif

if {(test -d $DESIGN_PATH)} then
 (cd $DESIGN_PATH; \
 svn add .  --force --depth $depth_mode ; \
 svn update . --quiet --force ;  \
 svn commit . -m 'Update design folder' --quiet )
else
 echo "ERROR: Cannot find Design Directory '$DESIGN_PATH'"
 exit 1
endif

if {(test -e $DESIGN_PATH/.dvc)} then
   (cd $DESIGN_PATH/.dvc; \
   svn add .  --force --depth infinity ; \
   svn update . --quiet --force ;  \
   svn commit . -m 'Update dvc' --quiet )
endif

if {(test -e $DESIGN_PATH/.dqi)} then
   (cd $DESIGN_PATH/.dqi; \
   svn add .  --force --depth infinity ; \
   svn update . --quiet --force ;  \
   svn commit . -m 'Update dqi' --quiet )
endif

if {(test -e $DESIGN_PATH/.htm)} then
   (cd $DESIGN_PATH/.htm; \
   svn update . --quiet --force ;  \
   svn add .  --force --depth infinity ; \
   svn commit . -m 'Update html report' --quiet )
endif

exit 0
