#!/bin/bash

# btt-paste.sh  
# Script content to paste directly into BetterTouchTool's Script field
# Will read the action type from BTT trigger name or use 'auto' as default

NVIM_CONFIG_DIR="$HOME/.config/nvim"

# Try to determine action from environment or default to 'auto'
ACTION="${1:-auto}"

# If no parameter passed, try to detect from BTT trigger context
if [[ "$ACTION" == "auto" ]]; then
    # Check for Glove80 in Bluetooth to determine action
    if /usr/bin/system_profiler SPBluetoothDataType 2>/dev/null | /usr/bin/grep -q "Glove80"; then
        ACTION="connect"
    else  
        ACTION="disconnect"
    fi
fi

# Function to display notifications
notify() {
    local message="$1"
    local level="$2"
    
    case "$level" in
        "error")
            echo "ERROR: $message"
            /usr/bin/osascript -e "display notification \"$message\" with title \"Neovim Config\" sound name \"Basso\"" 2>/dev/null
            ;;
        "success")
            echo "SUCCESS: $message"
            /usr/bin/osascript -e "display notification \"$message\" with title \"Neovim Config\" sound name \"Glass\"" 2>/dev/null
            ;;
        "info")
            echo "INFO: $message"
            /usr/bin/osascript -e "display notification \"$message\" with title \"Neovim Config\"" 2>/dev/null
            ;;
        "warning")
            echo "WARNING: $message"
            /usr/bin/osascript -e "display notification \"$message\" with title \"Neovim Config\" sound name \"Funk\"" 2>/dev/null
            ;;
    esac
}

# Function to check if Neovim is running
is_nvim_running() {
    /usr/bin/pgrep -f "nvim" > /dev/null 2>&1
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
    if ! /usr/bin/git diff --quiet 2>/dev/null || ! /usr/bin/git diff --cached --quiet 2>/dev/null; then
        notify "Stashing uncommitted changes before branch switch" "warning"
        /usr/bin/git stash push -m "Auto-stash before switching to $target_branch for $keyboard_type keyboard - $(date)" 2>/dev/null
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
case "$ACTION" in
    "connect")
        switch_config "glove80"
        ;;
    "disconnect")
        switch_config "builtin"
        ;;
    "toggle")
        cd "$NVIM_CONFIG_DIR" 2>/dev/null || exit 1
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
        notify "Invalid action: $ACTION. Use connect, disconnect, toggle, or auto" "error"
        exit 1
        ;;
esac