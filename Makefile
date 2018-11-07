GIT_PATH := https://github.com/icdop/dvc.git

help:
	@echo "Usage: make bin"

include etc/make/bin.make

pull:
	git pull
	
merge:
	git merge .

commit:
	git commit .
	
push:
	git push 

