local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<C-r>", "<Nop>", opts)
keymap("n", "<Space>", "<Nop>", opts)
keymap("n", "<c-n>", "<Nop>", opts)
keymap("i", "<C-BS>", "<C-w>", opts)
keymap("i", "<C-h>", "<C-w>", opts)

keymap("n", "t", "<Plug>Sneak_s", opts)
keymap("n", "T", "<Plug>Sneak_S", opts)
keymap("v", "t", "<Plug>Sneak_s", opts)
keymap("v", "T", "<Plug>Sneak_S", opts)

keymap("n", "<Leader>k", "<Plug>(easymotion-k)", opts)
keymap("n", "<Leader>i", "<Plug>(easymotion-j)", opts)

keymap("i", "<C-k>", "<cmd>lua require'luasnip'.jump(-1)<cr>", opts)
keymap("i", "<C-i>", "<cmd>lua require'luasnip'.jump(1)<cr>", opts)
keymap("s", "<C-i>", "<cmd>lua require'luasnip'.jump(1)<cr>", opts)
keymap("s", "<C-i>", "<cmd>lua require'luasnip'.jump(-1)<cr>", opts)
-- keymap("s", "<Tab>", "<Plug>luasnip-expand-or-jump<cr>", opts)
-- keymap("i", "<Tab>", "<Plug>luasnip-expand-or-jump<cr>", opts)

-- vim.cmd([[
-- imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
-- ]])

keymap("n", "j", "h", opts)
keymap("n", "k", "j", opts)
keymap("n", "i", "k", opts)
keymap("v", "j", "h", opts)
keymap("v", "k", "j", opts)
keymap("v", "i", "k", opts)
keymap("x", "j", "h", opts)
keymap("x", "k", "j", opts)
keymap("x", "i", "k", opts)
keymap("n", "h", "a", opts)
keymap("n", "y", '"+y', opts)
keymap("n", "p", '"+p', opts)

keymap("n", "a", "<Nop>", opts)
keymap("n", "<C-Z>", "<Esc>u", opts)
keymap("n", "a", "i", opts)

keymap("n", "dk", "da", opts)
keymap("n", "ck", "ca", opts)
keymap("n", "0", "^", opts)
keymap("n", "ge", "g_", opts)
keymap("v", "ge", "g_", opts)
keymap("n", "<C-U>", "<C-O>", opts)
keymap("n", "<C-O>", "<C-I>", opts)
keymap("n", "<A-O>", "<C-O>", opts)

keymap("n", "m", "5<C-E>", opts)
keymap("n", ",", "5<C-Y>", opts)

keymap("n", "<C-L>", "<Esc><C-W>l", opts)
keymap("n", "<C-J>", "<Esc><C-W>h", opts)
keymap("n", "<C-K>", "<Esc><C-W>j", opts)
keymap("n", "<C-I>", "<Esc><C-W>k", opts)
keymap("n", "q", ":q!<CR>", opts)
keymap("n", "Q", ":wq!<CR>", opts)

keymap("v", "<C-c>", "y", opts)
keymap("n", "<C-v>", "<Esc>p", opts)
keymap("x", "<C-c>", "y", opts)

keymap("n", "<C-A>", "ggVG", opts)
keymap("n", "<M-i>", ":resize -2<CR>", opts)
keymap("n", "<M-k>", ":resize +2<CR>", opts)
keymap("n", "<M-j>", ":vertical resize -2<CR>", opts)
keymap("n", "<M-l>", ":vertical resize +2<CR>", opts)

keymap("n", "<C-B>", ":NvimTreeToggleNoFocus<CR>", opts)
keymap("c", "<C-v>", '<c-r>"', opts)
keymap("i", "<C-BS>", "<C-W>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-k>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-i>", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<C-k>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<C-i>", ":move '<-2<CR>gv-gv", opts)
keymap("i", "<C-v>", "<C-r>+", opts)

-- Treesitter
keymap("n", "<leader>r", "<Cmd>Telescope live_grep<CR>", opts)
keymap("n", "<M-r>", "<Cmd>Telescope live_grep<CR>", opts)
keymap("n", "<A-r>", "<Cmd>Telescope live_grep<CR>", opts)

-- Comment Toggle
keymap("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)", opts)
keymap("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", opts)

-- keymap("n", "cm", "<Cmd>CommentToggle<CR>", opts)
-- keymap("v", "cm", "<Cmd>CommentToggle<CR>", opts)
-- keymap("x", "cm", "<Cmd>CommentToggle<CR>", opts)
-- keymap("o", "cm", "<Cmd>CommentToggle<CR>", opts)

-- navigate between occurences of selected variable.
-- keymap('n', '<a-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', opts)
-- keymap('n', '<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', opts)

-- navigate between tabs of current buffer.
keymap("n", "<leader>1", "1gt", opts)
keymap("n", "<leader>2", "2gt", opts)
keymap("n", "<leader>3", "3gt", opts)
keymap("n", "<leader>4", "4gt", opts)
keymap("n", "<leader>5", "5gt", opts)
keymap("n", "<leader>6", "6gt", opts)
keymap("n", "<leader>7", "7gt", opts)
keymap("n", "<leader>8", "8gt", opts)
keymap("n", "<leader>9", "9gt", opts)

-- Next and previous problems.
keymap("n", "<Bslash>", "<Cmd>lua vim.diagnostic.goto_next()<cr>", opts)

-- save current file.
keymap("n", "<C-s>", ":w<CR>", opts)

-- Renamer
keymap("i", "<F2>", '<cmd>lua require("renamer").rename()<cr>', opts)
keymap("n", "rn", '<cmd>lua require("renamer").rename()<cr>', opts)
keymap("v", "rn", '<cmd>lua require("renamer").rename()<cr>', opts)

-- Telescope
keymap(
	"n",
	"<A-p>",
	'<cmd>lua require("telescope.builtin").find_files(require"telescope.themes".get_dropdown({previewer=false}))<CR>',
	opts
)

-- Lazy
keymap("n", "<C-S-x>", "<cmd>Lazy<cr>", opts)

keymap("n", "<Leader>p", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
keymap("n", "rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "<leader>s", "<cmd>w<CR> <cmd>lua vim.lsp.buf.formatting()<CR>", opts)

keymap("n", "<Bslash>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "H", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

keymap("c", "<C-i>", "", opts)
keymap("c", "gi", "", opts)

-- Lua
vim.keymap.set("n", "<leader>xx", function()
	require("trouble").toggle()
end)
vim.keymap.set("n", "<leader>xw", function()
	require("trouble").toggle("workspace_diagnostics")
end)
vim.keymap.set("n", "<leader>xd", function()
	require("trouble").toggle("document_diagnostics")
end)
vim.keymap.set("n", "<leader>xq", function()
	require("trouble").toggle("quickfix")
end)
vim.keymap.set("n", "<leader>xl", function()
	require("trouble").toggle("loclist")
end)
vim.keymap.set("n", "gR", function()
	require("trouble").toggle("lsp_references")
end)
