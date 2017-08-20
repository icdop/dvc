#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR> <SRC_FILE> <DEST_NAME>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/12_get_version.csh
source $DVC_CSH/15_get_container.csh

if ($2 != "") then
    set src_name = $2
    set dst_name = $2:t
    if ($3 != "") then
        set dst_name = $3
    endif
    if {(test -h $DVC_CONTAINER/$dst_name)} then
       # if dest is link, remove the link first
       rm -f $DVC_CONTAINER/$dst_name
    else if {(test -d $DVC_CONTAINER/$dst_name)} then
       # if dest is dir, add the link
       set destname = $dst_name/$src_name:t
    else if {(test -e $DVC_CONTAINER/$dst_name)} then
       # if dest is file, remove the orginal file
       rm -fr $DVC_CONTAINER/$dst_name
    endif
    ln -f -s $src_name $DVC_CONTAINER/$dst_name
    (cd $DVC_CONTAINER; svn add $dst_name --force)
endif

