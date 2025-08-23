#!/bin/bash

# btt-inline.sh
# Inline script for BetterTouchTool - self-contained with absolute paths
# Usage in BTT: /bin/bash -c "$(cat /Users/william/.config/nvim/scripts/btt-inline.sh) [connect|disconnect|toggle|auto]"
# Or paste this script content directly in BTT with argument: connect|disconnect|toggle|auto

NVIM_CONFIG_DIR="$HOME/.config/nvim"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Function to display notifications
notify() {
    local message="$1"
    local level="$2"
    
    case "$level" in
        "error")
            echo -e "${RED}ERROR: $message${NC}"
            /usr/bin/osascript -e "display notification \"$message\" with title \"Neovim Config\" sound name \"Basso\""
            ;;
        "success")
            echo -e "${GREEN}SUCCESS: $message${NC}"
            /usr/bin/osascript -e "display notification \"$message\" with title \"Neovim Config\" sound name \"Glass\""
            ;;
        "info")
            echo -e "${BLUE}INFO: $message${NC}"
            /usr/bin/osascript -e "display notification \"$message\" with title \"Neovim Config\""
            ;;
        "warning")
            echo -e "${YELLOW}WARNING: $message${NC}"
            /usr/bin/osascript -e "display notification \"$message\" with title \"Neovim Config\" sound name \"Funk\""
            ;;
    esac
}

# Function to check if Neovim is running
is_nvim_running() {
    /usr/bin/pgrep -f "nvim" > /dev/null
}

# Function to reload Neovim
reload_nvim() {
    if command -v nvr &> /dev/null; then
        nvr --remote-send ':source ~/.config/nvim/init.lua<CR>' 2>/dev/null || true
    fi
    
    if is_nvim_running; then
        notify "Neovim is running. Please restart or run :source ~/.config/nvim/init.lua to apply changes" "info"
    fi
}

# Main switch function
switch_config() {
    local keyboard_type="$1"
    local target_branch
    
    if [[ "$keyboard_type" == "glove80" ]]; then
        target_branch="glove80"
    else
        target_branch="main"
    fi
    
    # Change to nvim config directory
    cd "$NVIM_CONFIG_DIR" || {
        notify "Failed to change to Neovim config directory: $NVIM_CONFIG_DIR" "error"
        return 1
    }
    
    # Get current branch
    local current_branch
    current_branch=$(/usr/bin/git branch --show-current 2>/dev/null)
    
    # Check if already on correct branch
    if [[ "$current_branch" == "$target_branch" ]]; then
        notify "Already on $target_branch branch for $keyboard_type keyboard" "info"
        return 0
    fi
    
    # Stash uncommitted changes
    if ! /usr/bin/git diff --quiet || ! /usr/bin/git diff --cached --quiet; then
        notify "Stashing uncommitted changes before branch switch" "warning"
        /usr/bin/git stash push -m "Auto-stash before switching to $target_branch for $keyboard_type keyboard - $(date)"
    fi
    
    # Switch branch
    if /usr/bin/git checkout "$target_branch" 2>/dev/null; then
        notify "Switched to $target_branch branch for $keyboard_type keyboard" "success"
        reload_nvim
        echo "$(date): Switched from $current_branch to $target_branch for $keyboard_type keyboard" >> "$NVIM_CONFIG_DIR/.switch-log"
    else
        notify "Failed to switch to $target_branch branch" "error"
        return 1
    fi
}

# Handle different commands
case "$1" in
    "connect")
        switch_config "glove80"
        ;;
    "disconnect")
        switch_config "builtin"
        ;;
    "toggle")
        cd "$NVIM_CONFIG_DIR" || exit 1
        current_branch=$(/usr/bin/git branch --show-current 2>/dev/null)
        if [[ "$current_branch" == "glove80" ]]; then
            switch_config "builtin"
        else
            switch_config "glove80"
        fi
        ;;
    "auto")
        # Auto-detect by checking for Glove80 in Bluetooth
        if /usr/bin/system_profiler SPBluetoothDataType 2>/dev/null | /usr/bin/grep -q "Glove80"; then
            switch_config "glove80"
        else
            switch_config "builtin"
        fi
        ;;
    *)
        notify "Usage: $0 [connect|disconnect|toggle|auto]" "error"
        exit 1
        ;;
esac
