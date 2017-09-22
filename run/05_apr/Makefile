help:
	@echo "Usage:	make run"
	@echo "		make index"
	@echo "		make clean"

run: 
	script/run.csh

checkout:
	script/checkout.csh
	
index:
	dvc_init_report

clean:
	rm -fr : :*
	rm -fr :version
	rm -fr .dop	
	rm index.htm
