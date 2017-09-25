INPUT_FILE := DESIGN_FILES
DQI_REPORT := DQI.rpt

help:
	@echo "=========================================================="
	@echo "Usage: make import   -- copy report files into DVC"
	@echo "Usage: make check    -- check if all required files in DVC"
	@echo "Usage: make execute  -- execute extraction script"
	@echo "Usage: make save     -- save DQI into DVC"
	@echo "Usage: make report   -- generate HTML report "
	@echo "=========================================================="
	@more plugin/help.txt


import: 
	plugin/script/import.awk $(INPUT_FILE)
	
check:
	plugin/script/check.csh $(INPUT_FILE)
	
run: 
	plugin/script/run.csh

save:
	plugin/script/saveDQI.awk $(DQI_REPORT)

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
