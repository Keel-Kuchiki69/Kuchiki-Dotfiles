# CachyOS Dotfiles

Dotfiles e scripts pessoais para reconstruir minha configuração do CachyOS após uma reinstalação.

## Instalação

Clone o repositório:

```bash
git clone https://github.com/Keel-Kuchiki69/Kuchiki-Dotfiles.git
cd Kuchiki-Dotfiles
```

Dê permissão de execução aos scripts, caso necessário:

```bash
chmod +x install.fish install-packages.fish
```

Execute o instalador principal:

```bash
./install.fish
```

O `install.fish` irá:

1. Copiar os arquivos de configuração para seus respectivos diretórios.
2. Restaurar configurações pessoais do usuário.
3. Perguntar se os pacotes devem ser instalados.
4. Caso confirmado, executar automaticamente o `install-packages.fish`.

### Instalação dos pacotes

O `install-packages.fish` instala os pacotes separados em três categorias:

* Pacotes oficiais dos repositórios (`pacman`)
* Pacotes AUR
* Aplicativos Flatpak

As listas podem ser encontradas em:

```text
packages/
├── pacman.txt
├── aur.txt
└── flatpak.txt
```

Para instalar apenas os arquivos de configuração, responda `N` quando o instalador perguntar sobre os pacotes.

## Estrutura

```text
dotfiles/
├── home/
│   ├── .config/
│   └── ES-DE/
├── lists/
│   └── games.txt
├── packages/
│   ├── pacman.txt
│   ├── aur.txt
│   └── flatpak.txt
├── cachyos-config.fish
├── cachyos-config.zsh
├── install.fish
├── install-packages.fish
└── README.md
```

## Observações

* Os arquivos deste repositório são destinados à minha configuração pessoal.
* Arquivos grandes, ROMs, ISOs, saves, BIOS, texturas e outros dados pessoais não são armazenados no GitHub.
* Backups desses arquivos ficam armazenados separadamente.
* Alguns arquivos podem exigir um novo login ou reinicialização do shell para que as alterações tenham efeito.

<!--Listar jogos

for dir in ~/ES-DE/ROMs/*/
    set games (find "$dir" -maxdepth 1 -type f ! -name 'systeminfo.txt' -printf '%f\n' | sed -E 's/\.(iso|chd|cue|bin|rvz|wbfs|nsp|xci|7z|zip|rom)$//' | sort -f)

    if test (count $games) -gt 0
        echo "## "(basename "$dir")
        printf '%s\n' $games
        echo
    end
end > games.txt
-->