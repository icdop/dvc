#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_VERSN> <DESIGN_STAGE>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
setenv DVC_ETC $DOP_HOME/dvc/etc
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/12_get_version.csh

if ($1 != ".") then
   setenv DESIGN_VERSN $1
   echo "PARA: DESIGN_VERSN = $DESIGN_VERSN"
   mkdir -p .dvc/env
   echo $DESIGN_VERSN > .dvc/env/DESIGN_VERSN
endif

if (($2 != "") && ($2 != ".")) then
    setenv DESIGN_STAGE $2
    echo $DESIGN_STAGE > .dvc/env/DESIGN_STAGE
    echo "PARA: DESIGN_STAGE = $DESIGN_STAGE"
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
setenv STAGE_URL $BLOCK_URL/$DESIGN_STAGE
setenv VERSN_URL $STAGE_URL/$DESIGN_VERSN
svn info $VERSN_URL >& /dev/null
if ($status == 1) then
   echo "ERROR: Cannot find Project Design Version : $DESIGN_VERSN"
   exit 1
endif

mkdir -p .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN


if {(test -d .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/.dvc)} then
echo "INFO: Update Project Design Version : $DESIGN_STAGE/$DESIGN_VERSN"
svn update --quiet .project/$DESIGN_PROJT/.dvc
svn update --quiet .project/$DESIGN_PROJT/$DESIGN_PHASE/.dvc
svn update --quiet .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/.dvc
svn update --quiet .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/.dvc
svn update --quiet .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/.dqi
else
echo "INFO: Checkout Project Design Version : $DESIGN_STAGE/$DESIGN_VERSN"
svn checkout --quiet $PROJT_URL/.dvc .project/$DESIGN_PROJT/.dvc
svn checkout --quiet $PHASE_URL/.dvc .project/$DESIGN_PROJT/$DESIGN_PHASE/.dvc
svn checkout --quiet $BLOCK_URL/.dvc .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/.dvc
svn checkout --quiet $STAGE_URL/.dvc .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/.dvc
svn checkout --quiet $VERSN_URL/.dvc .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/.dvc
svn checkout --quiet $VERSN_URL/.dqi .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/.dqi
endif

rm -f .project/:
rm -f .project/$DESIGN_PROJT/:
rm -f .project/$DESIGN_PROJT/$DESIGN_PHASE/:
rm -f .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/:
rm -f .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/:
rm -f .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/:
ln -fs $DESIGN_PROJT .project/:
ln -fs $DESIGN_PHASE .project/$DESIGN_PROJT/:
ln -fs $DESIGN_BLOCK .project/$DESIGN_PROJT/$DESIGN_PHASE/:
ln -fs $DESIGN_STAGE .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/:
ln -fs $DESIGN_VERSN .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/:

if {(test -h .dvc_block)} then
  rm -f .dvc_block
else if {(test -d .dvc_block)} then
  set d = `date +%Y%m%d_%H%M%S`
  echo "WARN: design folder .dvc_block exist, rename it to .dvc_block.$d !"
  mv .dvc_block .dvc_block.$d
endif
ln -fs .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK .dvc_block

if {(test -h .dvc_version)} then
  rm -f .dvc_version
else if {(test -d .dvc_version)} then
  set d = `date +%Y%m%d_%H%M%S`
  echo "WARN: design folder .dvc_version exist, rename it to .dvc_version.$d !"
  mv .dvc_version .dvc_version.$d
endif
ln -fs .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN .dvc_version

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
