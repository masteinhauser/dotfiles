LIST := $(wildcard _*)
LIST2 = $(LIST:_%=%) # Remove leading underscore, added back in below

all: update
install:
	@for file in $(LIST2); do \
		if [ -e "$$HOME/.$$file" ]; then \
			echo "$$HOME/.$$file exists"; \
		else \
			echo ln -s "$$PWD/_$$file" "$$HOME/.$$file"; \
			ln -sf "$$PWD/_$$file" "$$HOME/.$$file"; \
		fi \
		done
	@vim +PluginInstall +qall

update:
	@vim +PluginInstall +qall
