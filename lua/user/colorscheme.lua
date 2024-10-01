-- return {
-- 	"tomasiser/vim-code-dark",
-- 	priority = 1000,
-- 	event = "BufReadPre",
-- 	config = function()
-- 		vim.g["codedark_term256"] = 1
-- 		vim.cmd([[
-- 			colorscheme codedark
-- 			hi Comment guifg=#dbaf84
-- 			hi String guifg=#efa29b
-- 			hi Search guibg=#658da1
-- 			hi IncSearch guibg=#658da1
-- 			hi EasyMotionTarget guifg=#9cdcfe ctermfg=blue
-- 			hi NoiceCmdlinePopupBorderSearch guifg=#9cdcfe
-- 			hi NoiceCmdlineIconSearch guifg=#9cdcfe
-- 			hi EasyMotionTarget guifg=#9cdcfe ctermfg=blue
-- 			hi EasyMotionShade ctermbg=none ctermfg=none
-- 			hi EasyMotionIncSearch guifg=#9cdcfe ctermfg=blue
-- 	  	]])
-- 	end,
-- }
local c = require("vscode.colors").get_colors()
require("vscode").setup({
	transparent = false,
	-- Enable italic comment
	italic_comments = true,

	-- Underline `@markup.link.*` variants
	underline_links = true,

	-- Disable nvim-tree background color
	disable_nvimtree_bg = true,

	-- Override colors (see ./lua/vscode/colors.lua)
	color_overrides = {
		vscTabCurrent = "#1E1E1E",
		vscLineNumber = "#8c8c8c",
		vscBack = "#1E1E1E",
		vscGreen = "#d1ac88",
		vscOrange = "#ffb8b0",
	},

	-- Override highlight groups (see ./lua/vscode/theme.lua)
	group_overrides = {
		-- -- this supports the same val table as vim.api.nvim_set_hl
		-- -- use colors from this colorscheme by requiring vscode.colors!
		-- Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
		Comment = { fg = c.vscPink, bg = "NONE" },
	},
})

-- require("vscode").load()

vim.cmd.colorscheme("vscode")

vim.cmd([[
hi Comment guifg=#dbaf84
hi String guifg=#efa29b
" hi! link Sneak Search
" hi Search guibg=#658da1
hi! illuminatedWordText cterm=underline gui=underline
let g:sneak#label = 1
hi IncSearch guibg=#658da1
hi NoiceCmdlinePopupBorderSearch guifg=#9cdcfe
hi NoiceCmdlineIconSearch guifg=#9cdcfe
hi! EasyMotionTarget guifg=#9cdcfe ctermfg=blue
hi! EasyMotionShade ctermbg=none ctermfg=none
hi! EasyMotionIncSearch guifg=#9cdcfe ctermfg=blue
highlight NvimDapVirtualText guibg=#232323 guifg=#efa29b
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_verbose = 0
]])
