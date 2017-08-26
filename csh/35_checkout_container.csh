#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
source $DVC_CSH/12_get_server.csh
source $DVC_CSH/13_get_project.csh
source $DVC_CSH/14_get_version.csh
if ($1 != "") then
   setenv DESIGN_CONTR $1
   echo "PARA: DESIGN_CONTR = $DESIGN_CONTR"
   mkdir -p .dvc/env
   echo $DESIGN_CONTR > .dvc/env/DESIGN_CONTR
endif

setenv SVN_CONTAINER $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/$DESIGN_CONTR
setenv CONTR_URL $SVN_URL/$DESIGN_PROJT/$SVN_CONTAINER
svn info $CONTR_URL >& /dev/null
if ($status == 1) then
   echo "ERROR: Cannot find container : $SVN_CONTAINER"
   echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
   exit 1
endif

svn checkout --quiet $CONTR_URL .project/$SVN_CONTAINER
mkdir -p .project/$SVN_CONTAINER/.dqi/env
echo $SVN_CONTAINER > .project/$SVN_CONTAINER/.dqi/env/SVN_CONTAINER

if {(test -h .container)} then
#  echo "WARN: remove old .container link!"
  rm -f .container
else if {(test -d .container)} then
  set d = `date +%Y%m%d_%H%M%S`
  echo "WARN: .container folder exist, rename it to .container.$d !"
  mv .container .container.$d
endif
ln -fs .project/$SVN_CONTAINER .container

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
exit 0
