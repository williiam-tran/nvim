#!/bin/bash

# switch-nvim-config.sh
# Switches between Neovim configurations for different keyboards
# Usage: ./switch-nvim-config.sh [glove80|builtin]

NVIM_CONFIG_DIR="$HOME/.config/nvim"
KEYBOARD_TYPE="$1"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display notifications
notify() {
    local message="$1"
    local level="$2"
    
    case "$level" in
        "error")
            echo -e "${RED}ERROR: $message${NC}"
            osascript -e "display notification \"$message\" with title \"Neovim Config\" sound name \"Basso\""
            ;;
        "success")
            echo -e "${GREEN}SUCCESS: $message${NC}"
            osascript -e "display notification \"$message\" with title \"Neovim Config\" sound name \"Glass\""
            ;;
        "info")
            echo -e "${BLUE}INFO: $message${NC}"
            osascript -e "display notification \"$message\" with title \"Neovim Config\""
            ;;
        "warning")
            echo -e "${YELLOW}WARNING: $message${NC}"
            osascript -e "display notification \"$message\" with title \"Neovim Config\" sound name \"Funk\""
            ;;
    esac
}

# Function to check if Neovim is running
is_nvim_running() {
    pgrep -f "nvim" > /dev/null
}

# Function to send command to running Neovim instances
reload_nvim() {
    # Try to reload using nvim remote if available
    if command -v nvr &> /dev/null; then
        nvr --remote-send ':source ~/.config/nvim/init.lua<CR>' 2>/dev/null || true
    fi
    
    # Alternative: use osascript to send keys to Terminal/iTerm if Neovim is running there
    if is_nvim_running; then
        notify "Neovim is running. Please restart or run :source ~/.config/nvim/init.lua to apply changes" "info"
    fi
}

# Validate input
if [[ -z "$KEYBOARD_TYPE" ]]; then
    echo "Usage: $0 [glove80|builtin]"
    echo ""
    echo "  glove80 - Switch to Glove80 keyboard configuration"
    echo "  builtin - Switch to built-in/standard keyboard configuration"
    exit 1
fi

if [[ "$KEYBOARD_TYPE" != "glove80" && "$KEYBOARD_TYPE" != "builtin" ]]; then
    notify "Invalid keyboard type: $KEYBOARD_TYPE. Use 'glove80' or 'builtin'" "error"
    exit 1
fi

# Change to nvim config directory
cd "$NVIM_CONFIG_DIR" || {
    notify "Failed to change to Neovim config directory: $NVIM_CONFIG_DIR" "error"
    exit 1
}

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)

# Determine target branch
if [[ "$KEYBOARD_TYPE" == "glove80" ]]; then
    TARGET_BRANCH="glove80"
else
    TARGET_BRANCH="main"
fi

# Check if we're already on the correct branch
if [[ "$CURRENT_BRANCH" == "$TARGET_BRANCH" ]]; then
    notify "Already on $TARGET_BRANCH branch for $KEYBOARD_TYPE keyboard" "info"
    exit 0
fi

# Check if we have uncommitted changes
if ! git diff --quiet || ! git diff --cached --quiet; then
    notify "Stashing uncommitted changes before branch switch" "warning"
    git stash push -m "Auto-stash before switching to $TARGET_BRANCH for $KEYBOARD_TYPE keyboard - $(date)"
fi

# Switch to target branch
if git checkout "$TARGET_BRANCH" 2>/dev/null; then
    notify "Switched to $TARGET_BRANCH branch for $KEYBOARD_TYPE keyboard" "success"
    
    # Reload Neovim if it's running
    reload_nvim
    
    # Log the switch
    echo "$(date): Switched from $CURRENT_BRANCH to $TARGET_BRANCH for $KEYBOARD_TYPE keyboard" >> "$NVIM_CONFIG_DIR/.switch-log"
    
else
    notify "Failed to switch to $TARGET_BRANCH branch" "error"
    exit 1
fi