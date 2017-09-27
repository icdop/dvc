help:
	@echo "Usage:	make run"
	@echo "		make index"
	@echo "		make clean"

run: 
	script/run.csh

checkout:
	script/checkout.csh
	
tree:
	dvc_tree_design

html:
	dvc_report_version 
	
index:
	dvc_report_index

clean:
	rm -fr : :* .dop
	rm -f index.htm
	
