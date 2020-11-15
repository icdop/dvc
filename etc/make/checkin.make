########################################################################
#
# Design Version Control Checkin Example
#
########################################################################
ifndef SVN_ROOT
SVN_ROOT     := svn_root
endif

ifndef SVN_HOST
SVN_HOST     := $(shell hostname)
endif

ifndef SVN_PORT
SVN_PORT     := 3690
endif

ifndef SVN_URL
SVN_URL      := svn://$(SVN_HOST):$(SVN_PORT)
endif

help:
	@echo "=============================================================="
	@echo "PWD      = $(PWD)"
	@echo "SVN_ROOT = $(SVN_ROOT)"
	@echo "SVN_URL  = $(SVN_URL)"
	@echo "=============================================================="
	@echo "Usage:  make run       run the following steps"
	@echo ""
	@echo "        make init      (reset_resository)"
	@echo "        make project   (create_project; checkout_project)"
	@echo "        make design    (create_design; checkout_design)"
	@echo "        make container (create_container; checkout_container)"
	@echo "        make object    (checkin_object)"
	@echo "        make checkin   (checkin_design)"
	@echo ""
	@echo "Usage:  make tree      (dvc_list_design)"
	@echo "Usage:  make list      (dvc_list_project --recursive)"
	@echo "Usage:  make remove    (remove specific target)"
	@echo "Usage:  make clean     (clean working directory)"
	@echo ""


run:
	mkdir -p log
	make init	| tee log/run.log
	make project	| tee -a log/run.log
	make design	| tee -a log/run.log
	make container	| tee -a log/run.log
	make object	| tee -a log/run.log
	make checkin	| tee -a log/run.log
	make list 	| tee log/list1.rpt
	make tree 	| tee log/tree1.rpt

test:
	make init	| tee log/test.log
	make project	| tee -a log/test.log
	make remove_data| tee -a log/test.log
	make checkout	| tee -a log/test.log
	make tree 	| tee log/checkout.rpt
	make remove_design| tee -a log/test.log
	make version	| tee -a log/test.log
	make container	| tee -a log/test.log
	make update	| tee -a log/test.log
	make object	| tee -a log/test.log
	make commit	| tee -a log/test.log
	make list	| tee log/list2.rpt
	make tree	| tee log/tree2.rpt

