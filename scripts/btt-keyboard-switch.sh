#!/bin/bash

# btt-keyboard-switch.sh  
# BetterTouchTool integration script for automatic keyboard switching
# This script can be called by BetterTouchTool triggers

SWITCH_SCRIPT="/Users/william/.config/nvim/scripts/switch-nvim-config.sh"

# Function to determine keyboard type based on trigger
get_keyboard_type() {
    local trigger_info="$1"
    
    # Check if Glove80 is mentioned in the trigger or if we can detect it
    if [[ "$trigger_info" == *"glove80"* ]] || [[ "$trigger_info" == *"connect"* ]]; then
        echo "glove80"
    elif [[ "$trigger_info" == *"disconnect"* ]] || [[ "$trigger_info" == *"builtin"* ]]; then
        echo "builtin" 
    else
        # Default detection method - check for Glove80 in Bluetooth
        if system_profiler SPBluetoothDataType 2>/dev/null | grep -q "Glove80"; then
            echo "glove80"
        else
            echo "builtin"
        fi
    fi
}

# Function to handle keyboard connect event
handle_keyboard_connect() {
    "$SWITCH_SCRIPT" "glove80"
}

# Function to handle keyboard disconnect event
handle_keyboard_disconnect() {
    "$SWITCH_SCRIPT" "builtin"
}

# Function to handle manual toggle
handle_toggle() {
    # Check current branch and switch to the other
    cd "$HOME/.config/nvim" || exit 1
    CURRENT_BRANCH=$(git branch --show-current)
    
    if [[ "$CURRENT_BRANCH" == "glove80" ]]; then
        "$SWITCH_SCRIPT" "builtin"
    else
        "$SWITCH_SCRIPT" "glove80"
    fi
}

# Main logic based on arguments
case "$1" in
    "connect")
        handle_keyboard_connect
        ;;
    "disconnect") 
        handle_keyboard_disconnect
        ;;
    "toggle")
        handle_toggle
        ;;
    "auto")
        # Auto-detect and switch
        KEYBOARD_TYPE=$(get_keyboard_type "$2")
        "$SWITCH_SCRIPT" "$KEYBOARD_TYPE"
        ;;
    *)
        echo "Usage: $0 [connect|disconnect|toggle|auto]"
        echo ""
        echo "Commands:"
        echo "  connect     - Switch to Glove80 configuration"
        echo "  disconnect  - Switch to built-in keyboard configuration" 
        echo "  toggle      - Toggle between configurations"
        echo "  auto        - Auto-detect current keyboard and switch"
        echo ""
        echo "BetterTouchTool Integration:"
        echo "  Set up triggers to call this script with appropriate commands"
        echo "  Example: $0 connect (when Glove80 connects)"
        echo "  Example: $0 disconnect (when Glove80 disconnects)"
        echo "  Example: $0 toggle (for manual hotkey trigger)"
        exit 1
        ;;
esac
