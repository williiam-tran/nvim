require("user.lazy")
require("user.options")
require("user.keymaps")

if vim.g.vscode then
    require("user.vscode.options")
    require("user.vscode.smoothscrolling")
    require("user.vscode.treesitter")
else
    require("user.autopairs")
    require("user.comments")
    require("user.pounce")
    require("user.colorscheme")
    -- require("user.scrollback")
    require("user.smoothscrolling")
    require("user.tabout")
end
