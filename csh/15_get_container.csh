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

if {(test -e .dop/env/DESIGN_CONTR)} then
  setenv DESIGN_CONTR `cat .dop/env/DESIGN_CONTR`
else if {(test -e $HOME/.dop/env/DESIGN_CONTR)} then
  setenv DESIGN_CONTR `cat $HOME/.dop/env/DESIGN_CONTR`
else if ($?DESIGN_CONTR == 0) then
  setenv DESIGN_CONTR :
endif

if (($1 != "") && ($1 != ":")) then
   setenv DESIGN_CONTR $1
   if {(test -d $DESIGN_CONTR/.dqi)} then
      # parameter is a container
      setenv CONTAINER_DIR $DESIGN_CONTR
      setenv DESIGN_CONTR $1:t
   else if {(test -d .design_versn/$DESIGN_CONTR/.dqi)} then
      setenv CONTAINER_DIR .design_versn/$DESIGN_CONTR
   else if {(test -d .design_block/:/:/$DESIGN_CONTR/.dqi)} then
      setenv CONTAINER_DIR .design_block/:/:/$DESIGN_CONTR
   else if {(test -d .project/:/:/:/:/$DESIGN_CONTR/.dqi)} then
      setenv CONTAINER_DIR .project/:/:/:/:/$DESIGN_CONTR
   else
      setenv CONTAINER_DIR .design_versn/$DESIGN_CONTR
      setenv DVC_CONTAINER :/:/:/:/$DESIGN_CONTR
      echo "ERROR: Not a valid container : $DESIGN_CONTR"
      exit -1
   endif
else
   setenv CONTAINER_DIR .container
endif

if ($pvar == 1) then
   echo "PARM: CONTAINER_DIR = $CONTAINER_DIR"
endif

if {(test -e $CONTAINER_DIR/.DVC_CONTAINER)} then
   setenv DVC_CONTAINER `cat $CONTAINER_DIR/.DVC_CONTAINER`
else
   setenv DVC_CONTAINER :/:/:/:/$DESIGN_CONTR
   echo "ERROR: Not a valid container path : $CONTAINER_DIR"
   exit -1
endif
