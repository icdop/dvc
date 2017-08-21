#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR>"
   exit -1
endif
if (($1 == "-v") || ($1 == "--verbose")) then
   set verbose = 1
   shift argv
endif
if (($1 == "-q") || ($1 == "--quiet")) then
   set pvar = 0
   shift argv
else if ($?pvar == 0) then
   set pvar = 1
endif

if (($1 != "") && ($1 != ":")) then
   setenv DESIGN_CONTR $1
   if {(test -d $DESIGN_CONTR/.dqi)} then
      # parameter is a container
      setenv DVC_CONTAINER $DESIGN_CONTR
      setenv DESIGN_CONTR `cat $DVC_CONTAINER/.dqi/env/DESIGN_CONTR`
   else if {(test -d .dvc_version/$DESIGN_CONTR/.dqi)} then
      setenv DVC_CONTAINER .dvc_version/$DESIGN_CONTR
   else if {(test -d .dvc_block/:/:/$DESIGN_CONTR/.dqi)} then
      setenv DVC_CONTAINER .dvc_block/:/:/$DESIGN_CONTR
   else if {(test -d .project/:/:/:/:/$DESIGN_CONTR/.dqi)} then
      setenv DVC_CONTAINER .project/:/:/:/:/$DESIGN_CONTR
   else
      setenv DVC_CONTAINER .dvc_version/$DESIGN_CONTR
      setenv SVN_CONTAINER :/:/:/:/$DESIGN_CONTR
      echo "ERROR: Not a valid container : $DESIGN_CONTR"
      exit -1
   endif
else if {(test -d .container)} then
  setenv DVC_CONTAINER .container
else
  setenv DVC_CONTAINER .dvc_version
endif

if ($pvar == 1) then
   echo "PARM: DVC_CONTAINER = $DVC_CONTAINER"
endif

if {(test -e $DVC_CONTAINER/.dqi/env/SVN_CONTAINER)} then
   setenv SVN_CONTAINER `cat $DVC_CONTAINER/.dqi/env/SVN_CONTAINER`
else
   setenv SVN_CONTAINER :/:/:/:/$DESIGN_CONTR
   echo "ERROR: Not a valid container : $DVC_CONTAINER"
   exit -1
endif
