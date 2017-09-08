#
# Regress test suite
#
#
TEST_FILE0 = $(TEST_FILE):`date +%Y%m%d` 

help:
	@echo "=============================================================="
	@echo "PWD      = $(PWD)"
	@echo "SVN_ROOT = $(SVN_ROOT)"
	@echo "SVN_URL  = $(SVN_URL)"
	@echo "=============================================================="
	@echo "Usage:"
	@echo "        make run       run the following steps"
	@echo ""
	@echo "        make init      (reset_resository)"
	@echo "        make project   (create_project)"
	@echo "        make version   (create_version; checkout_version)"
	@echo "        make container (create_container; checkout_container)"
	@echo "        make object    (checkin_object)"
	@echo "        make commit    (commit_container)"
	@echo "        make list      (list_version; list_container)"
	@echo ""
	@echo "Usage:  make clean     (clean_data)"
	@echo ""

run:
	make init
	make project
	make version
	make container
	make object
	make commit
	make list


init: reset_repository
reset_repository:
	@echo "#---------------------------------------------------"
	@echo "# 0. Assign SVN ROOT Path"
	@echo "#---------------------------------------------------"
	@echo "SVN_ROOT = $(SVN_ROOT)"
	dvc_set_server $(SVN_ROOT)  $(SVN_URL)

project: init
	@echo "#---------------------------------------------------"
	@echo "# 1. Initiatize Project Repository"
	@echo "#---------------------------------------------------"
	dvc_create_project	$(DESIGN_PROJT)

version: create_version checkout_version
create_version:
	@echo "#---------------------------------------------------"
	@echo "# 2. Create version directory in SVN server"
	@echo "#---------------------------------------------------"
	dvc_create_phase	$(DESIGN_PHASE)
	dvc_create_block	$(DESIGN_BLOCK)
	dvc_create_stage	$(DESIGN_STAGE)
	dvc_create_version	$(DESIGN_VERSN)

checkout: checkout_version
checkout_version:
	@echo "#---------------------------------------------------"
	@echo "# 3 Checkout version"
	@echo "#---------------------------------------------------"
	dvc_checkout_version	$(DESIGN_VERSN) $(DESIGN_STAGE)

container: create_container checkout_container
create_container:
	@echo "#---------------------------------------------------"
	@echo "# 4. Create container"
	@echo "#---------------------------------------------------"
	dvc_create_container	$(DESIGN_CONTR)

checkout_container:
	@echo "#---------------------------------------------------"
	@echo "# 4. Checkout container"
	@echo "#---------------------------------------------------"
	dvc_checkout_container	$(DESIGN_CONTR)

object: clean_container checkin_object
checkin: checkin_object
checkin_object:
	@echo "#---------------------------------------------------"
	@echo "# 5. Checkin file into container"
	@echo "#---------------------------------------------------"
	make add_object
	make copy_object
	make link_object

clean_container:
	@echo "#---------------------------------------------------"
	@echo "# 5-0 Clean up design object in container"
	@echo "#---------------------------------------------------"
	dvc_clean_container 	$(DESIGN_CONTR)

add: add_object
add_object:
	@echo "#---------------------------------------------------"
	@echo "# 5-1 Add existing object to container repo"
	@echo "#---------------------------------------------------"
	@date +%Y%m%d_%H%M%S >> $(TEST_FILE0)
	cp -f $(TEST_FILE0) .container/
	dvc_add_object	$(DESIGN_CONTR)	$(TEST_FILE0)

copy: copy_object
copy_object:
	@echo "#---------------------------------------------------"
	@echo "# 5-2 Copy file to container"
	@echo "#---------------------------------------------------"
	@date +%Y%m%d_%H%M%S >> $(TEST_FILE)
	dvc_copy_object	$(DESIGN_CONTR)	$(TEST_FILE)
	dvc_copy_object	$(DESIGN_CONTR)	$(TEST_FILE)  newfile

link: link_object
link_object:
	@echo "#---------------------------------------------------"
	@echo "# 5-3 Crearte symbolic link in container"
	@echo "#---------------------------------------------------"
	@mkdir -p $(TEST_DIR_)
	@date +%Y%m%d_%H%M%S >> $(TEST_DIR_)/$(TEST_FILE)
	dvc_link_object	$(DESIGN_CONTR)	$(TEST_DIR_)
	dvc_link_object	$(DESIGN_CONTR)	$(TEST_DIR_)  newdir

rename: rename_object
rename_object:
	@echo "#---------------------------------------------------"
	@echo "# 5-4 Rename file in container"
	@echo "#---------------------------------------------------"
	@mkdir -p old_$(TEST_DIR_)
	dvc_copy_object	$(DESIGN_CONTR)	old_$(TEST_DIR_)
	dvc_rename_object	$(DESIGN_CONTR)	old_$(TEST_DIR_)  new_$(TEST_DIR_)

delete: delete_object
delete_object:
	@echo "#---------------------------------------------------"
	@echo "# 5-5 Remove files in container"
	@echo "#---------------------------------------------------"
	dvc_delete_object	$(DESIGN_CONTR)	$(TEST_FILE)
	dvc_delete_object	$(DESIGN_CONTR)	$(TEST_DIR_)

update: update_container
update_container:
	@echo "#---------------------------------------------------"
	@echo "# 5-8 Update change into container"
	@echo "#---------------------------------------------------"
	dvc_update_container	$(DESIGN_CONTR)


commit: commit_container
commit_container:
	@echo "#---------------------------------------------------"
	@echo "# 5-9 Commit change to SVN server"
	@echo "#---------------------------------------------------"
	dvc_commit_container	$(DESIGN_CONTR)

list: list_version list_container list_env
list_version:
	@echo "#---------------------------------------------------"
	@echo "# 6-1 List all data in version"
	@echo "#---------------------------------------------------"
	dvc_list_project -v
	dvc_list_phase -v
	dvc_list_block -v
	dvc_list_stage -v
	dvc_list_version -v

list_container:
	@echo "#---------------------------------------------------"
	@echo "# 6-2 List all data in container"
	@echo "#---------------------------------------------------"
	dvc_list_container -v 

list_env:
	@echo "#---------------------------------------------------"
	@echo "# 6-3 List all variables"
	@echo "#---------------------------------------------------"
	dvc_set_env --local
	dvc_get_env --local --all


clean: clean_data
clean_data: remove_project
	@rm -fr $(TEST_DIR_) $(TEST_FILE) $(TEST_FILE)\:*
	@rm -fr .dvc .project  .container .dvc_*

remove_project: remove_version
	@echo "#---------------------------------------------------"
	@echo "# 7-3. Remove proejct"
	@echo "#---------------------------------------------------"
	dvc_remove_project	$(DESIGN_PROJT)

remove_version: remove_container
	@echo "#---------------------------------------------------"
	@echo "# 7-2. Clean up design version data"
	@echo "#---------------------------------------------------"
	dvc_remove_version	$(DESIGN_VERSN) $(DESIGN_STAGE)
	dvc_remove_stage	$(DESIGN_STAGE)
	dvc_remove_block	$(DESIGN_BLOCK)
	dvc_remove_phase	$(DESIGN_PHASE)

remove_container:
	@echo "#---------------------------------------------------"
	@echo "# 7-1. Clean up container data"
	@echo "#---------------------------------------------------"
	dvc_remove_container	$(DESIGN_CONTR)

