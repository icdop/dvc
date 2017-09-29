#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [-v]"
   exit -1
endif

if (($1 == "-v") || ($1 == "--verbose")) then
   set verbose_mode = 1
   shift argv
endif

if ($1 == "--info") then
   set info_mode = 1
   shift argv
endif

if {(test -e .dop/env/DESIGN_PHASE)} then
  setenv DESIGN_PHASE `cat .dop/env/DESIGN_PHASE`
else if ($?DESIGN_PHASE == 0) then
  setenv DESIGN_PHASE _
endif

if {(test -e .dop/env/DESIGN_BLOCK)} then
  setenv DESIGN_BLOCK `cat .dop/env/DESIGN_BLOCK`
else if ($?DESIGN_BLOCK == 0) then
  setenv DESIGN_BLOCK _
endif

if {(test -e .dop/env/DESIGN_STAGE)} then
  setenv DESIGN_STAGE `cat .dop/env/DESIGN_STAGE`
else if ($?DESIGN_STAGE == 0) then
  setenv DESIGN_STAGE _
endif

if {(test -e .dop/env/DESIGN_VERSN)} then
  setenv DESIGN_VERSN `cat .dop/env/DESIGN_VERSN`
else if ($?DESIGN_VERSN == 0) then
  setenv DESIGN_VERSN _
endif

if ($?info_mode) then
  echo "INFO: DESIGN_PHASE = $DESIGN_PHASE"
  echo "INFO: DESIGN_BLOCK = $DESIGN_BLOCK"
  echo "INFO: DESIGN_STAGE = $DESIGN_STAGE"
  echo "INFO: DESIGN_VERSN = $DESIGN_VERSN"
endif
