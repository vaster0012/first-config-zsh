#!/bin/bash
set -euo pipefail

# Определяем целевого пользователя и домашнюю директорию
if [ "${EUID:-0}" -eq 0 ] && [ -n "${SUDO_USER:-}" ] && [ "${SUDO_USER}" != "root" ]; then
    TARGET_USER="$SUDO_USER"
else
    TARGET_USER="${SUDO_USER:-${USER:-root}}"
fi
TARGET_HOME="$(eval echo "~$TARGET_USER")"

run_as_user() {
    if [ "${EUID:-0}" -eq 0 ]; then
        sudo -u "$TARGET_USER" "$@"
    else
        "$@"
    fi
}

log() {
    echo -e "\e[31m$1\e[0m"
}

log "|===========|"
log "Старт установки пакета"

if [ "${EUID:-0}" -eq 0 ]; then
    apt update
    apt install -yq tree zsh git curl fzf wget
else
    sudo apt update
    sudo apt install -yq tree zsh git curl fzf wget
fi

log "|===========|"
log "Установка Oh My Zsh"
log "No. Потом нажми Ctrl + D"

run_as_user bash -lc 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'

log "|Ставим Powerlevel10k"
run_as_user bash -lc "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git '$TARGET_HOME/.oh-my-zsh/custom/themes/powerlevel10k'"

log "|Ставим плагины"
run_as_user bash -lc "git clone https://github.com/zsh-users/zsh-autosuggestions '$TARGET_HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions'"
run_as_user bash -lc "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git '$TARGET_HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting'"

log "|===========|"
log "Последние настройки"
log "Сначала по инструкции ниже, а потом замена основных конфигов"
log "No. Потом нажми Ctrl + D"

# скачивание и замена уже настроенных конфигов
# Если файлы уже существуют, удаляем их и ставим новые
if [ -f "$TARGET_HOME/.p10k.zsh" ]; then
    log "|===========|"
    log "Файл .p10k.zsh существует. Ставлю замену."
    rm -f "$TARGET_HOME/.p10k.zsh"
fi
run_as_user wget -q -O "$TARGET_HOME/.p10k.zsh" https://raw.githubusercontent.com/vaster0012/first-config-zsh/main/stab/.p10k.zsh

if [ -f "$TARGET_HOME/.zshrc" ]; then
    log "|===========|"
    log "Файл .zshrc существует. Ставлю замену."
    rm -f "$TARGET_HOME/.zshrc"
fi
run_as_user wget -q -O "$TARGET_HOME/.zshrc" https://raw.githubusercontent.com/vaster0012/first-config-zsh/main/stab/.zshrc

if [ "${EUID:-0}" -eq 0 ]; then
    chsh -s "$(command -v zsh)" "$TARGET_USER" || log "Запущено без прав root! Оболочка не будет установлена по умолчанию"
else
    sudo chsh -s "$(command -v zsh)" "$TARGET_USER" || log "Запущено без прав root! Оболочка не будет установлена по умолчанию"
fi

log "|===========|"
log "======"
log "Готово"
log "======"
log "===========|"

if [ "${EUID:-0}" -eq 0 ]; then
    DEBIAN_FRONTEND=noninteractive apt install -y -q \
      -o Dpkg::Options::="--force-confold" traceroute
else
    sudo DEBIAN_FRONTEND=noninteractive apt install -y -q \
      -o Dpkg::Options::="--force-confold" traceroute
fi

if [ "${EUID:-0}" -eq 0 ]; then
    exec sudo -u "$TARGET_USER" zsh
else
    exec zsh
fi
