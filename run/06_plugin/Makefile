help: plugin
	make -f plugin/Makefile help

design:
	dvc_create_project 06-plugin
	dvc_create_design P1-trial/block/520-sta/2017_0914-xxx
	dvc_checkout_design

import check run save html view:
	make -f plugin/Makefile $@

checkin:
	dvc_checkin_design

clean:
	rm -fr _ .dop
	rm -f :phase :block :stage :version :container 
	rm -f DQI.rpt DESIGN_FILES

