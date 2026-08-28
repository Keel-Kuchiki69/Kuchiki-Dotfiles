#!/usr/bin/env fish

# Diretório onde este script está localizado
set DOTFILES_DIR (dirname (status --current-filename))

echo "==> Instalando dotfiles..."
echo ""

# --------------------------------------------------
# Arquivos do HOME
# --------------------------------------------------

echo "==> Restaurando arquivos do HOME..."

cp -r $DOTFILES_DIR/home/. $HOME/

if test $status -ne 0
    echo "ERRO: Não foi possível restaurar os arquivos do HOME."
    exit 1
end

echo "    ✓ Arquivos do HOME restaurados."

# --------------------------------------------------
# Configuração do Fish do CachyOS
# --------------------------------------------------

echo "==> Restaurando configuração do Fish..."

sudo cp \
    $DOTFILES_DIR/system/cachyos-config.fish \
    /usr/share/cachyos-fish-config/cachyos-config.fish

if test $status -ne 0
    echo "ERRO: Não foi possível instalar a configuração do Fish."
    exit 1
end

echo "    ✓ Configuração do Fish restaurada."

# --------------------------------------------------
# Configuração do Zsh do CachyOS
# --------------------------------------------------

echo "==> Restaurando configuração do Zsh..."

sudo cp \
    $DOTFILES_DIR/system/cachyos-config.zsh \
    /usr/share/cachyos-zsh-config/cachyos-config.zsh

if test $status -ne 0
    echo "ERRO: Não foi possível instalar a configuração do Zsh."
    exit 1
end

echo "    ✓ Configuração do Zsh restaurada."

# --------------------------------------------------
# Finalização
# --------------------------------------------------

echo ""
echo "=========================================="
echo " Dotfiles instalados com sucesso!"
echo "=========================================="
echo ""

echo "As configurações foram restauradas."
echo "Algumas alterações podem exigir um novo"
echo "login ou reinicialização do shell."

read -P "Deseja instalar os pacotes? (S/n) " answer

if test -z "$answer" -o "$answer" = "s" -o "$answer" = "S"
    echo ""
    echo "==> Iniciando instalação dos pacotes..."
    echo ""

    fish $DOTFILES_DIR/install-packages.fish

    if test $status -ne 0
        echo ""
        echo "ERRO: A instalação dos pacotes falhou."
        exit 1
    end
else
    echo ""
    echo "Instalação dos pacotes ignorada."
end

echo ""
echo "=========================================="
echo " Processo concluído!"
echo "=========================================="