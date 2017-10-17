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

if {(test -e .dop/.dop/env/PTR_PHASE)} then
  setenv PTR_PHASE `cat .dop/.dop/env/PTR_PHASE`
else if ($?PTR_PHASE == 0) then
  setenv PTR_PHASE :phase
endif

if {(test -e .dop/.dop/env/PTR_BLOCK)} then
  setenv PTR_BLOCK `cat .dop/.dop/env/PTR_BLOCK`
else if ($?PTR_BLOCK == 0) then
  setenv PTR_BLOCK :block
endif

if {(test -e .dop/.dop/env/PTR_STAGE)} then
  setenv PTR_STAGE `cat .dop/.dop/env/PTR_STAGE`
else if ($?PTR_STAGE == 0) then
  setenv PTR_STAGE :stage
endif

if {(test -e .dop/.dop/env/PTR_VERSN)} then
  setenv PTR_VERSN `cat .dop/.dop/env/PTR_VERSN`
else if ($?PTR_VERSN == 0) then
  setenv PTR_VERSN :version
endif

if {(test -e .dop/.dop/env/PTR_VERSN)} then
  setenv PTR_CONTR `cat .dop/.dop/env/PTR_CONTR`
else if ($?PTR_CONTR == 0) then
  setenv PTR_CONTR :container
endif
