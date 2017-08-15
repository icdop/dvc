##################################
DOP_HOME     := $(realpath $(PWD)/../../..)
PATH         := $(PATH):$(DOP_HOME)/dvc/bin

SVN_ROOT     := /var/svn/project
SVN_HOST     := localhost
SVN_PORT     := 3690
SVN_URL      := svn://$(SVN_HOST):$(SVN_PORT)

##################################
DESIGN_PROJT := testcase
DESIGN_PHASE := P1-trial
DESIGN_BLOCK := chip
DESIGN_STAGE := 400-APR
DESIGN_VERSN := 2017_0615-xxx
DESIGN_CNTNR := place_opt

TEST_FILE    := testfile
TEST_DIR_    := testdir

include $(DOP_HOME)/dvc/etc/mak/makefile.design
include $(DOP_HOME)/dvc/etc/mak/makefile.test

svnserve:
	mkdir -p $(SVN_ROOT)
	svnserve -d -r $(SVN_ROOT) --listen-host=$(SVN_HOST) --listen-port=$(SVN_PORT)
	

