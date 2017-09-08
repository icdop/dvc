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
else if ($?verbose_mode == 0) then
   set verbose_mode = 0
endif
set pvar = $verbose_mode


if {(test -e .dvc/env/DESIGN_PHASE)} then
  setenv DESIGN_PHASE `cat .dvc/env/DESIGN_PHASE`
else if {(test -e $HOME/.dvc/env/DESIGN_PHASE)} then
  setenv DESIGN_PHASE `cat $HOME/.dvc/env/DESIGN_PHASE`
else if ($?DESIGN_PHASE == 0) then
  setenv DESIGN_PHASE :
endif

if {(test -e .dvc/env/DESIGN_BLOCK)} then
  setenv DESIGN_BLOCK `cat .dvc/env/DESIGN_BLOCK`
else if {(test -e $HOME/.dvc/env/DESIGN_BLOCK)} then
  setenv DESIGN_BLOCK `cat $HOME/.dvc/env/DESIGN_BLOCK`
else if ($?DESIGN_BLOCK == 0) then
  setenv DESIGN_BLOCK :
endif

if {(test -e .dvc/env/DESIGN_STAGE)} then
  setenv DESIGN_STAGE `cat .dvc/env/DESIGN_STAGE`
else if {(test -e $HOME/.dvc/env/DESIGN_STAGE)} then
  setenv DESIGN_STAGE `cat $HOME/.dvc/env/DESIGN_STAGE`
else if ($?DESIGN_STAGE == 0) then
  setenv DESIGN_STAGE :
endif

if {(test -e .dvc/env/DESIGN_VERSN)} then
  setenv DESIGN_VERSN `cat .dvc/env/DESIGN_VERSN`
else if {(test -e $HOME/.dvc/env/DESIGN_VERSN)} then
  setenv DESIGN_VERSN `cat $HOME/.dvc/env/DESIGN_VERSN`
else if ($?DESIGN_VERSN == 0) then
  setenv DESIGN_VERSN :
endif

if ($pvar == 1) then
  echo "PARM: DESIGN_PHASE = $DESIGN_PHASE"
  echo "PARM: DESIGN_BLOCK = $DESIGN_BLOCK"
  echo "PARM: DESIGN_STAGE = $DESIGN_STAGE"
  echo "PARM: DESIGN_VERSN = $DESIGN_VERSN"
endif
