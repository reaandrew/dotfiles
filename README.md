# Dotfiles

Personal development environment configuration with Nord theme.

## Contents

- **bashrc_custom** - Bash aliases, functions, and customizations
- **vimrc** - Vim configuration with plugins (vim-plug)
- **tmux.conf** - Tmux configuration with powerline-style status bar
- **starship.toml** - Starship prompt configuration
- **gitconfig** - Git configuration

## Installation

```bash
git clone https://github.com/reaandrew/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

After installation:
1. Restart terminal or `source ~/.bashrc`
2. Open vim and run `:PlugInstall`
3. Start a new tmux session

## Key Features

### Bash
- Enhanced history (50k entries)
- Git aliases (`gs`, `ga`, `gc`, `gp`, `gl`, etc.)
- Docker aliases (`d`, `dc`, `dps`, `dex`, etc.)
- Directory bookmarks (`mark`, `jump`, `marks`)
- Useful functions (`mkcd`, `extract`, `ff`, `fif`)
- Safety aliases for `rm`, `cp`, `mv`

### Vim
- Nord color scheme
- NERDTree file explorer (`<leader>e`)
- FZF fuzzy finder (`<leader>ff`, `<C-p>`)
- Git integration (fugitive, gitgutter)
- Lightline status bar
- Sensible defaults (relative line numbers, persistent undo)

### Tmux
- Prefix: `Ctrl-a`
- Split panes: `|` (horizontal), `-` (vertical)
- Navigate panes: `h`, `j`, `k`, `l`
- Reload config: `r`
- Mouse support enabled

### Starship
- Powerline-style prompt
- Git status integration
- Language version display (Node, Python, Go, Rust)
- Time display

## Dependencies

- [Starship](https://starship.rs/) - Cross-shell prompt
- [vim-plug](https://github.com/junegunn/vim-plug) - Vim plugin manager
- [Nerd Font](https://www.nerdfonts.com/) - For icons (optional but recommended)

## Update

```bash
cd ~/dotfiles
git pull
```

Vim plugins: `:PlugUpdate`
