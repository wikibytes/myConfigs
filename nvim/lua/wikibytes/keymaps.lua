vim.g.mapleader = " "
vim.keymap.set("i", "jk" , "<ESC>")
vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>c", vim.cmd.nohlsearch)
vim.api.nvim_set_keymap('n', '<leader>hs', ':split<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>vs', ':vsplit<CR>', { noremap = true, silent = true })

-- for Obsidian 
vim.cmd('command! YesterdayNote ObsidianToday -1')
vim.cmd('command! TomorrowNote ObsidianToday +1')
vim.keymap.set('n', '<leader>fl', vim.cmd.ObsidianFollowLink )
vim.keymap.set('n', '<leader>ot', vim.cmd.ObsidianToday )
vim.api.nvim_set_keymap('n', '<leader>oy', ':YesterdayNote<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>of', ':TomorrowNote<CR>', {noremap = true, silent = true})
