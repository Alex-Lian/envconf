#!/bin/bash

update_apt() {
	echo "###################"
	echo "Updating apt-get..."
	echo "###################"
	sleep 1s
	sudo apt-get update
	sudo apt-get upgrade
}

install_tmux() {
	echo "###################"
	echo "Installing tmux..."
	echo "###################"
	sleep 1s
	sudo apt-get install tmux
	cp .tmux.conf ~/
	tmux source ~/.tmux.conf
}

install_fish() {
	echo "###################"
	echo "Installing fish..."
	echo "###################"
	sleep 1s
	sudo apt-add-repository ppa:fish-shell/release-3
	sudo apt-get update && sudo apt-get upgrade
	sudo apt-get install fish
	cp -r fish ~/.config/
}

pre_nvim() {
	echo "###################"
	echo "Installing pre-reqs for nvim..."
	echo "###################"
	sleep 1s
	sudo apt install git unzip make gcc g++ clang zoxide ripgrep fd-find yarn lldb python3-pip python3-venv gettext curl cmake
	# lazygit
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit /usr/local/bin
	# nvm
	curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
	nvm install 18
	nvm use 18
	# cargo/rustc required by sniprun and rustfmt
	curl https://sh.rustup.rs -sSf | sh
}

install_nvim() {
	echo "###################"
	echo "Installing neovim..."
	echo "###################"
	sleep 1s
	git clone https://github.com/neovim/neovim.git
	cd neovim
	git checkout v0.9.2
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
	cd ..
}

install_nvim_plug() {
	if command -v curl >/dev/null 2>&1; then
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/ayamir/nvimdots/HEAD/scripts/install.sh)"
	else
		bash -c "$(wget -O- https://raw.githubusercontent.com/ayamir/nvimdots/HEAD/scripts/install.sh)"
	fi
}

generate_ssh_key() {
	echo "###################"
	echo "Generating ssh key..."
	echo "###################"
	sleep 1s
	ssh-keygen -t ed25519 -C "lian7@illinois.edu"
}

install() {
	install_tmux
	install_fish
	pre_nvim
	install_nvim
	install_nvim_plug
}

install
