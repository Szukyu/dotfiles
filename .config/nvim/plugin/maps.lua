local map = vim.keymap.set

-- Better Up & Down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

map("n", "<leader>e", function() MiniFiles.open() end, { desc = "Find Files" })
map("n", "<leader><space>", function() require('fzf-lua').files() end, { desc = "Fzf Files" })
map("n", "<leader>/", function() require('fzf-lua').live_grep() end, { desc = "Fzf Files" })

-- Windows
map("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- Move Windows
map("n", "<leader>h", "<C-W>h", { desc = "Move to Right Window", remap = true })
map("n", "<leader>l", "<C-W>l", { desc = "Move to Left Window", remap = true })
map("n", "<leader>j", "<C-W>j", { desc = "Move to Down Window", remap = true })
map("n", "<leader>k", "<C-W>k", { desc = "Move to Up Window", remap = true })

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
