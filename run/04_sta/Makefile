help:
	@echo "Usage:	make run"
	@echo "		make index"
	@echo "		make clean"

run: 
	script/run.csh

checkout:
	script/checkout.csh
	
list:
	dvc_list_design

html:
	dvc_report_version --html plugin/html
	
index:
	dvc_refresh_index

clean:
	rm -fr : :*
	rm -f index.htm
	
