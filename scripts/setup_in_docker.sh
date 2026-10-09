#!/bin/bash
#
# Set up these dotfiles inside a running Docker container, from the host.
#
# Usage: scripts/setup_in_docker.sh <container> [target_home]   (target_home defaults to /root)
#
# What it does (everything user-level runs as the owner of <target_home>):
#   - copies this repo to <target_home>/dotfiles (replacing any previous copy there)
#   - links .tmux.conf, .vimrc, .bash_aliases and .blerc. NOT .bashrc: the container keeps
#     its own (e.g. lines from its Dockerfile)
#   - clones the tmux plugins, installs zoxide and ble.sh into ~/.local
#   - adds a marked block to <target_home>/.bashrc that sets up zoxide and ble.sh
#     (re-running replaces the block)
#   - as root: installs lsd, plus curl/git/xz-utils via apt if they are missing
# Skipped on purpose: kitty.conf and the Nerd Font, which only the host terminal uses.
#
# Safe to re-run, e.g. to push dotfile edits from the host into the container.

set -euo pipefail

CONTAINER="${1:-}"
TARGET="${2:-/root}"
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ -z "$CONTAINER" ]; then
    echo "Usage: $0 <container> [target_home (default: /root)]"
    exit 1
fi
if [ "$(docker inspect -f '{{.State.Running}}' "$CONTAINER" 2>/dev/null)" != "true" ]; then
    echo "Container '$CONTAINER' is not running."
    exit 1
fi
if ! OWNER="$(docker exec "$CONTAINER" stat -c '%u:%g' "$TARGET" 2>/dev/null)"; then
    echo "'$TARGET' does not exist in container '$CONTAINER'."
    exit 1
fi

echo "Setting up dotfiles in $CONTAINER:$TARGET (as uid:gid $OWNER)"

echo '---------------------------------------------------'
echo 'Step 1: Prerequisites and lsd (as root)...'
docker exec -i -u 0 "$CONTAINER" bash -s <<'EOF'
set -e
missing=""
for tool in curl git xz; do
    command -v "$tool" >/dev/null || missing="$missing $tool"
done
if [ -n "$missing" ]; then
    if command -v apt-get >/dev/null; then
        echo "Installing missing:$missing"
        apt-get update -qq
        DEBIAN_FRONTEND=noninteractive apt-get install -y -qq curl git xz-utils ca-certificates >/dev/null
    else
        echo "Missing:$missing (and no apt-get). Install them in the container first."
        exit 1
    fi
fi

if command -v lsd >/dev/null; then
    echo "lsd already installed"
elif command -v dpkg >/dev/null && [ "$(dpkg --print-architecture)" = "amd64" ]; then
    curl -sSL -o /tmp/lsd.deb "https://github.com/lsd-rs/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb"
    dpkg -i /tmp/lsd.deb >/dev/null
    rm /tmp/lsd.deb
    echo "Installed lsd"
else
    echo "Skipping lsd (needs dpkg on amd64); ls stays the plain ls"
fi
EOF

echo '---------------------------------------------------'
echo "Step 2: Copying dotfiles to $TARGET/dotfiles..."
docker exec -u "$OWNER" "$CONTAINER" bash -c "rm -rf '$TARGET/dotfiles' && mkdir -p '$TARGET/dotfiles'"
tar -C "$DOTFILES_DIR" --exclude=.git -cf - . | docker exec -i -u "$OWNER" "$CONTAINER" tar -C "$TARGET/dotfiles" -xf -

echo '---------------------------------------------------'
echo 'Step 3: Links, tmux plugins, zoxide, ble.sh, .bashrc block...'
docker exec -i -u "$OWNER" -e HOME="$TARGET" "$CONTAINER" bash -s <<'EOF'
set -e
cd "$HOME"

# tmux plugins (same set as setup.sh)
for repo in tmux-plugins/tpm tmux-plugins/tmux-resurrect tmux-plugins/tmux-cpu christoomey/vim-tmux-navigator; do
    dir="$HOME/.tmux/plugins/${repo#*/}"
    [ -d "$dir" ] || git clone -q "https://github.com/$repo" "$dir"
done

# Config links (no .bashrc, no kitty.conf)
for f in .tmux.conf .vimrc .bash_aliases .blerc; do
    ln -sfn "$HOME/dotfiles/$f" "$HOME/$f"
done

# zoxide -> ~/.local/bin
if [ ! -x "$HOME/.local/bin/zoxide" ]; then
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh >/dev/null
    echo "Installed zoxide"
fi

# ble.sh -> ~/.local/share/blesh
if [ ! -f "$HOME/.local/share/blesh/ble.sh" ]; then
    tmp="$(mktemp -d)"
    curl -sSL https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar -C "$tmp" -xJf -
    mkdir -p "$HOME/.local/share/blesh"
    cp -Rf "$tmp"/ble-nightly/* "$HOME/.local/share/blesh/"
    rm -rf "$tmp"
    echo "Installed ble.sh"
fi

# .bashrc block: replace any previous one, then append
touch "$HOME/.bashrc"
sed -i '/^# >>> dotfiles >>>$/,/^# <<< dotfiles <<<$/d' "$HOME/.bashrc"
{
    echo '# >>> dotfiles >>>'
    echo '# Added by dotfiles/scripts/setup_in_docker.sh (re-running it replaces this block)'
    if ! grep -q '\.bash_aliases' "$HOME/.bashrc"; then
        echo '[ -f ~/.bash_aliases ] && . ~/.bash_aliases'
    fi
    echo '[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"'
    echo 'command -v zoxide >/dev/null && eval "$(zoxide init bash --cmd cd)"'
    echo '[[ $- == *i* ]] && [ -f ~/.local/share/blesh/ble.sh ] && source ~/.local/share/blesh/ble.sh'
    echo '# <<< dotfiles <<<'
} >> "$HOME/.bashrc"
EOF

echo '---------------------------------------------------'
SHELL_HOME="$(docker exec "$CONTAINER" sh -c 'echo $HOME')"
if [ "$SHELL_HOME" != "$TARGET" ]; then
    echo "Note: 'docker exec' into $CONTAINER starts in $SHELL_HOME, not $TARGET."
    echo "      Re-run with '$SHELL_HOME' as target_home to set up that user's shell."
fi
echo "Done. Open a new shell in the container to use it, e.g. docker exec -it $CONTAINER bash"
