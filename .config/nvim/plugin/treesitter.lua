local languages = {
	"bash",
	"c",
	"cpp",
	"css",
	"csv",
	"diff",
	"dockerfile",
	"git_config",
	"gitcommit",
	"gitignore",
	"html",
	"java",
	"javascript",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"python",
	"regex",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"yaml",
}

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local filetype = args.match
		local lang = vim.treesitter.language.get_lang(filetype)
		if vim.treesitter.language.add(lang) then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			vim.treesitter.start()
		end
	end,
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
	},
})

local ts = require("nvim-treesitter")

ts.install(languages)
ts.update("all")

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function()
		ts.update()
	end,
})
