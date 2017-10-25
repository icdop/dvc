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
source $CSH_DIR/14_get_design.csh
source $CSH_DIR/15_get_container.csh

if ($1 != "") then
   if (($1 != ":") && ($DESIGN_CONTR != $1)) then
      setenv DESIGN_CONTR $1
      $CSH_DIR/00_set_env.csh DESIGN_CONTR $DESIGN_CONTR
      rm -f $PTR_CONTR
      ln -s $PTR_VERSN/$DESIGN_CONTR $PTR_CONTR
   endif 
   shift argv
endif

setenv CONTAINER_PATH $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/$DESIGN_CONTR
setenv CONTAINER_DIR  $PROJT_PATH/$CONTAINER_PATH

if {(test -e $PTR_VERSN/$DESIGN_CONTR/.dvc/env/DESIGN_PATH)} then
   setenv CONTAINER_DIR  $PTR_VERSN/$DESIGN_CONTR
   setenv CONTAINER_PATH `cat $CONTAINER_DIR/.dvc/env/DESIGN_PATH`/$DESIGN_CONTR
else if {(test -e $CONTAINER_DIR)} then
else 
   echo "ERROR: can not find container : '$DESIGN_CONTR'."
   exit 1
endif

exit 0
