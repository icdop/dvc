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
source $DVC_CSH/12_get_version.csh
source $DVC_CSH/11_get_svn.csh

if ($1 != "") then
   setenv CONTAINER $1
   echo "PARA: CONTAINER = $CONTAINER"
endif

$DVC_CSH/34_checkout_version.csh .

setenv DVC_CONTAINER $DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/$CONTAINER
svn checkout --quiet $SVN_URL/$DVC_CONTAINER .project/$DVC_CONTAINER

if {(test -h .container)} then
  echo "WARN: remove old .container link!"
  rm -f .container
else if {(test -d .container)} then
  set d = `date +%Y%m%d_%H%M%S`
  echo "WARN: .contrainer folder exist, rename it to .container.$d !"
  mv .container .container.$d
endif
ln -s .project/$DVC_CONTAINER .container
mkdir -p .dvc/env
echo $DVC_CONTAINER > .dvc/env/DVC_CONTAINER

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
