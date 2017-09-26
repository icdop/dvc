IMPORT_LIST  := DESIGN_FILES
REQUIRE_LIST := REQUIRE_FILES
DQI_LIST     := DQI.rpt

help:
	@echo "=========================================================="
	@echo "Usage: make design   -- create design version folder"
	@echo "Usage: make import   -- copy report files into DVC"
	@echo "Usage: make check    -- check if all required files exit"
	@echo "Usage: make run      -- run extraction script"
	@echo "Usage: make save     -- save DQI value into DVC"
	@echo "Usage: make html     -- generate HTML report "
	@echo "=========================================================="
	@echo "Prepare the following files and copy them to :version"
	@echo "----------------------------------------------------------"
	@cat plugin/$(REQUIRE_LIST)
	@echo ""
	@echo "or Edit the $(IMPORT_LIST) file as below content:"
	@echo "----------------------------------------------------------"
	@cat plugin/$(IMPORT_LIST)
	@echo "=========================================================="
	@more plugin/help.txt

$(IMPORT_LIST):
	cp plugin/$(IMPORT_LIST) .
	@echo "============================================================================="
	@echo "WARNING : Copy file $(IMPORT_LIST) to local directory,"
	@echo "          Please modify the required field before moving to next step."
	@echo "============================================================================="
	@cat $(IMPORT_LIST)
	@echo "============================================================================="
	@vi $(IMPORT_LIST)

design:
	@echo "You need to create a design version folder before move forward"
	@echo "Example:"
	@echo "   dvc_create_project  testcase"
	@echo "   dvc_create_design   P-trial/block/520-sta/2017_0914-xxx"
	@echo "   dvc_checkout_design"
	
import: $(IMPORT_LIST)
	plugin/script/import.awk $(IMPORT_LIST)
	
check:
	plugin/script/check.csh plugin/$(REQUIRE_LIST)
	
run: 
	plugin/script/run.csh

save: $(DQI_LIST)
	plugin/script/saveDQI.awk $(DQI_LIST)

html:
	dvc_report_version --html plugin/html 

clean:
	rm -f .dop :* plugin

view:
	firefox :version/index.htm

link:	
	rm -f .dop
	ln -s ../.dop .
	rm -f :
	ln -s ../: :
	rm -f :version
	ln -s ../:version :version
	rm -f :container
	ln -s ../:container :container
	rm -f plugin
	ln -s . plugin
