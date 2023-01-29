local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")

-- --------- menu ------------

local myawesomemenu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{
		"manual",
		apps.terminal .. " -e man awesome",
	},
	{
		"edit config",
		apps.editor .. " " .. awesome.conffile,
	},
	{
		"restart",
		awesome.restart,
	},
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

local awesomecfg = os.getenv("HOME") .. "/.config/awesome/rc.lua"
local script = [[grep -n 'COLORS=*' ]] .. awesomecfg .. [[ | cut -c 1-2 | awk 'NR==1{print}']]

local theme_menu = {
	{
		"nord",
		function()
			awful.spawn.easy_async_with_shell(script, function(stdout)
				stdout = stdout:gsub("%\n", "")
				awful.spawn.with_shell([[
                sed -i ']] .. stdout .. [[s/.*/COLORS = "nord"/' ]] .. awesomecfg .. [[;
                echo 'awesome.restart()' | awesome-client
            ]])
			end)
		end,
	},
	{
		"gruvbox",
		function()
			awful.spawn.easy_async_with_shell(script, function(stdout)
				stdout = stdout:gsub("%\n", "")
				awful.spawn.with_shell([[
                sed -i ']] .. stdout .. [[s/.*/COLORS = "gruvbox"/' ]] .. awesomecfg .. [[;
                echo 'awesome.restart()' | awesome-client
            ]])
			end)
		end,
	},
	{
		"rxyhn",
		function()
			awful.spawn.easy_async_with_shell(script, function(stdout)
				stdout = stdout:gsub("%\n", "")
				awful.spawn.with_shell([[
                sed -i ']] .. stdout .. [[s/.*/COLORS = "rxyhn"/' ]] .. awesomecfg .. [[;
                echo 'awesome.restart()' | awesome-client
            ]])
			end)
		end,
	},
	{
		"everforest",
		function()
			awful.spawn.easy_async_with_shell(script, function(stdout)
				stdout = stdout:gsub("%\n", "")
				awful.spawn.with_shell([[
                sed -i ']] .. stdout .. [[s/.*/COLORS = "everforest"/' ]] .. awesomecfg .. [[;
                echo 'awesome.restart()' | awesome-client
            ]])
			end)
		end,
	},
	{
		"tokyonight",
		function()
			awful.spawn.easy_async_with_shell(script, function(stdout)
				stdout = stdout:gsub("%\n", "")
				awful.spawn.with_shell([[
                sed -i ']] .. stdout .. [[s/.*/COLORS = "tokyonight"/' ]] .. awesomecfg .. [[;
                echo 'awesome.restart()' | awesome-client
            ]])
			end)
		end,
	},
}

local run_menu = {
	{
		"Terminal",
		apps.terminal,
	},
	{
		"Browser",
		apps.browser,
	},
	{
		"Text Editor",
		apps.editor,
	},
	{
		"File Manager",
		apps.filebrowser,
	},
}

local main_menu = awful.menu({
	items = {
		{
			"Refresh",
			awesome.restart,
		},
		{
			"Run",
			run_menu,
		},
		{
			"Theme",
			theme_menu,
		},
		{
			"Awesome",
			myawesomemenu,
			beautiful.awesome_icon,
		},
	},
})

awesome.connect_signal("menu::toggle", function()
	main_menu:toggle()
end)

awesome.connect_signal("menu::hide", function()
	main_menu:hide()
end)
