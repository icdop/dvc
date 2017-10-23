help:
	@echo "Usage:   make run"
	@echo "         make html"
	@echo "         make clean"

run: 
	script/run.csh

list:
	dvc_list_design
	
index:
	dvc_init_report

clean:
	rm -fr .dop _
	rm -f :phase :block :stage :version :container
	rm -f index.htm index.ccs run.log
