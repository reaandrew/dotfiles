# Dotfiles

Personal development environment configuration with Nord theme.

## Contents

- **bashrc_custom** - Shell aliases, functions, and customizations (bash + zsh)
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
1. Restart terminal, or `exec $SHELL -l`
2. Open vim and run `:PlugInstall`
3. Start a new tmux session

`install.sh` wires up both `~/.bashrc` and `~/.zshrc`, so the config loads
whichever shell you land in — bash on Debian, zsh on macOS. `bashrc_custom`
detects the running shell and branches only where it has to (history options,
and the `starship`/`direnv`/`fzf` init hooks); everything else is POSIX and
shared.

### macOS

The configs detect Darwin and adapt (pbcopy instead of xclip, `lsof` instead of
`netstat`, `sysctl hw.ncpu` instead of `nproc`), but macOS ships a BSD userland,
so install the GNU toolchain first:

```bash
brew install starship coreutils fzf jq httpie direnv shellcheck htop tmux
brew install --cask font-fira-code-nerd-font
```

macOS defaults to zsh and the config supports it, so no `chsh` is needed. If you
*prefer* bash, note that macOS ships 3.2 — install bash 5 and switch:

```bash
brew install bash
sudo sh -c 'echo /opt/homebrew/bin/bash >> /etc/shells'
chsh -s /opt/homebrew/bin/bash
```

Then set the terminal font to *FiraCode Nerd Font* so the powerline and devicon
glyphs render.

## Key Features

### Shell (bash + zsh)
- Enhanced history (50k entries)
- Git aliases (`gs`, `ga`, `gc`, `gp`, `gl`, etc.)
- Docker aliases (`d`, `dc`, `dps`, `dex`, etc.)
- Directory bookmarks (`mark`, `jump`, `marks`)
- Useful functions (`mkcd`, `extract`, `ff`, `fdir`, `fif`)
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
