help:
	@echo "Usage:	make run"
	@echo "		make index"
	@echo "		make clean"

run: 
	script/run.csh

checkout:
	script/checkout.csh
	
index:
	dvc_refresh_index

clean:
	rm -fr : :*
	rm -fr :version
	rm -fr .dop	
	rm -f index.htm
	
