local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

-- default map
local def_map = {
    -- Vim map
--    ["n|<C-x>k"] = map_cr('bdelete'):with_noremap():with_silent(),
    ["i|<C-s>"] = map_cmd("<Esc>:w<CR>"),

}

bind.nvim_load_mapping(def_map)
