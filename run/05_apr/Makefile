help:
	@echo "Usage:   make run"
	@echo "         make refresh"
	@echo "         make clean"

run: 
	script/run.csh

	
refresh:
	dvc_refresh_version

clean:
	rm -fr : :*
	rm -fr :version
	rm -fr .dop	
	rm -f index.htm
