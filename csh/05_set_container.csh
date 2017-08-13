#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
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
   echo "PARA: DESIGN_CONTR = $DESIGN_CONTR"
   mkdir -p .dvc/env
   echo $DESIGN_CONTR > .dvc/env/DESIGN_CONTR
   if {(test -d $DESIGN_CONTR/.dqi)} then
      # parameter a is container
      setenv DVC_CONTAINER $CONTAINER
   else if {(test -d .dvc_version)} then
      setenv DVC_CONTAINER .dvc_version/$DESIGN_CONTR
   endif
else if {(test -h .container)} then
  setenv DVC_CONTAINER .container
else
  setenv DVC_CONTAINER .
endif

if ($pvar == 1) then
   echo "PARA: DVC_CONTAINER = $DVC_CONTAINER"
endif
if {(test -e $DVC_CONTAINER/.dvc/env/SVN_CONTAINER)} then
   setenv SVN_CONTAINER `cat $DVC_CONTAINER/.dvc/env/SVN_CONTAINER`
else
   setenv SVN_CONTAINER ":/:/:/:/:/$DESIGN_CONTR"
   echo "ERROR: Not a valid container : $DVC_CONTAINER"
   exit -1
endif
if {(test -d $DVC_CONTAINER/.svn)} then
else
   echo "ERROR: Not a valid SVN folder : $DVC_CONTAINER"
endif
