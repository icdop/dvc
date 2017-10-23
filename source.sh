#!/bin/sh 
DVC_HOME=`pwd`
export DVC_HOME
echo "DVC_HOME = $DVC_HOME"
PATH=$DVC_HOME/bin:$PATH; export PATH

SVN_ROOT=$HOME/svn_root; export SVN_ROOT
 
