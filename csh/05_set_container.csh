#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR>"
   exit -1
endif
if (($1 == "-v") || ($1 == "--verbose")) then
   set pvar = 1
   shift argv
else
   set pvar = 0
endif

if (($1 != "") && ($1 != ":")) then
   setenv DESIGN_CONTR $1
   mkdir -p .dvc/env
   echo $DESIGN_CONTR > .dvc/env/DESIGN_CONTR
else
   setenv DESIGN_CONTR `cat .dvc/env/DESIGN_CONTR`
endif

echo "PARM: DESIGN_CONTR = $DESIGN_CONTR"

if {(test -d .dvc_version)} then
   setenv DVC_CONTAINER .dvc_version/$DESIGN_CONTR
   if {(test -e $DVC_CONTAINER/.dqi/env/SVN_CONTAINER)} then
      setenv SVN_CONTAINER `cat $DVC_CONTAINER/.dqi/env/SVN_CONTAINER`
   endif
endif
