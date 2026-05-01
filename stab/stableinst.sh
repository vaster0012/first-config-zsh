#!/bin/bash
set -e
echo -e "\e[31m|===========|"
echo -e "Старт установки пакета\e[0m"

sudo apt update
sudo apt install tree zsh git curl fzf wget -y

echo -e "\e[31m|===========|"
echo -e "Установка Oh My Zsh"
echo -e "No. Потом нажми Ctrl + D\e[0m"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo -e "\e[31m|Ставим Powerlevel10k\e[0m"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

echo -e "\e[31m|Ставим плагины\e[0m"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

echo -e "\e[31m|===========|"
echo -e "Последние настройки"
echo -e "Сначала по инструкции ниже, а потом замена основных конфигов\n"
echo -e "No. Потом нажми Ctrl + D\e[0m"

# Если файлы уже существуют (\-f), удаляем их и ставим новые
if [ -f ~/.p10k.zsh ]; then
    echo -e "\e[31m|===========|"
    echo -e "Файл .p10k.zsh существует. Ставлю замену.\e[0m"
    rm -rf ~/.p10k.zsh
fi
    wget https://raw.githubusercontent.com/vaster0012/first-config-zsh/main/stab/.p10k.zsh

# Если файлы уже существуют (\-f), удаляем их и ставим новые
if [ -f ~/.zshrc ]; then
    echo -e "\e[31m|===========|"
    echo -e "Файл .zshrc существует. Ставлю замену.\e[0m"
    rm -rf ~/.zshrc
fi
    wget https://raw.githubusercontent.com/vaster0012/first-config-zsh/main/stab/.zshrc


sudo chsh -s $(which zsh)

echo -e "\e[31m|===========|"
echo -e "======"
echo -e "Готово"
echo -e "======"
echo -e "===========|\e[0m"

exec zsh
