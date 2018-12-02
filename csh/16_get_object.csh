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
source $CSH_DIR/14_get_folder.csh

if (($1 == "-v") || ($1 == "--verbose")) then
   set verbose_mode = 1
   shift argv
endif

if ($1 == "--dir") then
   shift argv
   set dir=$1
   shift argv
   if {(test -e $dir/.dvc/env/DESIGN_CONTR)} then
      # parameter is a container
      setenv CONTAINER_DIR $dir
      setenv CONTAINER_PATH `cat $dir/.dvc/env/DESIGN_PATH`/`cat $dir/.dvc/env/DESIGN_CONTR`
      setenv DESIGN_CONTR `cat $dir/.dvc/env/DESIGN_CONTR`
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

if {(test -e $PTR_VERSN/$DESIGN_CONTR/.dvc/env/DESIGN_CONTR)} then
   setenv CONTAINER_DIR $PTR_VERSN/$DESIGN_CONTR
   if {(test -e $PTR_VERSN/$DESIGN_CONTR/.dvc/env/DESIGN_PATH)} then
      setenv CONTAINER_PATH `cat $CONTAINER_DIR/.dvc/env/DESIGN_PATH`/`cat $CONTAINER_DIR/.dvc/env/DESIGN_CONTR`
   else
      setenv CONTAINER_PATH $DESIGN_BLOCK/$DESIGN_PHASE/$DESIGN_STAGE/$DESIGN_VERSN/$DESIGN_CONTR
   endif
else if {(test -e $PTR_VERSN/$DESIGN_CONTR/.dvc/DESIGN_CONTR)} then
   setenv CONTAINER_DIR $PTR_VERSN/$DESIGN_CONTR
   setenv CONTAINER_PATH $DESIGN_BLOCK/$DESIGN_PHASE/$DESIGN_STAGE/$DESIGN_VERSN/$DESIGN_CONTR
else
   if {(test -e $PROJT_PATH/$DESIGN_CONTR/.dvc/env/DESIGN_CONTR)} then
      setenv CONTAINER_DIR $PROJT_PATH/$DESIGN_CONTR
   else if {(test -e $PROJT_PATH/:/$DESIGN_CONTR/.dvc/env/DESIGN_CONTR)} then
      setenv CONTAINER_DIR $PROJT_PATH/:/$DESIGN_CONTR
   else if {(test -e $PROJT_PATH/:/:/$DESIGN_CONTR/.dvc/env/DESIGN_CONTR)} then
      setenv CONTAINER_DIR $PROJT_PATH/:/:/$DESIGN_CONTR
   else if {(test -e $PROJT_PATH/:/:/:/$DESIGN_CONTR/.dvc/env/DESIGN_CONTR)} then
      setenv CONTAINER_DIR $PROJT_PATH/:/:/:/$DESIGN_CONTR
   else if {(test -e $PROJT_PATH/:/:/:/:/$DESIGN_CONTR/.dvc/env/DESIGN_CONTR)} then
      setenv CONTAINER_DIR $PROJT_PATH/:/:/:/:/$DESIGN_CONTR
   else
      echo "WARNING: undefined container dir : '$DESIGN_CONTR'"
      setenv CONTAINER_DIR $PTR_VERSN/$DESIGN_CONTR
      setenv CONTAINER_PATH $DESIGN_BLOCK/$DESIGN_PHASE/$DESIGN_STAGE/$DESIGN_VERSN/$DESIGN_CONTR
      exit 1
   endif
   setenv CONTAINER_PATH `cat $CONTAINER_DIR/.dvc/env/DESIGN_PATH`/`cat $CONTAINER_DIR/.dvc/env/DESIGN_CONTR`
endif

exit 0
