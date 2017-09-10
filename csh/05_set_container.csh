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
   mkdir -p .dop/env
   echo $DESIGN_CONTR > .dop/env/DESIGN_CONTR
else
   setenv DESIGN_CONTR `cat .dop/env/DESIGN_CONTR`
endif

if {(test -h .container)} then
#  echo "WARN: remove old .container link!"
   rm -f .container
else if {(test -d .container)} then
   echo "ERROR: .container is a folder, rename it!"
   mv .container .container.`date +%Y%m%d_%H%M%S`
endif

if {(test -e .design_versn)} then
  ln -fs .design_versn/$DESIGN_CONTR .container
else
  ln -fs .project/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/$DESIGN_CONTR .container
endif

echo "SETP: DESIGN_CONTR = $DESIGN_CONTR"
