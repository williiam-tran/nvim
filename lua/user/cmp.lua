local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

-- local snip_status_ok, luasnip = pcall(require, "luasnip")
-- if not snip_status_ok then
-- 	return
-- end
--
-- require("luasnip/loaders/from_vscode").lazy_load()
--
local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup({
	mapping = {
		-- ["<C-p>"] = cmp.mapping.select_prev_item(),

		-- ["<C-n>"] = cmp.mapping.select_next_item(),

		["<Up>"] = cmp.mapping.select_prev_item(),
		["<Down>"] = cmp.mapping.select_next_item(),

		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),

		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),

		-- ["<CR>"] = cmp.mapping.confirm({
		-- 	behavior = cmp.ConfirmBehavior.Insert,
		-- 	select = true,
		-- }),

		["<Tab>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		-- ["<M-l>"] = cmp.mapping.confirm({ select = true }),

		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.mapping.confirm({
		-- 			behavior = cmp.ConfirmBehavior.Insert,
		-- 			select = true,
		-- 		})
		-- 	elseif check_backspace() then
		-- 		fallback()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, {
		-- 	"i",
		-- 	"s",
		-- }),

		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_prev_item()
		-- 	elseif luasnip.jumpable(-1) then
		-- 		luasnip.jump(-1)
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, {
		-- 	"i",
		-- 	"s",
		-- }),
	},

	sources = {
		{ name = "copilot" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},

	--
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = true,
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
})

-- cmp.setup.cmdline({
-- 	window = {
-- 		documentation = {
-- 			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
-- 		},
-- 	},
--
-- 	formatting = {
-- 		fields = { "kind", "abbr", "menu" },
-- 		format = function(entry, vim_item)
-- 			-- Kind icons
-- 			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
-- 			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
-- 			vim_item.menu = ({
-- 				nvim_lsp = "[LSP]",
-- 				luasnip = "[Snippet]",
-- 				buffer = "[Buffer]",
-- 				path = "[Path]",
-- 			})[entry.source.name]
-- 			return vim_item
-- 		end,
-- 	},
-- 	sources = {
-- 		{ name = "nvim_lsp" },
-- 		{ name = "luasnip" },
-- 		{ name = "buffer" },
-- 		{ name = "path" },
-- 	},
--
-- 	confirm_opts = {
-- 		behavior = cmp.ConfirmBehavior.Replace,
-- 		select = true,
-- 	},
--
-- 	experimental = {
-- 		ghost_text = false,
-- 		native_menu = false,
-- 	},
-- })

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	matching = { disallow_symbol_nonprefix_matching = false },
})

-- local has_words_before = function()
-- 	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
-- 		return false
-- 	end
-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
-- end
-- cmp.setup({
-- 	mapping = {
-- 		["<Tab>"] = vim.schedule_wrap(function(fallback)
-- 			if cmp.visible() and has_words_before() then
-- 				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
-- 			else
-- 				fallback()
-- 			end
-- 		end),
-- 	},
-- })
