PATH         :=	../../bin:$(PATH)
####################################################################
SVN_ROOT     := $(HOME)/proj_svn
SVN_MODE     := file
#SVN_URL      := file://$(SVN_ROOT)

####################################################################
# The follwing parameter are checkout pointer configuration.
# Do not change it unless you need to
CURR_PROJT   := :project
CURR_VERSN   := :version
CURR_CONTR   := :container

####################################################################
DESIGN_PROJT := testcase
DESIGN_PHASE := P1-trial
DESIGN_BLOCK := chip
DESIGN_STAGE := 520-sta
DESIGN_VERSN := 2017_0615-xxx
DESIGN_CONTR := ttt_0p80V_25C_rctyp

# The following object will be checkin to container
OBJECT_FILES := design.v run_sta.log
OBJECT_FOLDER:= report/  cache/
OBJECT_LINKS := design.spef

# The following files in :container will be added to repo
# Remember that you have to copy them to :container/ first
ADD_OBJECTS  := design.sdf

# The following files in .container will be removed from repo
DEL_OBJECTS  := cache/

####################################################################
# The following makefile template is required
####################################################################

include ../../etc/make/checkin.make

####################################################################
