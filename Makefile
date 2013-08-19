
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
	@git submodule update --init

powerline_font:
	-mkdir ~/.fonts
	@cd ~/.fonts/ && git clone https://github.com/scotu/ubuntu-mono-powerline.git

update:
	@git submodule foreach git checkout master
	@cd _vim/bundle/powerline && git checkout develop
	@git submodule foreach git pull
	@make -s pathogen

pathogen:
	@cd _vim/autoload && rm pathogen.vim && curl -Ss -O https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

setup_cron:
	@touch tmpcron
	-crontab -l >> tmpcron
	@echo "0 0 * * * cd $$HOME/dotfiles && git pull && make install >> /dev/null &2>1" >> tmpcron
	@crontab tmpcron
	@rm tmpcron
