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
if ($1 == "--recursive") then
   set recursive_mode = 1
   shift argv
endif
if ($1 == "--xml") then
   set xml_mode = 1
   shift argv
endif

set pvar = $verbose_mode

if {(test -e .dvc/env/SVN_ROOT)} then
  setenv SVN_ROOT  `cat .dvc/env/SVN_ROOT`
else if {(test -e $HOME/.dvc/server/SVN_ROOT)} then
  setenv SVN_ROOT  `cat $HOME/.dvc/server/SVN_ROOT`
else if ($?SVN_ROOT == 0) then
  setenv SVN_ROOT  $HOME/SVN_ROOT
endif
if ( $pvar == 1) then
  echo "PARM: SVN_ROOT     = $SVN_ROOT"
endif

if {(test -e .dvc/env/SVN_URL)} then
  setenv SVN_URL      `cat .dvc/env/SVN_URL`
else if {(test -e $HOME/.dvc/server/SVN_URL)} then
  setenv SVN_URL      `cat $HOME/.dvc/server/SVN_URL`
else if ($?SVN_URL == 0) then
  setenv SVN_URL      file://$SVN_ROOT
endif

if ( $pvar == 1) then
  echo "PARM: SVN_URL      = $SVN_URL"
endif

if {(test -e .dvc/env/DESIGN_PROJT)} then
  setenv DESIGN_PROJT `cat .dvc/env/DESIGN_PROJT`
else if {(test -e $HOME/.dvc/env/DESIGN_PROJT)} then
  setenv DESIGN_PROJT `cat $HOME/.dvc/env/DESIGN_PROJT`
else if ($?DESIGN_PROJT == 0) then
  setenv DESIGN_PROJT :
endif

if {(test -e .dvc/env/PROJT_URL)} then
  setenv PROJT_URL      `cat .dvc/env/PROJT_URL`
else if {(test -e $HOME/.dvc/server/PROJT_URL)} then
  setenv PROJT_URL      `cat $HOME/.dvc/server/PROJT_URL`
else if ($?PROJT_URL == 0) then
  setenv PROJT_URL      $SVN_URL/$DESIGN_PROJT
endif

if ( $pvar == 1) then
  echo "PARM: PROJT_URL    = $PROJT_URL"
endif
