#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [options] <start|stop|status> "
   echo "       options:"
   echo "         --root SVN_ROOT"
   echo "         --mode SVN_MODE"
   echo "         --host SVN_HOST"
   echo "         --port SVN_PORT"
   exit -1
endif
echo "======================================================="
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
setenv ETC_DIR $DVC_HOME/etc
source $CSH_DIR/12_get_server.csh

if ($1 == "--mode") then
   shift argv
   setenv SVN_MODE $1
   shift argv
   $CSH_DIR/00_set_env.csh SVN_MODE $SVN_MODE
endif

if ($1 == "--host") then
   shift argv
   setenv SVN_HOST $1
   shift argv
   $CSH_DIR/00_set_env.csh SVN_HOST $SVN_HOST
endif

if ($1 == "--port") then
   shift argv
   setenv SVN_PORT $1
   shift argv
   $CSH_DIR/00_set_env.csh SVN_PORT $SVN_PORT
endif

if ($1 != "") then
   set command=$1
   shift argv
else
   set command="start"
endif

switch($command)
case "svn":
case "file":
  echo "ERROR: '$prog $command' is obsolete, use '--mode $command' instead"
  breaksw
case "status":
  echo "-------------------------------------------------------"
  echo "INFO: SVN_ROOT = $SVN_ROOT"
  echo "INFO: SVN_MODE = $SVN_MODE"
  if ($SVN_MODE == "svn") then
     echo "INFO: SVN_HOST = $SVN_HOST"
     echo "INFO: SVN_PORT = $SVN_PORT"
     if ($?SVN_PID) then
        echo "INFO: SVN_PID  = $SVN_PID"
        ps -f -p $SVN_PID
#        tail $SVN_ROOT/.dop/svnserve.log
     else
        echo "INFO: SVN_PID  = (Stop)"
     endif
  endif
  breaksw
case "restart":
case "stop":
  if ($?SVN_PID) then
     set svn_host = `cat $SVN_ROOT/.dop/svnserve.host`
     set svn_port = `cat $SVN_ROOT/.dop/svnserve.port`
     set svn_pid  = `cat $SVN_ROOT/.dop/svnserve.pid`
     echo "INFO: Stopping SVN server - svn://$svn_host"":$svn_port/"
     ps -f -p $SVN_PID
     if (($status == 0)||($?force_mode)) then
        echo "INFO: Killing  SVN server process (pid=$SVN_PID)..`kill -9 $SVN_PID`"
        rm -f $SVN_ROOT/.dop/svnserve.*
        unsetenv SVN_PID
     endif 
  else
     echo "WARNING: No server PID file is found."
  endif
  if ($command == "stop") then
     echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
    echo "======================================================="
     exit 0
  endif
case "start":
  if ($SVN_MODE == "file") then
     $CSH_DIR/00_set_env.csh SVN_ROOT $SVN_ROOT
     echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
     echo "======================================================="
     exit 0
  endif
  mkdir -p $SVN_ROOT/.dop/
  if ($?SVN_PID) then
     set svn_host = `cat $SVN_ROOT/.dop/svnserve.host`
     set svn_port = `cat $SVN_ROOT/.dop/svnserve.port`
     if (($SVN_HOST != $svn_host)||($SVN_PORT != $svn_port)) then
        echo "EORROR: SVN server is already runining on differnt port - $svn_host $svn_port"
        $CSH_DIR/00_set_env.csh SVN_HOST $svn_host
        $CSH_DIR/00_set_env.csh SVN_PORT $svn_port
     else
        ps -f -p $SVN_PID
        if ($status == 0) then
           echo "INFO: SVN server is already runining - $svn_host $svn_port "
           $CSH_DIR/00_set_env.csh SVN_MODE "svn"
        else
           echo "ERROR: Can not find SVN server with pid($SVN_PID)"
        endif
     endif
  else
     echo "INFO: Starting SVN server - svn://$SVN_HOST"":$SVN_PORT/" 
     svnserve -d -r $SVN_ROOT \
                --listen-host=$SVN_HOST --listen-port=$SVN_PORT \
                --pid-file=$SVN_ROOT/.dop/svnserve.pid --log-file=$SVN_ROOT/.dop/svnserve.log
     if {(test -e $SVN_ROOT/.dop/svnserve.pid)} then
        setenv SVN_PID      `cat $SVN_ROOT/.dop/svnserve.pid`
        ps -f -p $SVN_PID
        if ($status == 0) then
           echo $SVN_HOST > $SVN_ROOT/.dop/svnserve.host
           echo $SVN_PORT > $SVN_ROOT/.dop/svnserve.port
           $CSH_DIR/00_set_env.csh SVN_ROOT $SVN_ROOT
           $CSH_DIR/00_set_env.csh SVN_HOST $SVN_HOST
           $CSH_DIR/00_set_env.csh SVN_PORT $SVN_PORT
           $CSH_DIR/00_set_env.csh SVN_PID  $SVN_PID
        else
        endif
     endif
  endif
  breaksw
default:
  echo "ERROR: Unsupported command '$command'."
  exit 1
endsw

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
