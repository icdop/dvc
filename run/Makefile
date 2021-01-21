CASE	:= 01_case 02_file 03_svn 04_sta 05_apr 

run:
	@for dir in $(CASE) ; do \
	  (echo ""; cd $$dir ; make $@); \
	done	

clean:
	dvc_init_server stop
	@for dir in $(CASE) ; do \
	  (echo ""; cd $$dir ; make $@); \
	done	
	rm -fr svn_root


