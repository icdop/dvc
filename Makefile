GIT_PATH := https://github.com/icdop/dvc.git

help:
	@echo "Usage: make bin"

include etc/make/bin.make

pull:
	git pull $(GIT_PATH)

push:
	git push $(GIT_PATH)

