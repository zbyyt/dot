local opt           = vim.opt
vim.env.MYVIMRC     = vim.fn.stdpath('config') .. '/init.lua'
opt.compatible      = false -- required to redefine viminfo file
opt.colorcolumn     = ""
opt.termguicolors   = true
opt.autoindent      = true
opt.breakindent     = true
opt.breakindentopt  = "shift:3"
opt.tabstop         = 5
opt.softtabstop     = 0
opt.shiftwidth      = 0
opt.expandtab       = true
opt.modelines       = 5
opt.modeline        = true
opt.ignorecase      = true
opt.tabline         = ' '
opt.statusline      = '%!uix#MyTabLine()'
opt.laststatus      = 3
vim.cmd.syntax('on')
vim.cmd.filetype('plugin on')
opt.tags:append({ "./.tags;", ".tags" })
--require("init") -- how to load everythin in 'init/' by one command?
--require("auto")
require("init.map")
require("init.laz")
require("init.lsp")
require("init.col")
require("init.zlt")
require("auto.odo")
-- TODO: load all the 'requires' via plugins??

-- TODO: INTEGRATE VIA OTHER LOADING MECHANISMS...::
-- vim.cmd [[ source $HOME/.config/nvim/init.vim ]]

-- TODO: modularise my configs further by setting rtp to a plugin like configuration dir

-- opt.relativenumber = true
-- vim.loader.enable()
-- opt.formatlistpat = '^>\\s*\\[({]?[0-9]+\\|[a-zA-Z]+\\)[\\]:.)}]\\s\\+\\|\\^>\\s*[-–+o*•]\\s\\+'
-- opt.tabline= '%!uix#MyTabLine()'

