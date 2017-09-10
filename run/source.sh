#!/bin/sh 
cd ../..
DVC_HOME=`pwd`
export DVC_HOME
cd -
echo "DVP_HOME = $DVP_HOME"
PATH=$DOP_HOME/dvc/bin:$PATH; export PATH

SVN_ROOT=$HOME/proj_svn; export SVN_ROOT
#SVN_URL=file://$SVN_ROOT; export SVN_URL
 
