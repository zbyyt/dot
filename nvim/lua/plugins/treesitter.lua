return {
	-- TREESITTER #################################
	-- { "nvim-treesitter/nvim-treesitter",
	--	lazy = 'VeryLazy'
	-- },
	{ "nvim-treesitter/playground" },
  	{ "nvim-treesitter/nvim-treesitter",
    		event = { "BufReadPost", "BufNewFile" },
    		dependencies = {
      		{ "nvim-treesitter/nvim-treesitter-textobjects",},
    		},
		keys = {
      		{ "<c-space>", desc = "Increment selection" },
      		{ "<bs>", desc = "Decrement selection", mode = "x" },
    		},
    		-- ? ---@type TSConfig
    		opts = {
      		highlight = { enable = true },
      		indent = { enable = true },
      		ensure_installed = {
     	   		"bash",
    		    		"c",
	        		"html",
	        		"javascript",
	        		"json",
	       		 "lua",
	        		"luadoc",
	        		"luap",
	        		"markdown",
	        		"markdown_inline",
	        		"python",
	        		"query",
	        		"regex",
	       		 "tsx",
	        		"typescript",
	       		 "vim",
	        		"vimdoc",
	        		"yaml",
	      	},
	      	incremental_selection = {
	        		enable = true,
	        		keymaps = {
	          		init_selection = "<C-space>",
	          		node_incremental = "<C-space>",
	          		scope_incremental = false,
	          		node_decremental = "<bs>",
	      	  	},
	      	},
    		},
	},
}

