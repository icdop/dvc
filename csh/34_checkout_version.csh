#!/bin/csh -f
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

echo "INFO: Checkout Project Design Version : $DESIGN_STAGE/$DESIGN_VERSN"
mkdir -p .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN
svn checkout --quiet $PROJT_URL/.dvc .project/$DESIGN_PROJT/.dvc
svn checkout --quiet $PHASE_URL/.dvc .project/$DESIGN_PROJT/$DESIGN_PHASE/.dvc
svn checkout --quiet $BLOCK_URL/.dvc .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/.dvc
svn checkout --quiet $STAGE_URL/.dvc .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/.dvc
svn checkout --quiet $VERSN_URL/.dvc .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/.dvc
svn checkout --quiet $VERSN_URL/.dqi .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/.dqi
rm -f .project/$DESIGN_PROJT/$DESIGN_PHASE/-
rm -f .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/-
rm -f .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/-
ln -s $DESIGN_BLOCK .project/$DESIGN_PROJT/$DESIGN_PHASE/-
ln -s $DESIGN_STAGE .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/-
ln -s $DESIGN_VERSN .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/-

if {(test -h .design)} then
  rm -f .design
else if {(test -d .design)} then
  set d = `date +%Y%m%d_%H%M%S`
  echo "WARN: .design folder exist, rename it to .design.$d !"
  mv .design .design.$d
endif
ln -fs .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK .design

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
