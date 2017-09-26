help: plugin
	make -f plugin/Makefile help



import check run save html view:
	make -f plugin/Makefile $@

design:
	dvc_create_project testcase
	dvc_create_design P1-trial/block/520-sta/2017_0914-xxx
	dvc_checkout_design

checkin:
	dvc_checkin_design

clean:
	rm -fr : :* .dop DQI.rpt DESIGN_FILES

