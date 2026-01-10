#!/bin/bash
# ══════════════════════════════════════════════════════════════════════════════
#  Dotfiles Installation Script
# ══════════════════════════════════════════════════════════════════════════════

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# ─────────────────────────────────────────────────────────────────────────────
#  Backup existing dotfiles
# ─────────────────────────────────────────────────────────────────────────────
backup_file() {
    local file="$1"
    if [ -e "$file" ] || [ -L "$file" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$file" "$BACKUP_DIR/"
        warn "Backed up $file to $BACKUP_DIR/"
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
#  Create symlinks
# ─────────────────────────────────────────────────────────────────────────────
link_file() {
    local src="$1"
    local dest="$2"

    backup_file "$dest"
    ln -sf "$src" "$dest"
    info "Linked $dest -> $src"
}

# ─────────────────────────────────────────────────────────────────────────────
#  Install dependencies
# ─────────────────────────────────────────────────────────────────────────────
install_dependencies() {
    info "Checking dependencies..."

    # Install vim-plug if not present
    if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
        info "Installing vim-plug..."
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        info "vim-plug already installed"
    fi

    # Check for starship
    if ! command -v starship &> /dev/null; then
        warn "Starship not found. Install it with:"
        echo "    curl -sS https://starship.rs/install.sh | sh"
    else
        info "Starship already installed"
    fi

    # Create vim undo directory
    mkdir -p "$HOME/.vim/undodir"
}

# ─────────────────────────────────────────────────────────────────────────────
#  Main installation
# ─────────────────────────────────────────────────────────────────────────────
main() {
    echo "══════════════════════════════════════════════════════════════════════════════"
    echo "  Dotfiles Installation"
    echo "══════════════════════════════════════════════════════════════════════════════"
    echo ""

    # Create config directory
    mkdir -p "$HOME/.config"

    # Link configuration files
    link_file "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"
    link_file "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"
    link_file "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
    link_file "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"

    # Install dependencies
    install_dependencies

    # Append bashrc_custom to .bashrc if not already sourced
    if ! grep -q "source.*dotfiles/bashrc_custom" "$HOME/.bashrc" 2>/dev/null; then
        echo "" >> "$HOME/.bashrc"
        echo "# Load custom bash configuration" >> "$HOME/.bashrc"
        echo "[ -f \"$DOTFILES_DIR/bashrc_custom\" ] && source \"$DOTFILES_DIR/bashrc_custom\"" >> "$HOME/.bashrc"
        info "Added bashrc_custom to .bashrc"
    else
        info "bashrc_custom already sourced in .bashrc"
    fi

    echo ""
    echo "══════════════════════════════════════════════════════════════════════════════"
    echo "  Installation complete!"
    echo "══════════════════════════════════════════════════════════════════════════════"
    echo ""
    echo "Next steps:"
    echo "  1. Restart your terminal or run: source ~/.bashrc"
    echo "  2. Open vim and run: :PlugInstall"
    echo "  3. Start a new tmux session"
    echo ""

    if [ -d "$BACKUP_DIR" ]; then
        echo "Your original dotfiles were backed up to: $BACKUP_DIR"
    fi
}

main "$@"