diff:
	diff -r log golden | tee diff.log
	grep -i err log/*
	
init: init_server
init_setup:
	@echo "#---------------------------------------------------"
	@echo "# 0. Set Enviroment Variable"
	@echo "#---------------------------------------------------"
	dvc_set_env SVN_ROOT $(SVN_ROOT)
	dvc_set_env SVN_MODE $(SVN_MODE)
	dvc_set_env SVN_HOST $(SVN_HOST)
	dvc_set_env SVN_PORT $(SVN_PORT)

SVN_PID	:= $(SVN_ROOT)/.dvc/svnserve.pid
SVN_LOG	:= $(SVN_ROOT)/.dvc/svnserve.log

init_server:
	@echo "#---------------------------------------------------"
	@echo "# 0. Start SVN server"
	@echo "#---------------------------------------------------"
	dvc_init_server --root $(SVN_ROOT) --mode $(SVN_MODE) --host $(SVN_HOST) --port $(SVN_PORT) restart


stop_server:
	dvc_init_server stop


project: create_project checkout_project
create_project:
	@echo "#---------------------------------------------------"
	@echo "# 1. Initiatize Project Repository"
	@echo "#---------------------------------------------------"
	dvc_create_project	$(DESIGN_PROJT)

design: create_design checkout_design
create_design:
	@echo "#---------------------------------------------------"
	@echo "# 2. Create version directory in SVN server"
	@echo "#---------------------------------------------------"
	dvc_create_design	$(DESIGN_PHASE)/$(DESIGN_BLOCK)/$(DESIGN_STAGE)/$(DESIGN_VERSN)

version: create_version checkout_version
create_version:
	@echo "#---------------------------------------------------"
	@echo "# 2. Create version directory in SVN server"
	@echo "#---------------------------------------------------"
	dvc_create_phase	$(DESIGN_PHASE)
	dvc_create_block	$(DESIGN_BLOCK)
	dvc_create_stage	$(DESIGN_STAGE)
	dvc_create_version	$(DESIGN_VERSN)

checkout: checkout_project checkout_design

checkout_project:
	@echo "#---------------------------------------------------"
	@echo "# 3 Checkout project to '$(PROJT_PATH)' dir"
	@echo "#---------------------------------------------------"
	dvc_checkout_project	$(DESIGN_PROJT) $(PROJT_PATH)

checkout_design:
	@echo "#---------------------------------------------------"
	@echo "# 3 Checkout design"
	@echo "#---------------------------------------------------"
	dvc_checkout_design	$(DESIGN_PHASE)/$(DESIGN_BLOCK)/$(DESIGN_STAGE)/$(DESIGN_VERSN)

checkout_version:
	@echo "#---------------------------------------------------"
	@echo "# 3 Checkout version"
	@echo "#---------------------------------------------------"
	dvc_checkout_phase	$(DESIGN_PHASE)
	dvc_checkout_block	$(DESIGN_BLOCK)
	dvc_checkout_stage	$(DESIGN_STAGE)
	dvc_checkout_version	$(DESIGN_VERSN)

container: create_container checkout_container
create_container:
	@echo "#---------------------------------------------------"
	@echo "# 4-1 Create container"
	@echo "#---------------------------------------------------"
	dvc_create_container	$(DESIGN_CONTR)

checkout_container:
	@echo "#---------------------------------------------------"
	@echo "# 4-2 Checkout container"
	@echo "#---------------------------------------------------"
	dvc_checkout_container	$(DESIGN_CONTR)

object: checkin_object
checkin_object: 
	@echo "#---------------------------------------------------"
	@echo "# 5. Checkin object into container"
	@echo "#---------------------------------------------------"
	make add_object
	make copy_object
	make copy_folder
	make link_object

add_object: 
	@echo "#---------------------------------------------------"
	@echo "# 5-1 Add existing object to container repo"
	@echo "#---------------------------------------------------"
	@for object in $(ADD_OBJECTS) ;  do (\
		if (test -e $(PTR_CONTR)/$$object) then \
			echo "dvc_add_object	$$object" ; \
		else \
			echo "WARNING: object '$$object' is not found, create a dummy file."; \
			echo "`date +%D_$T`" > $(PTR_CONTR)/$$object; \
			echo "dvc_add_object	$$object" ; \
		fi ;\
	); done


copy_object: $(OBJECT_FILES)
	@echo "#---------------------------------------------------"
	@echo "# 5-2 Copy objects to container"
	@echo "#---------------------------------------------------"
	@for object in $(OBJECT_FILES); do (\
		echo "Copying file '$$object' into container ..."; \
		if (test -e $$object) then \
			dvc_copy_object	$$object ; \
		fi ; \
	); done

$(OBJECT_FILES):
	@echo "WARNING: file '$@' does not exist, create a dummy file."
	@echo "`date +%D_$T`" > $@


copy_folder: $(OBJECT_DIRS)
	@echo "#---------------------------------------------------"
	@echo "# 5-2 Copy folders to container"
	@echo "#---------------------------------------------------"
	@for dir in $(OBJECT_DIRS); do (\
		echo "Copying directory '$$dir' into container ..."; \
		if (test -d $$dir) then \
			dvc_copy_object	$$dir $$dir; \
		else \
			echo "ERROR: $$dir is not a directory"; \
		fi ; \
	); done

$(OBJECT_DIRS):
	@echo "WARNING: dir '$@' does not exist, create a dummy folder."
	@mkdir -p $@
	@echo "`date +%D_$T`" > $@/dummy_file


link_object: $(OBJECT_LINKS)
	@echo "#---------------------------------------------------"
	@echo "# 5-3 Crearte symbolic link in container"
	@echo "#---------------------------------------------------"
	@for object in $(OBJECT_LINKS); do \
		echo "Linking object '$$object' in container ..."; \
		if (test -e $$object) then \
			dvc_link_object	$$object $$object; \
		fi ; \
	done

$(OBJECT_LINKS):
	@echo "WARNING: link '$@' does not exist, create a dummy file."
	@echo "`date +%D_$T`" > $@

rename_object:
	@echo "#---------------------------------------------------"
	@echo "# 5-4 Rename file in container"
	@echo "#---------------------------------------------------"
	dvc_rename_object	$(DESIGN_CONTR)	$(RENAME_PAIR)  

delete_object:
	@echo "#---------------------------------------------------"
	@echo "# 5-5 Delete files in container"
	@echo "#---------------------------------------------------"
	@for object in $(DEL_OBJECTS) ;  do \
		dvc_delete_object	$(DESIGN_CONTR)	$$object ; \
	done

update: update_container
update_container:
	@echo "#---------------------------------------------------"
	@echo "# 5-6 Update change into container"
	@echo "#---------------------------------------------------"
	dvc_update_container	$(DESIGN_CONTR)


commit: commit_container
commit_container:
	@echo "#---------------------------------------------------"
	@echo "# 5-6 Commit container checkin to SVN server"
	@echo "#---------------------------------------------------"
	dvc_commit_container	$(DESIGN_CONTR)

clean_container:
	@echo "#---------------------------------------------------"
	@echo "# 5-9 Clean up design object in container"
	@echo "#---------------------------------------------------"
	dvc_clean_container 	$(DESIGN_CONTR)

checkin: checkin_design checkin_container

checkin_design:
	@echo "#---------------------------------------------------"
	@echo "# 6-4 Checkin design folders"
	@echo "#---------------------------------------------------"
	dvc_checkin_design	$(DESIGN_PHASE)/$(DESIGN_BLOCK)/$(DESIGN_STAGE)/$(DESIGN_VERSN)

checkin_version:
	@echo "#---------------------------------------------------"
	@echo "# 6-4 Checkin all files of design version"
	@echo "#---------------------------------------------------"
	dvc_checkin_phase	$(DESIGN_PHASE)
	dvc_checkin_block	$(DESIGN_BLOCK)
	dvc_checkin_stage	$(DESIGN_STAGE)
	dvc_checkin_version	$(DESIGN_VERSN)

checkin_container:
	@echo "#---------------------------------------------------"
	@echo "# 6-5 Checkin all files inside container"
	@echo "#---------------------------------------------------"
	dvc_checkin_container	$(DESIGN_CONTR)


tree:
	dvc_list_design --recursive

list: 
	dvc_list_project --recursive

list_all:
	@echo "#---------------------------------------------------"
	@echo "# 6-1 List all sub folders"
	@echo "#---------------------------------------------------"
	dvc_list_project -v 
	dvc_list_phase -v
	dvc_list_block -v
	dvc_list_stage -v
	dvc_list_version -v
	dvc_list_container -v 

list_dir:
	@echo "#---------------------------------------------------"
	@echo "# 6-2 List all objects in container"
	@echo "#---------------------------------------------------"
	dvc_list_dvc_path -v 

list_env:
	@echo "#---------------------------------------------------"
	@echo "# 6-3 List all variables"
	@echo "#---------------------------------------------------"
	dvc_set_env
	dvc_get_env --info --all


clean:
	@echo
	@echo "************** WARNING *************************"
	@echo
	@echo " This will remove data link on working dir"
	@echo " Use 'make remove_all' to clean up database on server"
	@echo
	@echo "************** WARNING *************************"
	make remove_server
	make remove_data
	make remove_tests
	rm -fr $(SVN_ROOT)
	rm -fr .dop

remove:
	@echo "Usage:"
	@echo "        make remove_data       ; remove checkout project data"
	@echo "        make remove_design     ; remove current design"
	@echo "        make remove_objects    ; remove object files"
	@echo "        make remove_tests      ; remove test report files"
	@echo ""

remove_all:
	make remove_design
	make remove_project
	make remove_data
	make remove_tests

remove_design:
	make remove_container
	make remove_version
	make remove_stage
	make remove_block
	make remove_phase
	
remove_container:
	@echo "#---------------------------------------------------"
	@echo "# 7-1. Clean up container data"
	@echo "#---------------------------------------------------"
	dvc_remove_container	$(DESIGN_CONTR)

remove_version: 
	@echo "#---------------------------------------------------"
	@echo "# 7-2. Clean up design version data"
	@echo "#---------------------------------------------------"
	dvc_remove_version	$(DESIGN_VERSN)

remove_stage: 
	@echo "#---------------------------------------------------"
	@echo "# 7-2. Clean up design stage"
	@echo "#---------------------------------------------------"
	dvc_remove_stage	$(DESIGN_STAGE)

remove_block: 
	@echo "#---------------------------------------------------"
	@echo "# 7-2. Clean up design block"
	@echo "#---------------------------------------------------"
	dvc_remove_block	$(DESIGN_BLOCK)

remove_phase: 
	@echo "#---------------------------------------------------"
	@echo "# 7-2. Clean up design phase"
	@echo "#---------------------------------------------------"
	dvc_remove_phase	$(DESIGN_PHASE)

remove_project:
	@echo "#---------------------------------------------------"
	@echo "# 7-3. Remove proejct repository (For TEST ONLY)"
	@echo "#---------------------------------------------------"
	dvc_remove_project	$(DESIGN_PROJT)

remove_server:
	@echo "#---------------------------------------------------"
	@echo "# 7-3. Remove SVN repository (For TEST ONLY)"
	@echo "#---------------------------------------------------"
	dvc_init_server	stop

remove_data:
	@echo "#---------------------------------------------------"
	@echo "# 7-4. Clean up data checkout directory"
	@echo "#---------------------------------------------------"
	rm -fr $(PROJT_PATH) 
	rm -fr $(PTR_PHASE) $(PTR_BLOCK) $(PTR_STAGE) $(PTR_VERSN) $(PTR_CONTR)

remove_objects:
	@echo "#---------------------------------------------------"
	@echo "# 7-5. Clean up object files in working directory"
	@echo "#---------------------------------------------------"
	rm -fr $(OBJECT_FILES) $(OBJECT_DIRS) $(OBJECT_LINKS)

remove_tests:
	rm -fr log/ tree.rpt list.rpt diff.log


