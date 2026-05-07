# Tooling

What this dotfiles + devenv combo gives you in a fresh VM (Debian 13 Trixie,
provisioned via `reaandrew/Development/devenv` Vagrantfile).

## Languages

| Tool      | Source                | Notes                                  |
|-----------|-----------------------|----------------------------------------|
| Go        | go.dev tarball, latest| `/usr/local/go/bin`, `GOPATH=$HOME/go` |
| Node.js   | NodeSource LTS        | `node`, `npm`                          |
| Python 3  | apt + pipx            | `python3`, `pip`, `pipx`, venv         |

## CLIs

| Tool         | Command       | Notes                                              |
|--------------|---------------|----------------------------------------------------|
| Claude Code  | `claude`      | npm-installed; run `claude` to start               |
| GitHub CLI   | `gh`          | `gh auth login` first time                         |
| drawio       | `drawio`      | GUI app — for headless export use `xvfb-run drawio --export -f png FILE.drawio` |
| ripgrep      | `rg`          |                                                    |
| fzf          | `fzf`         | Fuzzy finder                                       |
| jq           | `jq`          |                                                    |
| httpie       | `http`        | Friendly curl alternative                          |
| direnv       | `direnv`      | Hooked into bash; per-dir env via `.envrc`         |
| shellcheck   | `shellcheck`  | Shell linter                                       |
| htop         | `htop`        |                                                    |

## Python (via pipx)

| Tool      | Command   | Notes                |
|-----------|-----------|----------------------|
| ruff      | `ruff`    | Linter + formatter   |
| ipython   | `ipython` | Interactive shell    |
| httpie    | `http`    | (also listed above)  |

## Build / Dev

- `build-essential` — gcc, g++, make, libc-dev
- `git`, `curl`, `wget`, `unzip`, `rsync`, `tmux`, `vim`
- `xclip` — clipboard integration (used by tmux config)

## Shell

- **Default**: bash (with `bash-completion`)
- **Prompt**: [starship](https://starship.rs/), config at `~/.config/starship.toml`
- **Custom rc**: `~/.dotfiles/bashrc_custom` is sourced from `~/.bashrc`

PATHs from `/etc/profile.d/devenv-paths.sh`:
```
/usr/local/go/bin
$HOME/go/bin
$HOME/.local/bin
```

## Vim

vim-plug pre-installed at `~/.vim/autoload/plug.vim`. Run `:PlugInstall` first time.

Plugins (see `vimrc` for full list):
- `nordtheme/vim` — colour scheme
- `itchyny/lightline.vim` — statusline
- `preservim/nerdtree` + `ryanoasis/vim-devicons` — file explorer
- `junegunn/fzf.vim` — fuzzy find
- `tpope/vim-fugitive`, `airblade/vim-gitgutter` — git
- `sheerun/vim-polyglot` — syntax for everything

## tmux

Prefix: **`Ctrl-a`** (not the default `Ctrl-b`).

Common binds:
- `prefix r` — reload config
- `prefix |` / `prefix -` — split horizontal / vertical (preserves pwd)
- `prefix h/j/k/l` — move between panes (vim-style)
- `prefix H/J/K/L` — resize panes by 5
- `prefix Tab` — cycle pane
- `prefix c` — new window in current pwd

Mouse on, base-index 1, 50k scrollback, true-color, 0ms escape delay.

## First-run checklist in a fresh VM

```sh
gh auth login                # GitHub CLI
claude                       # Claude Code (auth on first run)
vim +PlugInstall +qa         # install vim plugins
tmux                         # start a session
```
