#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR>"
   exit -1
endif
if (($1 == "-v") || ($1 == "--verbose")) then
   set verbose_mode = 1
   shift argv
endif
if (($1 == "-q") || ($1 == "--quiet")) then
   set pvar = 0
   shift argv
else if ($?pvar == 0) then
   set pvar = 1
endif


if (($1 != "") && ($1 != ":")) then
   if {(test -e $1/:CONTAINER)} then
      # parameter is a container
      setenv CONTAINER_DIR $1
      setenv DVC_CONTAINER `cat $CONTAINER_DIR/:CONTAINER`
      setenv DESIGN_CONTR $DVC_CONTAINER:t
      exit 0
   else
      setenv DESIGN_CONTR $1
   endif
else if {(test -e .dop/env/DESIGN_CONTR)} then
  setenv DESIGN_CONTR `cat .dop/env/DESIGN_CONTR`
else
  vsetenv DESIGN_CONTR .
endif
   
if {(test -e .design_versn/$DESIGN_CONTR/:CONTAINER)} then
   setenv CONTAINER_DIR .design_versn/$DESIGN_CONTR
else if {(test -e .project/$DESIGN_CONTR/:CONTAINER)} then
   setenv CONTAINER_DIR .project/$DESIGN_CONTR
else if {(test -e .project/:/$DESIGN_CONTR/:CONTAINER)} then
   setenv CONTAINER_DIR .project/:/$DESIGN_CONTR
else if {(test -e .project/:/:/$DESIGN_CONTR/:CONTAINER)} then
   setenv CONTAINER_DIR .project/:/:/$DESIGN_CONTR
else if {(test -e .project/:/:/:/$DESIGN_CONTR/:CONTAINER)} then
   setenv CONTAINER_DIR .project/:/:/:/$DESIGN_CONTR
else if {(test -e .project/:/:/:/:/$DESIGN_CONTR/:CONTAINER)} then
   setenv CONTAINER_DIR .project/:/:/:/:/$DESIGN_CONTR
else
   setenv CONTAINER_DIR .design_versn/$DESIGN_CONTR
endif

echo "CONTAINER_DIR = $CONTAINER_DIR"

if {(test -e $CONTAINER_DIR/:CONTAINER)} then
   setenv DVC_CONTAINER `cat $CONTAINER_DIR/:CONTAINER`
else
   setenv DVC_CONTAINER :/:/:/:/$DESIGN_CONTR
   echo "ERROR: Not a valid container path : $CONTAINER_DIR"
   exit -1
endif

exit 0
