help: plugin
	make -f plugin/Makefile help


design:
	dvc_create_project testcase
	dvc_create_design P1-trail/chip/520-sta/2017_0914-xxx
	dvc_checkout_design

import check run save html :
	make -f plugin/Makefile $@


plugin:
	rm -f plugin
	ln -s 520-sta plugin


clean:
	rm -fr : :* .dop
