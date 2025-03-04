local options = {
	cmdheight = 4, -- more space in the neovim command line for displaying messages
}


for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[
set iskeyword-=-
set iskeyword-=_
set encoding=utf-8
set modifiable
set winblend=10
highlight Comment guifg=#dbaf84
highlight String guifg=#ec8076
highlight Number guifg=#c0b6a9
set formatoptions-=cro
autocmd User TelescopePreviewerLoaded setlocal wrap
set formatoptions-=c formatoptions-=r formatoptions-=o
set nopaste
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" set guicursor=n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20
" ignore case for sneak.nvim
let g:sneak#use_ic_scs = 1

" Exit if there is only nerdtree left
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])

vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])

vim.cmd([[
	let g:EasyMotion_smartcase = 1
	let g:EasyMotion_prompt = ""
	hi! EasyMotionTarget guifg=#9cdcfe ctermfg=blue
    hi! EasyMotionShade ctermbg=none ctermfg=none
    hi! EasyMotionIncSearch guifg=#9cdcfe ctermfg=blue
	silent! w
]])

-- Set EasyMotion highlights on ColorScheme
-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.api.nvim_set_hl(0, "EasyMotionTarget", { guifg = "#9cdcfe", ctermfg = "blue" })
-- 		vim.api.nvim_set_hl(0, "EasyMotionShade", { ctermbg = "none", ctermfg = "none" })
-- 		vim.api.nvim_set_hl(0, "EasyMotionIncSearch", { guifg = "#9cdcfe", ctermfg = "blue" })
-- 	end,
-- })
