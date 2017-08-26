#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PROJT>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
setenv DVC_ETC $DOP_HOME/dvc/etc
source $DVC_CSH/12_get_server.csh
source $DVC_CSH/13_get_project.csh
source $DVC_CSH/14_get_version.csh

if (($1 != "") && ($1 != ".")) then
   setenv DESIGN_PROJT $1
   echo "PARA: DESIGN_PROJT = $DESIGN_PROJT"
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
svn info $PROJT_URL >& /dev/null
if ($status == 1) then
   echo "ERROR: Cannot find Project Design Respository : $DESIGN_PROJT"
   exit 1
endif

#svn info $PROJT_URL
echo "URL: $PROJT_URL"
echo "------------------------------------------------------------"
svn list $PROJT_URL -v

exit 0
 