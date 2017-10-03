help:
	@echo "Usage:   make run"
	@echo "         make refresh"
	@echo "         make clean"

run: 
	script/run.csh

tree:
	dvc_tree_design
	
html:
	dvc_report_version

index:
	dvc_report_index

clean:
	rm -fr _ .dop
	rm -f :phase :block :stage :version :container
	rm -f index.htm
