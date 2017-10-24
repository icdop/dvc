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

set container=$DESIGN_CONTR
if ($1 != "") then
   if ($1 != "_") then
      set container=$1
   endif 
   shift argv
endif

if {(test -d $PTR_VERSN/$container)} then
   rm -f $PTR_CONTR
   ln -s $PTR_VERSN/$container $PTR_CONTR
   setenv DESIGN_CONTR $container
   $CSH_DIR/00_set_env.csh DESIGN_CONTR $DESIGN_CONTR
else
   echo "ERRIR: can not find container '$container'."
   exit 1
endif

if {(test -e $PTR_VERSN/$DESIGN_CONTR/.dvc/DESIGN_CONTR)} then
   setenv CONTAINER_DIR $PTR_VERSN/$DESIGN_CONTR
   setenv CONTAINER_PATH `cat $CONTAINER_DIR/.dvc/DESIGN_PATH`/`cat $CONTAINER_DIR/.dvc/DESIGN_CONTR`
else
   setenv CONTAINER_PATH $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/$DESIGN_CONTR
   setenv CONTAINER_DIR $PROJT_ROOT/$CONTAINER_PATH
endif


exit 0
