local awful = require("awful")

--  changing alacritty theme --
-- local alacrittycfg = os.getenv("HOME") .. "/.config/alacritty/alacritty.yml"
-- awful.spawn.with_shell([[
--     sed -i 's/*]] .. prev_theme .. [[/*]] .. COLORS .. [[/' ]] .. alacrittycfg .. [[
-- ]])

-- -- changing gtk theme -----
local gtk_cfg = os.getenv("HOME") .. "/.config/gtk-3.0/settings.ini"

-- create config file if does not exist
-- awful.spawn.easy_async_with_shell([[
--         test -f ]] .. gtk_cfg .. [[ && echo "yes"
--     ]], function(stdout)
-- 	if stdout:match("yes") then
-- 		return
-- 	else
-- 		awful.spawn.with_shell("touch " .. gtk_cfg)
-- 	end
-- end)

local script_find_line = [[grep -n 'gtk-theme-name' ]] .. gtk_cfg .. [[ | awk -F'[^0-9]*' '{print $1}']]
awful.spawn.easy_async_with_shell(script_find_line, function(stdout)
	local line = stdout:gsub("%\n", "")
	awful.spawn.with_shell(
		[[sed -i ']] .. line .. [[s/.*/'gtk-theme-name=]] .. THEME_NAMES[COLORS] .. [['/' ]] .. gtk_cfg .. [[;]]
	)
end)

--  changing kvantum theme ---
local kvantumcfg = os.getenv("HOME") .. "/.config/Kvantum/kvantum.kvconfig"
awful.spawn.with_shell([[
    echo "[General]
    theme=]] .. KV_THEME_NAMES[COLORS] .. [[" > ]] .. kvantumcfg .. [[
]])

-- Xresource/change colorscheme of st terminal requires patch
awful.spawn.with_shell("xrdb merge " .. os.getenv("HOME") .. "/.config/awesome/configs/st/" .. COLORS)
