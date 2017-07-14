#!/bin/csh -f
#set verbose = 1
if (($1 == "-v") || ($1 == "--verbose")) then
   set pvar = 1
else
   set pvar = 0
endif

if {(test -e .dvc/env/SVN_ROOT)} then
  setenv SVN_ROOT  `cat .dvc/env/SVN_ROOT`
else if {(test -e $HOME/.dvc/env/SVN_ROOT)} then
  setenv SVN_ROOT  `cat $HOME/.dvc/env/SVN_ROOT`
else if ($?SVN_ROOT == 0) then
  setenv SVN_ROOT  $HOME/SVN_ROOT
endif
#echo "SVN_ROOT     = $SVN_ROOT"

if {(test -e .dvc/env/SVN_URL)} then
  setenv SVN_URL      `cat .dvc/env/SVN_URL`
else if {(test -e $HOME/.dvc/env/SVN_URL)} then
  setenv SVN_URL      `cat $HOME/.dvc/env/SVN_URL`
else if ($?SVN_URL == 0) then
  setenv SVN_URL      file://$SVN_ROOT
endif

if ( $pvar == 1) then
  echo "SVN_URL      = $SVN_URL"
endif
