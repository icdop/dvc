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

if ($1 == "--info") then
   set info_mode = 1
   shift argv
endif

if {(test -e .dop/env/DESIGN_PHASE)} then
  setenv DESIGN_PHASE `cat .dop/env/DESIGN_PHASE`
#else if {(test -e $HOME/.dop/env/DESIGN_PHASE)} then
#  setenv DESIGN_PHASE `cat $HOME/.dop/env/DESIGN_PHASE`
else if ($?DESIGN_PHASE == 0) then
  setenv DESIGN_PHASE :
endif

if {(test -e .dop/env/DESIGN_BLOCK)} then
  setenv DESIGN_BLOCK `cat .dop/env/DESIGN_BLOCK`
#else if {(test -e $HOME/.dop/env/DESIGN_BLOCK)} then
#  setenv DESIGN_BLOCK `cat $HOME/.dop/env/DESIGN_BLOCK`
else if ($?DESIGN_BLOCK == 0) then
  setenv DESIGN_BLOCK :
endif

if {(test -e .dop/env/DESIGN_STAGE)} then
  setenv DESIGN_STAGE `cat .dop/env/DESIGN_STAGE`
#else if {(test -e $HOME/.dop/env/DESIGN_STAGE)} then
#  setenv DESIGN_STAGE `cat $HOME/.dop/env/DESIGN_STAGE`
else if ($?DESIGN_STAGE == 0) then
  setenv DESIGN_STAGE :
endif

if {(test -e .dop/env/DESIGN_VERSN)} then
  setenv DESIGN_VERSN `cat .dop/env/DESIGN_VERSN`
#else if {(test -e $HOME/.dop/env/DESIGN_VERSN)} then
#  setenv DESIGN_VERSN `cat $HOME/.dop/env/DESIGN_VERSN`
else if ($?DESIGN_VERSN == 0) then
  setenv DESIGN_VERSN :
endif

if ( $?info_mode == 1) then
  echo "PARM: DESIGN_PHASE = $DESIGN_PHASE"
  echo "PARM: DESIGN_BLOCK = $DESIGN_BLOCK"
  echo "PARM: DESIGN_STAGE = $DESIGN_STAGE"
  echo "PARM: DESIGN_VERSN = $DESIGN_VERSN"
endif

if {(test -e .dop/env/CURR_PHASE)} then
  setenv CURR_PHASE `cat .dop/env/CURR_PHASE`
else if {(test -e $HOME/.dop/env/CURR_PHASE)} then
  setenv CURR_PHASE `cat $HOME/.dop/env/CURR_PHASE`
else if ($?CURR_PHASE == 0) then
  setenv CURR_PHASE :phase
endif

if {(test -e .dop/env/CURR_BLOCK)} then
  setenv CURR_BLOCK `cat .dop/env/CURR_BLOCK`
else if {(test -e $HOME/.dop/env/CURR_BLOCK)} then
  setenv CURR_BLOCK `cat $HOME/.dop/env/CURR_BLOCK`
else if ($?CURR_BLOCK == 0) then
  setenv CURR_BLOCK :block
endif

if {(test -e .dop/env/CURR_STAGE)} then
  setenv CURR_STAGE `cat .dop/env/CURR_STAGE`
else if {(test -e $HOME/.dop/env/CURR_STAGE)} then
  setenv CURR_STAGE `cat $HOME/.dop/env/CURR_STAGE`
else if ($?CURR_STAGE == 0) then
  setenv CURR_STAGE :stage
endif

if {(test -e .dop/env/CURR_VERSN)} then
  setenv CURR_VERSN `cat .dop/env/CURR_VERSN`
else if {(test -e $HOME/.dop/env/CURR_VERSN)} then
  setenv CURR_VERSN `cat $HOME/.dop/env/CURR_VERSN`
else if ($?CURR_VERSN == 0) then
  setenv CURR_VERSN :version
endif

if {(test -e .dop/env/CURR_CONTR)} then
  setenv CURR_CONTR `cat .dop/env/CURR_CONTR`
else if {(test -e $HOME/.dop/env/CURR_VERSN)} then
  setenv CURR_CONTR `cat $HOME/.dop/env/CURR_CONTR`
else if ($?CURR_CONTR == 0) then
  setenv CURR_CONTR :container
endif
