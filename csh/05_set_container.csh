#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR>"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/
endif
setenv CSH_DIR $DVC_HOME/csh 
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh
source $CSH_DIR/15_get_container.csh

if ($1 != "") then
   if ($1 != ":") then
      setenv DESIGN_CONTR $1
   endif 
   shift argv
endif

if {(test -e $CURR_VERSN/$DESIGN_CONTR/.dvc/CONTAINER)} then
   setenv CONTAINER_DIR $CURR_VERSN/$DESIGN_CONTR
   setenv DVC_PATH `cat $CONTAINER_DIR/.dvc/CONTAINER`
else
   setenv CONTAINER_DIR $PROJT_ROOT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/$DESIGN_CONTR
   setenv DVC_PATH $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/$DESIGN_CONTR
endif

rm -f $CURR_CONTR
if {(test -e $CURR_CONTR)} then
   echo "ERROR: $CURR_CONTR is a folder, rename it!"
else 
   ln -s $CURR_VERSN/$DESIGN_CONTR $CURR_CONTR
endif

echo "SETP: DESIGN_CONTR = $DESIGN_CONTR"

exit 0
