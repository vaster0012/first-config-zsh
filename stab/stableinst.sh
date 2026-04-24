#!/bin/bash
set -e
echo -e "\e[31m|===========|"
echo -e "Старт установки пакета\e[0m"

sudo apt update
sudo apt install tree zsh git curl fzf -y

echo -e "\e[31m|===========|"
echo -e "Установка инструмента Oh My Zsh\e[0m"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo -e "\e[31m|Ставим Powerlevel10k\e[0m"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

echo -e "\e[31m|Ставим плагины\e[0m"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

cp -fr .zshrc ~/
cp -fr .p10k.zsh ~/



echo -e "\e[31m|===========|"
echo -e "======"
echo -e "Готово"
echo -e "======"
echo -e "===========|\e[0m"

