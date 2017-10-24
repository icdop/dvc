run: clean
	mkdir -p output
	./run.csh | tee run.log
	grep -v "TIME:" run.log > output/run.log

list:
	dvc_list_design

tree: golden
	tree _ | tee output/tree.log
		
diff: tree
	@diff -r output golden | tee diff.log
	@echo "============================="
	@wc -l diff.log
clean:
	rm -f :phase :block :stage :version :container
	rm -fr .dop _ svn_root testcase
	rm -fr output diff.log run.log
	

