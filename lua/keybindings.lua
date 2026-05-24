vim.keymap.set({ "x", "o" }, "am", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "im", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm`
vim.keymap.set({ "x", "o" }, "as", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
end)

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
vim.keymap.set("n", "gt", function() vim.lsp.buf.type_definition() end, opts)

vim.keymap.set("n", "<leader>gl", ":GitHubPermalinkBelow<CR>", {
  desc = "GitHub permalink to line below cursor"
})
vim.keymap.set('n', '<leader>dfmt', "FormatDisable", { desc = 'Disable formatting' })
vim.keymap.set('n', '<leader>xf', function()
  if vim.g.disable_autoformat or vim.b.disable_autoformat then
    vim.cmd("FormatEnable")
  else
    vim.cmd("FormatDisable")
  end
end, { desc = "Toggle formatting" })
vim.keymap.set('n', "<leader>nn", "SymbolsOutline<CR>", { desc = "Toggle symbols outline" })
vim.keymap.set('n', "<PageUp>", ":GitGutterPrevHunk<CR>", { desc = 'Go to next git hunk' })
vim.keymap.set('n', "<PageDown>", ":GitGutterNextHunk<CR>", { desc = 'Go to prev git hunk' })
-- vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

-- copy and paste from clipboard
-- Yank to system clipboard in normal and visual modes
vim.keymap.set({"n", "v"}, "<leader>y", '"+y', { noremap = true, silent = true })

-- Paste from system clipboard in normal and visual modes
vim.keymap.set({"n", "v"}, "<leader>p", '"+p', { noremap = true, silent = true })
