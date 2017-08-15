#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <SVN_ROOT> <SVN_URL>"
   exit -1
endif
mkdir -p $HOME/.dvc/svn

if ($1 != "") then
    setenv SVN_ROOT  $1
    mkdir -p $SVN_ROOT
    echo $SVN_ROOT  > $HOME/.dvc/svn/SVN_ROOT
else if {(test -e $HOME/.dvc/svn/SVN_ROOT)} then
    setenv SVN_ROOT  `cat $HOME/.dvc/svn/SVN_ROOT`
endif

if ($2 != "") then
    setenv SVN_URL  $2
    echo $SVN_URL   > $HOME/.dvc/svn/SVN_URL
else if {(test -e $HOME/.dvc/svn/SVN_URL)} then
    setenv SVN_URL  `cat $HOME/.dvc/svn/SVN_URL`
else
    setenv SVN_URL  file://$SVN_ROOT
endif

echo "SVN_URL  = $SVN_URL"
