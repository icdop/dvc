GIT_PATH := https://github.com/VirtualChip/dvc.git
EMAIL    := hclia@hotmail.com
USER     := VirtualChip

help:
	@echo "Usage: make pull"

config:
	git config user.email $(EMAIL)
	git config user.name  $(USER)

pull:
	git pull $(GIT_PATH)

push:
	git push $(GIT_PATH)

	
include etc/make/bin.make
