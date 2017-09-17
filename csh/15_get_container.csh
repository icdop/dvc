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

if {(test -e .dop/env/DESIGN_CONTR)} then
   setenv DESIGN_CONTR `cat .dop/env/DESIGN_CONTR`
else if ($?DESIGN_CONTR == 0) then
   setenv DESIGN_CONTR .
endif

if {(test -e .dop/env/CURR_CONTR)} then
  setenv CURR_CONTR `cat .dop/env/CURR_CONTR`
#else if {(test -e $HOME/.dop/env/CURR_VERSN)} then
#  setenv CURR_CONTR `cat $HOME/.dop/env/CURR_CONTR`
else if ($?CURR_CONTR == 0) then
  setenv CURR_CONTR :container
endif
   

exit 0
