#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <CONTAINER>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
$DVC_CSH/34_checkout_version.csh .
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/12_get_version.csh
if ($1 != "") then
   setenv CONTAINER $1
   echo "PARA: CONTAINER = $CONTAINER"
   mkdir -p .dvc/env
   echo $CONTAINER > .dvc/env/CONTAINER
endif

setenv SVN_CONTAINER $DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/$CONTAINER
svn checkout --quiet $SVN_URL/$SVN_CONTAINER .project/$SVN_CONTAINER

if {(test -h .container)} then
#  echo "WARN: remove old .container link!"
  rm -f .container
else if {(test -d .container)} then
  set d = `date +%Y%m%d_%H%M%S`
  echo "WARN: .container folder exist, rename it to .container.$d !"
  mv .container .container.$d
endif
ln -s .project/$SVN_CONTAINER .container

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
