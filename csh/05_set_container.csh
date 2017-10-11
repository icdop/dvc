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
   if ($1 != "_") then
      setenv DESIGN_CONTR $1
      echo $DESIGN_CONTR > .dop/env/DESIGN_CONTR
   endif 
   shift argv
endif

if {(test -e $PTR_VERSN/$DESIGN_CONTR/.dvc/DESIGN_CONTR)} then
   setenv CONTAINER_DIR $PTR_VERSN/$DESIGN_CONTR
   setenv CONTAINER_PATH `cat $CONTAINER_DIR/.dvc/DVC_PATH`/`cat $CONTAINER_DIR/.dvc/DESIGN_CONTR`
else
   setenv CONTAINER_DIR $PROJT_ROOT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/$DESIGN_CONTR
   setenv CONTAINER_PATH $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/$DESIGN_CONTR
endif

rm -f $PTR_CONTR
if {(test -d $PTR_CONTR)} then
   echo "ERROR: $PTR_CONTR is a folder, rename it!"
else 
   ln -fs $PTR_VERSN/$DESIGN_CONTR $PTR_CONTR
endif

echo "SETP: DESIGN_CONTR = $DESIGN_CONTR"

exit 0
