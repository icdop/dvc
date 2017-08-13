#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <SVN_ROOT> <SVN_MODE>"
   exit -1
endif
mkdir -p .dvc/env

if ($1 != "") then
    setenv SVN_ROOT  $1
    mkdir -p $SVN_ROOT
    echo $SVN_ROOT  > .dvc/env/SVN_ROOT
else if {(test -e .dvc/env/SVN_ROOT)} then
    setenv SVN_ROOT  `cat .dvc/env/SVN_ROOT`
endif

if ($2 != "") then
    setenv SVN_URL  $2/$SVN_ROOT
    echo $SVN_URL   > .dvc/env/SVN_URL
else if {(test -e .dvc/env/SVN_URL)} then
    setenv SVN_URL  `cat .dvc/env/SVN_URL`
else
    setenv SVN_URL  file://$SVN_ROOT
endif

echo "SVN_URL  = $SVN_URL"
