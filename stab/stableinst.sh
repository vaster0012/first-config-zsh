#!/bin/bash
set -e
echo -e "\e[31m|===========|"
echo -e "Старт установки пакета\e[0m"

sudo apt update
sudo apt install tree zsh git curl fzf wget -yq

echo -e "\e[31m|===========|"
echo -e "Установка Oh My Zsh"
echo -e "No. Потом нажми Ctrl + D\e[0m"

#инсталлятор ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#установка темы powerlevel10k
echo -e "\e[31m|Ставим Powerlevel10k\e[0m"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

#Установка плагинов
echo -e "\e[31m|Ставим плагины\e[0m"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

echo -e "\e[31m|===========|"
echo -e "Последние настройки"
echo -e "Сначала по инструкции ниже, а потом замена основных конфигов\n"
echo -e "No. Потом нажми Ctrl + D\e[0m"

# скачивание и замена уже настроенных конфигов
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

# если запустить с SUDO, то примениться. 
#Не работает на Ya cloud
#chsh -s $(which zsh) $USER || echo -e "\e[31m|\n\n\n\n Запущено без прав root! Оболочка не будет установлена по умолчанию \e[0m"
echo 'exec zsh' >> ~/.bashrc


echo -e "\e[31m|===========|"
echo -e "======"
echo -e "Готово"
echo -e "======"
echo -e "===========|\e[0m"

#устанока traceroute с оставлением конфигов
DEBIAN_FRONTEND=noninteractive apt install -y -q \
  -o Dpkg::Options::="--force-confold" traceroute

echo -e "\e[31m|======Последние приголовления=====|\e[0m"
echo -e "\e[31m|=======Установка доп. утилит======|\e[0m"
sudo apt update -yq
sudo apt install bat unzip net-tool iftop tmux -yq

exec sudo -u zsh 
