#!/bin/bash
set -eux

echo "Старт установки ZSH"


sudo apt update
sudo apt install zsh git curl fzf -y

#Проверка установки инструмента плагинов
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo  "Установка плагина Oh My Zsh..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else 
	echo "Oh My Zsh установлен!"
fi
#----------

#Проверка наличия папки .zshrc
if [  -f ".zshrc" ]; then 
	cp .zshrc "$HOME/.zshrc"
	echo ".zshrc применен!"
else
	echo ".zshrc не найден, пропуск"
fi
#----------

#Тоже самое для папки custom
if [  -f "custom" ]; then
	mkdir -p "$HOME/.oh-my-zsh/custom"
	cp -r custom/* "$HOME/.oh-my-zsh/custom/"
	echo "custom применен!"
else
	echo "папка custom не найдена!"
fi
#----------


#Установка zsh как основная 
#
#if command -v zsh >/dev/null 2>&1; then
#	echo "ZSH установлен как основной!"
#	chsh -s "$(which zsh)" || echo "Ошибка! Установите вручную через sudo"
#fi
# Доберусь сюда, как только разберусь. Привет из 2026
echo "Готово"
exec zsh
