#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
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

if {(test -e .dop/env/CURR_CONTR)} then
  setenv CURR_CONTR `cat .dop/env/CURR_CONTR`
else if {(test -e $HOME/.dop/env/CURR_VERSN)} then
  setenv CURR_CONTR `cat $HOME/.dop/env/CURR_CONTR`
else if ($?CURR_CONTR == 0) then
  setenv CURR_CONTR :container
endif

if {(test -h $CURR_CONTR)} then
   rm -f $CURR_CONTR
else if {(test -d $CURR_CONTR)} then
   echo "ERROR: $CURR_CONTR is a folder, rename it!"
   mv $CURR_CONTR container.`date +%Y%m%d_%H%M%S`
endif
ln -fs $CURR_VERSN/$DESIGN_CONTR $CURR_CONTR

echo "SETP: DESIGN_CONTR = $DESIGN_CONTR"

exit 0
