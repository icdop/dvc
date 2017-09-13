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

if {(test -e .dop/env/DESIGN_PROJT)} then
  setenv DESIGN_PROJT `cat .dop/env/DESIGN_PROJT`
else if {(test -e $HOME/.dop/env/DESIGN_PROJT)} then
  setenv DESIGN_PROJT `cat $HOME/.dop/env/DESIGN_PROJT`
else if ($?DESIGN_PROJT == 0) then
  setenv DESIGN_PROJT :
endif

if ($pvar == 1) then
  echo "PARM: DESIGN_PROJT = $DESIGN_PROJT"
endif


if {(test -e .dop/env/PROJT_URL)} then
  setenv PROJT_URL      `cat .dop/env/PROJT_URL`
else if {(test -e $HOME/.dop/env/PROJT_URL)} then
  setenv PROJT_URL      `cat $HOME/.dop/env/PROJT_URL`
else if ($?PROJT_URL == 0) then
  setenv PROJT_URL      $SVN_URL/$DESIGN_PROJT
endif

if ( $?info_mode == 1) then
  echo "PARM: PROJT_URL    = $PROJT_URL"
endif
