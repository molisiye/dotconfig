local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_args = bind.map_args
require('keymap.config')

local plug_map = {
--     ["i|<TAB>"] = map_cmd('v:lua.tab_complete()'):with_expr():with_silent();
    ["i|<S-TAB>"] = map_cmd('v:lua.s_tab_complete'):with_expr():with_silent();
--    ["i|<CR>"] = map_cmd([[compe#confirm({'keys': "\<Plug>delimitMateCR", 'mode': ''})]]):with_expr():with_noremap():with_nowait();
	-- Packer
	["n|<Leader>pu"] = map_cr("PackerUpdate"):with_silent():with_noremap():with_nowait();
	["n|<Leader>pi"] = map_cr("PackerInstall"):with_silent():with_noremap():with_nowait();
 	["n|<Leader>pc"] = map_cr("Packer"):with_silent():with_noremap():with_nowait();
    -- Plugin DadbodUI
    ["n|<Leader>od"] = map_cr('DBUIToggle'):with_noremap():with_silent();
    -- Plugin Floaterm
    ["n|<A-d>"] = map_cu('Lspsaga open_floaterm'):with_noremap():with_silent();
    ["t|<A-d>"] = map_cu([[<C-\><C-n>:Lspsaga close_floaterm<CR>]]):with_noremap():with_silent();
    ["n|<Leader>g"] = map_cu("Lspsage open_floaterm lazygit"):with_noremap():with_silent();
	-- Plugin nvim-tree
	["n|<Leader>e"] = map_cr('NvimTreeToggle'):with_noremap():with_silent();
	["n|<Leader>F"] = map_cr('NvimTreeFindFile'):with_noremap():with_silent();
    -- Far.vim
    ["n|<Leader>fz"] = map_cr('Farf'):with_noremap():with_silent();
    ["v|<Leader>fz"] = map_cr('Farf'):with_noremap():with_silent();
    -- Plugin MarkdownPreview
    ["n|<Leader>om"] = map_cu('MarkdownPreview'):with_noremap():with_silent();
    -- Plugin vista
    ["n|<Leader>v"] = map_cu('Vista'):with_noremap():with_silent();
    -- Plugin vim-operator-surround
    ["n|sa"] = map_cmd("<Plug>(operator-surround-append)"):with_silent();
    ["n|sd"] = map_cmd("<Plug>(operator-surround-delete)"):with_silent();
    ["n|sr"] = map_cmd("<Plug>(operator-surround-replace)"):with_silent();
    -- Lsp map work when insertenter and lsp start
    ["n|<leader>li"] = map_cr("LspInfo"):with_noremap():with_silent():with_nowait();
    ["n|<C-f>"] = map_cmd("<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>"):with_silent():with_noremap():with_nowait();
    -- prodoc
    ["n|gcc"] = map_cu('ProComment'):with_noremap():with_silent();
    ["x|gcc"] = map_cr('ProComment');
    ["n|gcj"] = map_cu('ProDoc'):with_silent();
    -- Plugin Telescope
    ["n|<Leader>bb"] = map_cu('Telescope buffers'):with_noremap():with_silent();
    ["n|<Leader>fa"] = map_cu('DashboardFindWord'):with_noremap():with_silent();
    ["n|<Leader>fb"] = map_cu('Telescope file_browser'):with_noremap():with_silent();
    ["n|<Leader>ff"] = map_cu('DashboardFindFile'):with_noremap():with_silent();
    ["n|<Leader>fg"] = map_cu('Telescope git_files'):with_noremap():with_silent();
    ["n|<Leader>fw"] = map_cu('Telescope grep_string'):with_noremap():with_silent();
    ["n|<Leader>fh"] = map_cu('DashboardFindHistory'):with_noremap():with_silent();
    ["n|<Leader>fl"] = map_cu('Telescope loclist'):with_noremap():with_silent();
    ["n|<Leader>fc"] = map_cu('Telescope git_commits'):with_noremap():with_silent();
    ["n|<Leader>ft"] = map_cu('Telescope help_tags'):with_noremap():with_silent();
    ["n|<Leader>fd"] = map_cu('Telescope dotfiles path=' .. os.getenv("HOME") .. '/.dotfiles'):with_noremap():with_silent();

}

bind.nvim_load_mapping(plug_map)
