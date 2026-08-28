#!/usr/bin/env fish

set DOTFILES_DIR (dirname (status --current-filename))
set PACKAGES_DIR $DOTFILES_DIR/packages

echo "=========================================="
echo "      Instalação dos pacotes"
echo "=========================================="
echo ""

# --------------------------------------------------
# Atualização do sistema
# --------------------------------------------------

echo "==> Atualizando o sistema..."

sudo pacman -Syu

if test $status -ne 0
    echo ""
    echo "ERRO: Falha ao atualizar o sistema."
    exit 1
end

echo "    ✓ Sistema atualizado."
echo ""

# --------------------------------------------------
# Pacotes oficiais - Pacman
# --------------------------------------------------

echo "==> Instalando pacotes oficiais..."

if test -f $PACKAGES_DIR/pacman.txt
    sudo pacman -S --needed (cat $PACKAGES_DIR/pacman.txt)

    if test $status -ne 0
        echo "ERRO: Falha ao instalar pacotes via pacman."
        exit 1
    end

    echo "    ✓ Pacotes oficiais instalados."
else
    echo "    AVISO: pacman.txt não encontrado."
end

echo ""

# --------------------------------------------------
# Pacotes AUR - Paru
# --------------------------------------------------

echo "==> Instalando pacotes AUR..."

if test -f $PACKAGES_DIR/aur.txt
    if not command -q paru
        echo "ERRO: paru não está instalado."
        echo "Instale o paru antes de continuar."
        exit 1
    end

    paru -S --needed (cat $PACKAGES_DIR/aur.txt)

    if test $status -ne 0
        echo "ERRO: Falha ao instalar pacotes AUR."
        exit 1
    end

    echo "    ✓ Pacotes AUR instalados."
else
    echo "    AVISO: aur.txt não encontrado."
end

echo ""

# --------------------------------------------------
# Flatpaks
# --------------------------------------------------

echo "==> Instalando Flatpaks..."

if test -f $PACKAGES_DIR/flatpak.txt
    if not command -q flatpak
        echo "ERRO: Flatpak não está instalado."
        exit 1
    end

    for package in (cat $PACKAGES_DIR/flatpak.txt)
        if test -n "$package"
            echo "    Instalando $package..."
            flatpak install -y flathub $package

            if test $status -ne 0
                echo "ERRO: Falha ao instalar $package."
                exit 1
            end
        end
    end

    echo "    ✓ Flatpaks instalados."
else
    echo "    AVISO: flatpak.txt não encontrado."
end

echo ""
echo "=========================================="
echo "      Instalação concluída!"
echo "=========================================="