require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Disble mappings
local nomap = vim.keymap.del
nomap("i", "<C-h>")
nomap("i", "<C-j>")
nomap("i", "<C-k>")
nomap("i", "<C-l>")
nomap("i", "<C-b>")
