#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [-dir <container_dir>] [--container <container>]"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/
endif
setenv CSH_DIR $DVC_HOME/csh 
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_design.csh

if (($1 == "-v") || ($1 == "--verbose")) then
   set verbose_mode = 1
   shift argv
endif

if ($1 == "--dir") then
   shift argv
   set dir=$1
   shift argv
   if {(test -e $dir/.dvc/CONTAINER)} then
      # parameter is a container
      setenv CONTAINER_DIR $dir
      setenv CONTAINER_PATH `cat $dir/.dvc/CONTAINER`
      setenv DESIGN_CONTR $CONTAINER_PATH:t
      exit 0
   else
      echo "ERROR: Not a valid container dir : '$dir'"
      exit 1
   endif
endif


if ($1 == "--container") then
   shift argv
   setenv DESIGN_CONTR $1
   shift argv
else if {(test -e .dop/env/DESIGN_CONTR)} then
   setenv DESIGN_CONTR `cat .dop/env/DESIGN_CONTR`
else
   setenv DESIGN_CONTR .
endif

if {(test -e $CURR_VERSN/$DESIGN_CONTR/.dvc/CONTAINER)} then
   setenv CONTAINER_DIR $CURR_VERSN/$DESIGN_CONTR
else if {(test -e $PROJT_ROOT/$DESIGN_CONTR/.dvc/CONTAINER)} then
   setenv CONTAINER_DIR $PROJT_ROOT/$DESIGN_CONTR
else if {(test -e $PROJT_ROOT/:/$DESIGN_CONTR/.dvc/CONTAINER)} then
   setenv CONTAINER_DIR $PROJT_ROOT/:/$DESIGN_CONTR
else if {(test -e $PROJT_ROOT/:/:/$DESIGN_CONTR/.dvc/CONTAINER)} then
   setenv CONTAINER_DIR $PROJT_ROOT/:/:/$DESIGN_CONTR
else if {(test -e $PROJT_ROOT/:/:/:/$DESIGN_CONTR/.dvc/CONTAINER)} then
   setenv CONTAINER_DIR $PROJT_ROOT/:/:/:/$DESIGN_CONTR
else if {(test -e $PROJT_ROOT/:/:/:/:/$DESIGN_CONTR/.dvc/CONTAINER)} then
   setenv CONTAINER_DIR $PROJT_ROOT/:/:/:/:/$DESIGN_CONTR
else
   setenv CONTAINER_DIR $CURR_VERSN
endif

#echo "CONTAINER_DIR = $CONTAINER_DIR"

if {(test -e $CONTAINER_DIR/.dvc/CONTAINER)} then
   setenv CONTAINER_PATH `cat $CONTAINER_DIR/.dvc/CONTAINER`
else
   setenv CONTAINER_PATH :/:/:/:/$DESIGN_CONTR
   echo "ERROR: Not a valid container dir : '$CONTAINER_DIR'"
   exit 1
endif

exit 0
