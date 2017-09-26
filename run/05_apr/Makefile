help:
	@echo "Usage:   make run"
	@echo "         make refresh"
	@echo "         make clean"

run: 
	script/run.csh

list:
	dvc_list_design
	
html:
	dvc_report_version

index:
	dvc_report_index

clean:
	rm -fr : :*
	rm -fr :version
	rm -fr .dop	
	rm -f index.htm
