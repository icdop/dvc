#!/bin/csh -f
#set verbose = 1
if (($1 == "-v") || ($1 == "--verbose")) then
   set pvar = 1
else
   set pvar = 0
endif

if ($?DESIGN_STAGE == 0) then
  setenv DESIGN_STAGE -
endif
if ($?DESIGN_VERSN == 0) then
  setenv DESIGN_VERSN -
endif

if {(test -d .container)} then
  setenv DVC_CONTAINER .container
else
  setenv DVC_CONTAINER .design/$DESIGN_STAGE/$DESIGN_VERSN/.
endif
if {(test -d $DVC_CONTAINER/.svn)} then
else
   echo "ERROR: Not a valide container : $DVC_CONTAINER"
   exit -1
endif
