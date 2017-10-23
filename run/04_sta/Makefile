help:
	@echo "Usage:	make run"
	@echo "		make report"
	@echo "		make clean"

run: 
	script/run.csh

checkout:
	script/checkout.csh

list:
	dvc_list_design
	
index:
	dvc_init_report
	
view:
	firefox	index.htm &
		
clean:
	rm -fr .dop _
	rm -f :phase :block :stage :version :container
	rm -f index.htm index.ccs run.log
	
