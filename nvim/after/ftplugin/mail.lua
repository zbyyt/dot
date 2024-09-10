-- DESCRIPTION: ###############################
-- 'after' directory is required. Another file in the runtime directory was
-- overiding the options in this file, when sourced from ftplugin alone..

-- FORMATTING OPTIONS: #########################
-- w: trailing white space indicates continued paragraph
-- a: auto format para's. Reformating on edits (good with 'w'?)
-- n: recognise numbered lists
-- t: hard wrap line at 'textwidth'
-- 2: 2nd line indent for rest of paragraph
-- v: 
-- ## COMMENT OPTIONS:
-- c: autowrap comments
-- r: auto insert comment leader
-- other options in :h fo-table

-- ######################################
-- NEWER SOLUTION: AUTOMATIC REFORMATTING DURING EDITING..

vim.wo.spell                 = true
vim.bo.spelllang             = 'en' -- TODO: download en_gb or en_uk
vim.opt.formatoptions:append({'aw'})

