#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <start|stop|file|svn> [SVN_ROOT]"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
setenv ETC_DIR $DVC_HOME/etc
source $CSH_DIR/12_get_server.csh

if ($2 != "") then
   setenv SVN_ROOT $2
   $CSH_DIR/02_set_server SVN_ROOT $SVN_ROOT
endif

mkdir -p $SVN_ROOT/.dvc

if {(test -e $SVN_ROOT/.dvc/svnserve.pid)} then
  setenv SVN_PID      `cat $SVN_ROOT/.dvc/svnserve.pid`
endif


switch($1)
case "file":
  $CSH_DIR/02_set_server.csh SVN_MODE "file"
  $CSH_DIR/02_set_server.csh SVN_URL  "file://$SVN_ROOT"
  breaksw
case "start":
  if (($?SVN_MODE) && ($SVN_MODE == "file")) then
     $CSH_DIR/02_set_server.csh SVN_MODE "file"
     $CSH_DIR/02_set_server.csh SVN_URL  "file://$SVN_ROOT"
     echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
     echo ""
     exit 0
     
  endif
case "svn":
  if ($?SVN_PID) then
     set curr_host = `cat $SVN_ROOT/.dvc/svnserve.host`
     set curr_port = `cat $SVN_ROOT/.dvc/svnserve.port`
     if ($SVN_HOST != $curr_host) then
        echo "EORROR: other SVN server is already runining on another host - $curr_host $curr_port"
        exit -1
     else if ($SVN_PORT != $curr_port) then
        echo "WARNING: other SVN server is already runining on another port - $curr_port "
        echo "Stoping SVN server : $SVN_PID"
        ps -f -p $SVN_PID
        echo `kill -9 $SVN_PID`
        rm -f $SVN_ROOT/.dvc/svnserve.*
     else
        echo "INFO: SVN server is already runining - $curr_host $curr_port "
        ps -f -p $SVN_PID
        $CSH_DIR/02_set_server.csh SVN_MODE "svn"
        $CSH_DIR/02_set_server.csh SVN_HOST $SVN_HOST
        $CSH_DIR/02_set_server.csh SVN_PORT $SVN_PORT
        $CSH_DIR/02_set_server.csh SVN_URL  "svn://$SVN_HOST"":$SVN_PORT/"
        echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
        echo ""
        exit 0
     endif
  endif
     echo "Starting SVN server - svn://$SVN_HOST"":$SVN_PORT/" 
     svnserve -d -r $SVN_ROOT \
                --listen-host=$SVN_HOST --listen-port=$SVN_PORT \
                --pid-file=$SVN_ROOT/.dvc/svnserve.pid --log-file=$SVN_ROOT/.dvc/svnserve.log
     if {(test -e $SVN_ROOT/.dvc/svnserve.pid)} then
        setenv SVN_PID      `cat $SVN_ROOT/.dvc/svnserve.pid`
        ps -f -p $SVN_PID
     endif
     echo $SVN_HOST > $SVN_ROOT/.dvc/svnserve.host
     echo $SVN_PORT > $SVN_ROOT/.dvc/svnserve.port
     $CSH_DIR/02_set_server.csh SVN_MODE "svn"
     $CSH_DIR/02_set_server.csh SVN_HOST $SVN_HOST
     $CSH_DIR/02_set_server.csh SVN_PORT $SVN_PORT
     $CSH_DIR/02_set_server.csh SVN_URL  "svn://$SVN_HOST"":$SVN_PORT/"
  breaksw
case "stop":
  if ($?SVN_PID) then
     echo "Stoping SVN server : $SVN_PID"
     ps -f -p $SVN_PID
     echo `kill -9 $SVN_PID`
     rm -f $SVN_ROOT/.dvc/svnserve.*
  else
     echo "WARNING: No PID file is found."
  endif
  breaksw
case "pid":
  if ($?SVN_PID) then
     ps -f -p $SVN_PID
  endif
  breaksw
default:
  echo "ERROR: Unsupported option '$1'"
  exit -1
endsw

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
