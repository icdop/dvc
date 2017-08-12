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
if ($1 == "--pvar") then
   set pvar = 1
   shift argv
else
   set pvar = 0
endif

if {(test -e .dvc/env/DESIGN_PROJT)} then
  setenv DESIGN_PROJT `cat .dvc/env/DESIGN_PROJT`
else if {(test -e $HOME/.dvc/env/DESIGN_PROJT)} then
  setenv DESIGN_PROJT `cat $HOME/.dvc/env/DESIGN_PROJT`
else if ($?DESIGN_PROJT == 0) then
  setenv DESIGN_PROJT :
endif

if {(test -e .dvc/env/DESIGN_PHASE)} then
  setenv DESIGN_PHASE `cat .dvc/env/DESIGN_PHASE`
else if {(test -e $HOME/.dvc/env/DESIGN_PHASE)} then
  setenv DESIGN_PHASE `cat $HOME/.dvc/env/DESIGN_PHASE`
else if ($?DESIGN_PHASE == 0) then
  setenv DESIGN_PHASE -
endif

if {(test -e .dvc/env/DESIGN_BLOCK)} then
  setenv DESIGN_BLOCK `cat .dvc/env/DESIGN_BLOCK`
else if {(test -e $HOME/.dvc/env/DESIGN_BLOCK)} then
  setenv DESIGN_BLOCK `cat $HOME/.dvc/env/DESIGN_BLOCK`
else if ($?DESIGN_BLOCK == 0) then
  setenv DESIGN_BLOCK -
endif

if {(test -e .dvc/env/DESIGN_STAGE)} then
  setenv DESIGN_STAGE `cat .dvc/env/DESIGN_STAGE`
else if {(test -e $HOME/.dvc/env/DESIGN_STAGE)} then
  setenv DESIGN_STAGE `cat $HOME/.dvc/env/DESIGN_STAGE`
else if ($?DESIGN_STAGE == 0) then
  setenv DESIGN_STAGE -
endif

if {(test -e .dvc/env/DESIGN_VERSN)} then
  setenv DESIGN_VERSN `cat .dvc/env/DESIGN_VERSN`
else if {(test -e $HOME/.dvc/env/DESIGN_VERSN)} then
  setenv DESIGN_VERSN `cat $HOME/.dvc/env/DESIGN_VERSN`
else if ($?DESIGN_VERSN == 0) then
  setenv DESIGN_VERSN -
endif

if ( $pvar == 1) then
  echo "DESIGN_PROJT = $DESIGN_PROJT"
  echo "DESIGN_PHASE = $DESIGN_PHASE"
  echo "DESIGN_BLOCK = $DESIGN_BLOCK"
  echo "DESIGN_STAGE = $DESIGN_STAGE"
  echo "DESIGN_VERSN = $DESIGN_VERSN"
endif
