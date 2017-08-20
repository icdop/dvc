#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [-v]"
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

if {(test -e .dvc/env/DESIGN_PROJT)} then
  setenv DESIGN_PROJT `cat .dvc/env/DESIGN_PROJT`
else if {(test -e $HOME/.dvc/env/DESIGN_PROJT)} then
  setenv DESIGN_PROJT `cat $HOME/.dvc/env/DESIGN_PROJT`
else if ($?DESIGN_PROJT == 0) then
  setenv DESIGN_PROJT :
endif

if ($pvar == 1) then
  echo "PARM: DESIGN_PROJT = $DESIGN_PROJT"
endif
