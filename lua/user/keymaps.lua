local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local function is_windows()
	---@diagnostic disable-next-line: undefined-field
	return vim.loop.os_uname().sysname == "Windows_NT"
end
-- Universal

if not is_windows() then
	vim.keymap.set("v", "y", function()
		vim.cmd('normal! "+y')
		vim.defer_fn(function()
			vim.fn.system("xclip -selection clipboard", vim.fn.getreg("+"))
		end, 50)
	end, { silent = true })
end

keymap("n", "<C-d>", "<Nop>", opts)
keymap("n", "<C-S-d>", "<Nop>", opts)
keymap("n", "H", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
-- keymap("n", "<C-r>", "<Nop>", opts)
keymap("n", "<Space>", "<Nop>", opts)
-- keymap("n", "<c-n>", "<Nop>", opts)
keymap("i", "<C-BS>", "<C-w>", opts)
keymap("i", "<C-h>", "<C-w>", opts)
keymap("n", "t", "<Plug>(easymotion-overwin-f2)", opts)
keymap("v", "t", "<Plug>(easymotion-overwin-f2)", opts)
keymap("n", "$", "%", opts)
keymap("v", "$", "%", opts)

keymap("n", ";", ":", opts)
keymap("n", ":", ";", opts)

vim.keymap.set("v", "<C-r>", '"hy:%s/\\v<C-r>h//g<left><left>', { desc = "change selection" })

keymap("n", "<Leader>k", "<Plug>(easymotion-j)", opts)
keymap("n", "<Leader>i", "<Plug>(easymotion-k)", opts)
-- keymap("n", "jk", "<Plug>(easymotion-bd-jk)", opts)
keymap("n", "<c-v>", "<Esc>p", opts)
keymap("c", "<C-v>", "<c-r>+", opts)
-- Key mapping to use the custom function
-- vim.keymap.set("n", "<A-n>", enter_insert_and_run, { noremap = true, silent = true })

keymap("n", "<C-`>", "<cmd>term<CR>", opts)
keymap("n", "<A-`>", "<cmd>term<CR>", opts)

keymap("n", "<C-S-e>", "<cmd>NvimTreeToggleNoFocus<CR>", opts)
keymap("n", "<A-S-e>", "<cmd>NvimTreeToggleNoFocus<CR>", opts)
keymap("t", "<Esc>", "<C-\\><C-n>", opts)

keymap("i", "<A-n>", "<normal><c-x><c-f><cmd><Plug>(fzf-complete-path)", opts)
keymap("v", "<A-k>", "<Cmd>m '<-2<CR>gv=gv", opts) -- move line down(v)
keymap("v", "<A-j>", "<Cmd>m '>+1<CR>gv=gv", opts) -- move line up(v)
-- keymap("n", "<A-k>", ":m .-2<CR>==", opts) -- move line down(n)
-- keymap("n", "<A-j>", ":m .+1<CR>==", opts) -- move line up(n)
vim.cmd([[
nnoremap <silent> <c-d> <Cmd>let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> <c-d> "sy<Cmd>let @/=@s<CR>cgn
nnoremap <leader>q :bp<cr>:bd #<cr>
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
]])

-- Custom command to edit a new file with pre-filled path
-- Custom command to edit a new file with pre-filled path
-- vim.api.nvim_create_user_command("E", function(opts)
-- 	local current_dir = vim.fn.expand("%:h")
-- 	local new_file = current_dir .. "/" .. opts.args
-- 	vim.cmd("edit " .. new_file)
-- end, { nargs = 1, complete = "file" })
--
-- -- Remap :e to the new command
-- vim.cmd([[cnoreabbrev <expr> e getcmdtype() == ":" && getcmdline() == 'e' ? 'E' : 'e']])
-- Basic Navigation File
-- keymap("n", "j", "h", opts)
-- keymap("n", "k", "j", opts)
keymap("n", "i", "k", opts)
-- keymap("v", "j", "h", opts)
-- keymap("v", "k", "j", opts)
-- keymap("x", "j", "h", opts)
-- keymap("x", "k", "j", opts)

-- keymap("x", "i", "k", opts)
-- keymap("n", "h", "a", opts)
keymap("n", "y", '"+y', opts)
keymap("n", "p", '"+p', opts)
keymap("n", "a", "<Nop>", opts)
keymap("n", "<C-Z>", "<Esc>u", opts)
keymap("n", "a", "i", opts)
-- keymap("n", "gi", "<Nop>", opts)

keymap("n", "0", "^", opts)
keymap("n", "ge", "g_", opts)

keymap("v", "ge", "g_", opts)
keymap("v", "0", "^", opts)

-- Next/Previous cursor position
keymap("n", "<M-U>", "<C-O>", opts)
keymap("n", "<M-O>", "<C-I>", opts)
keymap("n", "<C-U>", "<C-O>", opts)
keymap("n", "<C-O>", "<C-I>", opts)
keymap("o", "a", "i", opts)

-- Ctrl+Backspace to delete word
keymap("i", "<C-BS>", "<C-W>", opts)
keymap("n", "@", "*", opts)

if not vim.g.vscode then
	-- jump between buffers
	keymap("n", "<A-l>", "<Esc><C-W>l", opts)
	keymap("n", "<A-h>", "<Esc><C-W>h", opts)
	keymap("n", "<A-k>", "<Esc><C-W>k", opts)
	keymap("n", "<A-j>", "<Esc><C-W>j", opts)
	keymap("n", "<C-l>", "<Esc><C-W>l", opts)
	keymap("n", "<C-h>", "<Esc><C-W>h", opts)
	keymap("n", "<C-k>", "<Esc><C-W>k", opts)
	keymap("n", "<C-j>", "<Esc><C-W>j", opts)

	keymap("v", "<C-c>", "y", opts)
	-- keymap("n", "<C-v>", "<Esc>p", opts)
	keymap("n", "<C-z>", "<cmd>red<CR>", opts)

	keymap("x", "<C-c>", "y", opts)
	keymap("n", "q", "<cmd>w | bd<CR>", opts)
	keymap("n", "Q", "<cmd>quitall<CR>", opts)
	keymap("n", "<C-A>", "ggVG", opts)

	-- keymap("n", "<M-i>", ":resize -2<CR>", opts)
	-- keymap("n", "<M-k>", ":resize +2<CR>", opts)
	-- keymap("n", "<M-j>", ":vertical resize -2<CR>", opts)
	-- keymap("n", "<M-l>", ":vertical resize +2<CR>", opts)

	-- Visual --
	-- Stay in indent mode
	keymap("v", "<", "<gv", opts)
	keymap("v", ">", ">gv", opts)

	-- Treesitter
	-- keymap("n", "<leader>r", "<Cmd>Telescope live_grep<CR>", opts)
	-- keymap("n", "<M-r>", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts)
	keymap("n", "<A-r>", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts)

	vim.keymap.set("n", "<C-S-b>", function()
		require("telescope.builtin").buffers({
			preview = false,
		})
	end, opts)

	keymap("n", "<A-S-p>", "<Cmd>Telescope buffers<CR>", opts)

	-- Visual Block --
	-- Move text up and down
	-- keymap("x", "<A-k>", ":move '>+1<CR>gv-gv", opts)
	-- keymap("x", "<A-i>", ":move '<-2<CR>gv-gv", opts)

	-- keymap("x", "<C-k>", ":move '>+1<CR>gv-gv", opts)
	-- keymap("x", "<C-i>", ":move '<-2<CR>gv-gv", opts)

	-- keymap("i", "<C-v>", "<C-r>+", opts)

	-- keymap("n", "<C-B>", ":NvimTreeToggleNoFocus<CR>", opts)
	-- keymap("n", "<C-B>", ":Telescope finder<CR>", opts)

	-- keymap("n", "<A-n>", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", opts)
	keymap(
		"n",
		"<A-n>",
		"<cmd>lua require('telescope').extensions.file_browser.file_browser(require('telescope.themes').get_dropdown())<CR>",
		opts
	)

	-- Comment Toggle
	keymap("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)", opts)
	keymap("v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)", opts)
	keymap("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)", opts)
	keymap("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", opts)

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

	-- cmp completion

	-- Select items in dropdown list from suggestions/cmp
	-- vim.keymap.set("c", "<M-k>", "<cmd>lua require('cmp').mapping.select_next_item()<cr>", opts)
	-- vim.keymap.set("o", "<M-k>", "<cmd>lua require('cmp').mapping.select_next_item()<cr>", opts)
	--
	-- vim.keymap.set("c", "<C-k>", "<cmd>lua require('cmp').mapping.select_next_item()<cr>", { silent = true })
	-- vim.keymap.set("o", "<C-k>", "<cmd>lua require('cmp').mapping.select_next_item()<cr>", { silent = true })
	--
	-- vim.keymap.set("c", "<C-i>", "<cmd>lua require('cmp').mapping.select_prev_item()<cr>", { silent = true })
	-- vim.keymap.set("o", "<C-i>", "<cmd>lua require('cmp').mapping.select_prev_item()<cr>", { silent = true })
	--
	-- navigate up and down in dropdown list.
	-- keymap("c", "<M-i>", "<C-p>", opts)
	-- keymap("o", "<M-i>", "<C-p>", opts)
	-- keymap("c", "<M-k>", "<C-n>", opts)
	-- keymap("o", "<M-k>", "<C-n>", opts)

	-- Next and previous problems.
	-- keymap("n", "n", "<Cmd>lua require('illuminate').goto_next_reference()<cr>", opts)
	-- keymap("n", "N", "<Cmd>lua require('illuminate').goto_prev_reference()<cr>", opts)
	keymap("n", "<C-n>", "<Cmd>lua require('illuminate').goto_next_reference()<cr>", opts)
	keymap("n", "<C-p>", "<Cmd>lua require('illuminate').goto_prev_reference()<cr>", opts)
	keymap("n", "<Bslash>", "<Cmd>lua vim.diagnostic.goto_next()<cr>", opts)
	keymap("n", "<|>", "<Cmd>lua vim.diagnostic.goto_prev()<cr>", opts)

	-- save current file.
	keymap("n", "<C-s>", "<cmd>w<CR>", opts)

	-- Telescope
	keymap(
		"i",
		"<A-p>",
		'<cmd>lua require("telescope.builtin").find_files(require"telescope.themes".get_dropdown({previewer=false}))<CR>',
		opts
	)
	keymap(
		"n",
		"<A-p>",
		'<cmd>lua require("telescope.builtin").find_files(require"telescope.themes".get_dropdown({previewer=false}))<CR>',
		opts
	)

	-- Lazy
	keymap("n", "<C-x>", "<cmd>Lazy<cr>", opts)

	-- Debugger
	keymap("n", "dp", "<cmd>GoBreakToggle<CR>", opts)

	keymap("i", "<F2>", '<cmd>lua require("renamer").rename()<cr>', opts)

	-- Renamer
	keymap("n", "rn", '<cmd>lua require("renamer").rename()<cr>', opts)

	keymap("n", "`", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	keymap("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

	keymap("n", "<leader>s", "<cmd>w<CR> <cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	-- keymap("n", "<Bslash>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

	keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)

	keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

	keymap("n", "H", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

	keymap("n", "gi", "<cmd>lua vim.lsp.bui.implementation()<CR>", opts)

	keymap("n", "ri'", "ci'<Esc>p", opts)

	keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
else
	keymap("n", "<C-i>", "<cmd>lua require('vscode-neovim').action('workbench.action.focusUpGroup')<CR>", opts)
	keymap("n", "<C-k>", "<cmd>lua require('vscode-neovim').action('workbench.action.focusDownGroup')<CR>", opts)

	keymap("n", "<c-l>", "<cmd>lua require('vscode-neovim').action('workbench.action.focusRightGroup')<CR>", opts)
	keymap("n", "<A-i>", "<cmd>lua require('vscode-neovim').action('workbench.action.focusUpGroup')<CR>", opts)
	keymap("n", "<A-k>", "<cmd>lua require('vscode-neovim').action('workbench.action.focusDownGroup')<CR>", opts)
	keymap("n", "<A-l>", "<cmd>lua require('vscode-neovim').action('workbench.action.focusRightGroup')<CR>", opts)
	keymap("n", "<c-j>", "<cmd>lua require('vscode-neovim').action('workbench.action.focusLeftGroup')<CR>", opts)
	keymap("n", "<A-j>", "<cmd>lua require('vscode-neovim').action('workbench.action.focusLeftGroup')<CR>", opts)
	keymap("n", "<leader>d", "<cmd>lua require('vscode-neovim').action('workbench.action.debug.start')<CR>", opts)
	keymap("n", "<leader>s", "<cmd>lua require('vscode-neovim').action('workbench.action.debug.stop')<CR>", opts)
	keymap("n", "dp", "<cmd>lua require('vscode-neovim').action('editor.debug.action.toggleBreakpoint')<CR>", opts)
	keymap("n", "gd", "<cmd>lua require('vscode-neovim').action('editor.action.revealDefinition')<CR>", opts)
	keymap("n", "gD", "<cmd>lua require('vscode-neovim').action('editor.action.revealDeclaration')<CR>", opts)
	keymap("n", "gi", "<cmd>lua require('vscode-neovim').action('editor.action.goToImplementation')<CR>", opts)
	keymap("n", "gr", "<cmd>lua require('vscode-neovim').action('references-view.findReferences')<CR>", opts)
	keymap("n", "rn", "<cmd>lua require('vscode-neovim').action('editor.action.rename')<CR>", opts)

	keymap("n", "H", "<cmd>lua require('vscode-neovim').action('editor.action.showHover')<CR>", opts)
end

keymap("c", "<C-i>", "", opts)
-- keymap("c", "gi", "", opts)

vim.keymap.set("o", "<tab>", "<C-z>", { silent = false })

keymap("n", "L", "g_", opts)

local function ChangeWorkingDir()
	vim.cmd([[cd %:h]])
	vim.notify(vim.fn.getcwd(), vim.log.levels.INFO, {
		title = "Buffer Locate",
	})
end

vim.keymap.set("n", "cd", ChangeWorkingDir, { silent = true })
vim.keymap.set("n", "<leader>cd", ChangeWorkingDir, { silent = true })

-- Lua
if not vim.g.vscode then
	vim.keymap.set("n", "<leader>xx", function()
		require("trouble").toggle()
	end)
	vim.keymap.set("n", "<leader>xw", function()
		require("trouble").toggle("workspace_diagnostics")
	end)
	vim.keymap.set("n", "<leader>xd", function()
		require("trouble").toggle("document_diagnostics")
	end)
	vim.keymap.set("n", "<leader>qf", function()
		require("trouble").toggle("quickfix")
	end)
	vim.keymap.set("n", "<leader>xl", function()
		require("trouble").toggle("loclist")
	end)
	vim.keymap.set("n", "gR", function()
		require("trouble").toggle("lsp_references")
	end)
end

vim.cmd([[
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_verbose = 0
]])
