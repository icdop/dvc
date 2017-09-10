####################################################################
#SVN_ROOT     := $(HOME)/proj_svn
SVN_URL      := file://$(SVN_ROOT)
####################################################################

DESIGN_PROJT := testcase
DESIGN_PHASE := P1-trial
DESIGN_BLOCK := chip
DESIGN_STAGE := 520-STA
DESIGN_VERSN := 2017_0615-xxx
DESIGN_CONTR := ttt_0p80V_25C_rctyp

# The following object will be checkin to container
OBJECT_FILES := design.v run_sta.log
OBJECT_FOLDER:= report/  cache/
OBJECT_LINKS := design.spef

# The following files in .container will be added to repo
ADD_OBJECTS  := design.sdf

# The following files in .container will be removed from repo
DEL_OBJECTS  := cache/

####################################################################

include ../../etc/make/checkin.make

####################################################################
