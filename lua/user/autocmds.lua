local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- vim.cmd([[
-- au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
-- ]])

-- Check if we need to reload the file when it changed
-- vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
-- 	group = augroup("checktime"),
-- 	callback = function()
-- 		if vim.o.buftype ~= "nofile" then
-- 			vim.cmd("checktime")
-- 		end
-- 	end,
-- })

vim.api.nvim_set_hl(0, "Statusline", { link = "Normal" })
vim.api.nvim_set_hl(0, "StatuslineNC", { link = "Normal" })
-- local str = string.repeat('-', vim.api.nvim_win_get_width(0))
-- vim.opt.statusline = str

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- vim.api.nvim_create_autocmd("BufReadPost", {
-- 	group = augroup("last_loc"),
-- 	callback = function(event)
-- 		local exclude = { "gitcommit" }
-- 		local buf = event.buf
-- 		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
-- 			return
-- 		end
-- 		vim.b[buf].lazyvim_last_loc = true
-- 		local mark = vim.api.nvim_buf_get_mark(buf, '"')
-- 		local lcount = vim.api.nvim_buf_line_count(buf)
-- 		if mark[1] > 0 and mark[1] <= lcount then
-- 			pcall(vim.api.nvim_win_set_cursor, 0, mark)
-- 		end
-- 	end,
-- })

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

vim.cmd([[
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

" augroup illuminate_augroup
"     autocmd!
"     autocmd VimEnter * hi link illuminatedWord CursorLine
" augroup END
"
" augroup illuminate_augroup
"     autocmd!
"     autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
" augroup END
" augroup EasyMotionHighlights
" 	autocmd!
" 	autocmd ColorScheme * hi EasyMotionTarget guifg=#9cdcfe ctermfg=blue
" 	autocmd ColorScheme * hi EasyMotionShade ctermbg=none ctermfg=none
" 	autocmd ColorScheme * hi EasyMotionIncSearch guifg=#9cdcfe ctermfg=blue
" augroup END

" augroup illuminate_augroup
"     autocmd!
"     autocmd VimEnter * hi link illuminatedWord CursorLine
" augroup END

" augroup illuminate_augroup
"     autocmd!
"     autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
" augroup END
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
aug END

]])

vim.api.nvim_create_autocmd("BufEnter", {
	command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
	nested = true,
})

vim.cmd([[
augroup custom_highlight
	au!
	au VimEnter * highlight PounceGap cterm=none ctermfg=none ctermbg=none guifg=none guibg=none
	au VimEnter * highlight PounceUnmatched guifg=#919191 guibg=none
	au VimEnter * highlight PounceAccept ctermfg=none ctermbg=none guifg=#9cdcfe guibg=none
	au VimEnter * highlight PounceAcceptBest ctermfg=none ctermbg=none guifg=#9cdcfe guibg=none
augroup END
]])
