#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <PROJT_PATH>"
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

if ($1 != "") then
   setenv PROJT_PATH $1
   shift argv
endif
if {(test -e $PROJT_PATH/.dvc/DESIGN_PROJT)} then
   set project=`cat $PROJT_PATH/.dvc/DESIGN_PROJT`
   if (($project != "") && ($project != $DESIGN_PROJT)) then
      if ($?force_mode) then
         echo "WARNING: switching current project ($DESIGN_PROJT) to - $project"
         setenv DESIGN_PROJT
      else
         echo "ERROR: current project ($DESIGN_PROJT) is different from - $project"
         echo "       use --force option to switch it."
         exit 1
      endif
   endif 
endif

echo "INFO: Checkin Project Design Data : $DESIGN_PROJT"
setenv DVC_PATH ""

source $CSH_DIR/69_checkin_dvc_path.csh

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
