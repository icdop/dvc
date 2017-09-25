help:
	Usage: make import   -- copy report files into DVC
	Usage: make check    -- check if all required files in DVC
	Usage: make execute  -- execute extraction script
	Usage: make save     -- save DQI into DVC
	Usage: make report   -- generate HTML report 
	@more help.txt

run: import check execute export

import: 
	plugin/script/import.awk INPUT_FILES
	
check:
	plugin/script/check.csh INPUT_FILES
	if ($status == 0) then \
		echo "All required files are" ;\
	else \
		echo "Some input file is missing" ; \
	fi 
	
execute: check
	plugin/run.csh

save:
	plugin/script/saveDQI.awk DQI

report:
	dvc_report_version --html plugin/html 

clean:
	rm -f .dop :* plugin

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
