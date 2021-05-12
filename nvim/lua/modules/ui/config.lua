local config = {}


startify_icon_vim = ''
startify_icon_update = ''
startify_icon_vulkan = ''
startify_icon_love = ''
startify_icon_link = ''
startify_icon_github = ''
startify_icon_key = ''
startify_icon_watch = ''
startify_icon_color = ''
startify_icon_airline = ''
startify_icon_font = ''
startify_icon_fontsize = ''
startify_icon_server = ''


function config.galaxyline()
	require('modules.ui.eviline')
end

function config.nvim_bufferline()
	require('bufferline').setup{
		options = {
			modified_icon = '✥',
			buffer_close_icon = '',
			mappings = true,
			always_show_bufferline = false,
		}
	}
end


function config.dashboard()
  local home = os.getenv('HOME')
  vim.g.dashboard_footer_icon = '🐬 '
   vim.g.dashboard_preview_command = 'cat'
   vim.g.dashboard_preview_pipeline = 'lolcat -F 0.3'
   vim.g.dashboard_preview_file = home .. '/.config/nvim/static/neovim.cat'
   vim.g.dashboard_preview_file_height = 12
   vim.g.dashboard_preview_file_width = 80
  vim.g.dashboard_default_executive = 'telescope'
  vim.g.dashboard_custom_section = {
    last_session = {
      description = {'  Recently laset session                  SPC s l'},
      command =  'SessionLoad'},
    find_history = {
      description = {'  Recently opened files                   SPC f h'},
      command =  'DashboardFindHistory'},
    find_file  = {
      description = {'  Find  File                              SPC f f'},
      command = 'Telescope find_files find_command=rg,--hidden,--files'},
    new_file = {
     description = {'  File Browser                            SPC f b'},
     command =  'Telescope file_browser'},
    find_word = {
     description = {'  Find  word                              SPC f w'},
     command = 'DashboardFindWord'},
    find_dotfiles = {
     description = {'  Open Personal dotfiles                  SPC f d'},
     command = 'Telescope dotfiles path=' .. home ..'/.dotfiles'},
  }
end

function config.nvim_tree()
	-- On Ready Event for Lazy Loading work
	require("nvim-tree.events").on_nvim_tree_ready(
	function()
		vim.cmd("NvimTreeRefresh")
	end
	)

	vim.g.nvim_tree_follow = 1
	vim.g.nvim_tree_hide_dotfiles = 1
	vim.g.nvim_tree_indent_markers = 1
	vim.g.nvim_tree_bindings = {
		["l"] = ":lua require'nvim-tree'.on_keypress('edit')<CR>",
		["s"] = ":lua require'nvim-tree'.on_keypress('vsplit')<CR>",
		["i"] = ":lua require'nvim-tree'.on_keypress('split')<CR>",
	}

	vim.g.nvim_tree_icons = {
    		  default =  '',
	          symlink =  '',
	          git = {
	          unstaged = "✚",
	          staged =  "✚",
	          unmerged =  "≠",
                  renamed =  "≫",
      	          untracked = "★",
	          },
  	}
end


function config.gitsigns()
	if not packer_plugins['plenary.nvim'].loaded then
		vim.cmd[[packadd plenary.nvim]]
	end

	require('gitsigns').setup{
		    signs = {
      add = {hl = 'GitGutterAdd', text = '▋'},
      change = {hl = 'GitGutterChange',text= '▋'},
      delete = {hl= 'GitGutterDelete', text = '▋'},
      topdelete = {hl ='GitGutterDeleteChange',text = '▔'},
      changedelete = {hl = 'GitGutterChange', text = '▎'},
    },
    keymaps = {
       -- Default keymap options
       noremap = true,
       buffer = true,

       ['n ]g'] = { expr = true, "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
       ['n [g'] = { expr = true, "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

       ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
       ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
       ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
       ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
       ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

       -- Text objects
       ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
       ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
     },
  }
end


function config.indent_blankline()
	vim.g.indent_blankline_char = "|"
	vim.g.indent_blankline_show_first_indent_level = true
	vim.g.indent_blankline_filetype_exclude = {
		"startify",
		"dashboard",
		"dotooagenda",
		"log",
		"fugitive",
		"gitcommit",
		"packer",
		"markdown",
		"json",
		"txt",
		"vista",
		"help",
		"todolist",
		"NvimTree",
		"peekaboo",
		"git",
		"undotree",
		"Telescopeprompt",
	}

	vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
	vim.g.indent_blankline_show_trailing_blankline_indent = false
	vim.g.indent_blankline_show_current_context = true
	vim.g.indent_blankline_context_patterns = {
		"class",
		"function",
		"method",
		"block",
		"list_literal",
		"selector",
		"^if",
		"^table",
		"if_statement",
		"while",
		"for"
	}

	-- because lazy load indent-blankline so need read this autocmd
	vim.cmd('autocmd CursorMoved * IndentBlanklineRefresh')
end

return config
