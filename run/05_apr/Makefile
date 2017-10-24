help:
	@echo "Usage:   make run"
	@echo "         make diff"
	@echo "         make clean"

run: 
	mkdir -p log
	script/run.csh 2| tee run.log
list:
	dvc_list_project --recursive

log/list.log:
	make list > log/list.log	
tree:	
	dvc_list_design --recursive

log/tree.log:
	make tree > log/tree.log

diff: log/list.log log/tree.log
	diff -r log golden | tee diff.log
	
index:
	dvc_init_report

view:
	firefox	index.htm &

clean:
	dvc_remove_project 05-apr
	rm -fr .dop log _
	rm -f :phase :block :stage :version :container
	rm -f index.htm index.ccs run.log diff.log
