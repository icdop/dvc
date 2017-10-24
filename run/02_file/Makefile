PATH         :=	../../bin:$(PATH)
####################################################################
SVN_ROOT     := svn_root
SVN_MODE     := file

####################################################################
# The follwing parameter are checkout pointer configuration.
# Do not change it unless you need to
PTR_PHASE   := :phase
PTR_BLOCK   := :block
PTR_STAGE   := :stage
PTR_VERSN   := :version
PTR_CONTR   := :container

####################################################################
PROJT_BASE   := _
DESIGN_PROJT := 02_file
#----------------------------------
DESIGN_PHASE := P1-trial
DESIGN_BLOCK := chip
DESIGN_STAGE := 520-sta
DESIGN_VERSN := 2017_0620-xxx
#-----------------------------------
DESIGN_CONTR := ttt_0p80V_25C_rctyp

# The following object will be checkin to container
OBJECT_FILES := design.v run_sta.log
OBJECT_DIRS  := report/  cache/
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
