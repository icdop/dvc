GIT_PATH := https://github.com/VirtaulChip/dvc.git
EMAIL    := hungchun.li@yahoo.com
USER     := VirtualChip

help:
	@echo "Usage: make bin"

config:
	git config user.email $(EMAIL)
	git config user.name  $(USER)

pull:
	git pull $(GIT_PATH)

push:
	git push $(GIT_PATH)

	
bin: csh
	make -f etc/mak/makefile.bin bin
