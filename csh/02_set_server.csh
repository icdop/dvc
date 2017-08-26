#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <SVN_ROOT> <SVN_URL> <PROJT_URL>"
   exit -1
endif
mkdir -p $HOME/.dvc/server

if (($1 != "") && ($1 != ":")) then
    setenv SVN_ROOT  $1
    mkdir -p $SVN_ROOT
    echo $SVN_ROOT  > $HOME/.dvc/server/SVN_ROOT
else if {(test -e $HOME/.dvc/server/SVN_ROOT)} then
    setenv SVN_ROOT  `cat $HOME/.dvc/server/SVN_ROOT`
else if ($?SVN_ROOT == 0) then
    setenv SVN_ROOT  $HOME/SVN_ROOT
endif

if (($2 != "") && ($2 != ":")) then
    setenv SVN_URL  $2
    echo $SVN_URL   > $HOME/.dvc/server/SVN_URL
else if {(test -e $HOME/.dvc/server/SVN_URL)} then
    setenv SVN_URL  `cat $HOME/.dvc/server/SVN_URL`
else if ($?SVN_URL == 0) then
    setenv SVN_URL  file://$SVN_ROOT
endif

echo "SETP: SVN_URL  = $SVN_URL"

if (($3 != "") && ($3 != ":")) then
    setenv PROJT_URL  $2
    echo $PROJT_URL   > $HOME/.dvc/server/PROJT_URL
else if {(test -e $HOME/.dvc/server/PROJT_URL)} then
    setenv PROJT_URL  `cat $HOME/.dvc/server/PROJT_URL`
else if ($?PROJT_URL == 0) then
    setenv PROJT_URL  $SVN_URL/testcase
endif

echo "SETP: PROJT_URL  = $PROJT_URL"
