-- =========================================================
-- =================== System Monitor ======================
-- =========================================================

local wibox = require("wibox")

local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local icons = require("icons.fonticons")

local cpu = require("panels.dashboard.cpu")
local mem = require("panels.dashboard.mem")

local helpers = require("global.helpers")

-- ~~~~~~~~~~~~~~~~ setup ~~~~~~~~~~~~~~~~~~~

-- -------- Images -----------
local activity_icon = icons.setup({
	name = icons.sysmon.activity,
	color = ICON_COLORS[COLORS],
})
local network_icon = icons.setup({
	name = icons.sysmon.internet,
	color = ICON_COLORS[COLORS],
})
local cpu_icon = icons.setup({
	name = icons.sysmon.memory,
	color = ICON_COLORS[COLORS],
})
local gpu_icon = icons.setup({
	name = icons.sysmon.microchip,
	color = ICON_COLORS[COLORS],
})
local disk_icon = icons.setup({
	name = icons.sysmon.disk,
	color = ICON_COLORS[COLORS],
})

-- ----- Widget Setup --------
local gpu_temp_script = [[bash -c "nvidia-smi | awk 'NR==10{print}' | cut -c 8-10"]]
local cpu_temp_script = [[bash -c "sensors | grep Package | awk '{print $4}' | cut -c 2-3"]]
local disk_max = [[bash -c "df -h | grep /dev/ | awk 'NR==1{print $2}'"]]
local disk_used = [[bash -c "df -h | grep /dev/ | awk 'NR==1{print $3}'"]]

-- --------- init ------------
local net_speed_widget = require("widget.net-speed-widget.net-speed")
local cpu_temp = helpers.watch(cpu_temp_script)
local gpu_temp = helpers.watch(gpu_temp_script)
local disk_max_no = helpers.watch(disk_max, 1200)
local disk_used_no = helpers.watch(disk_used, 1200)
local disk_text = wibox.widget.textbox("/")
local celcius = wibox.widget.textbox("°C")
celcius.font = "Roboto Mono Nerd Fonts Bold 9"
local mymem = mem({
	settings = function()
		widget:set_markup('<span font="' .. "Roboto Mono Nerd Fonts Bold 9" .. '">' .. mem_now.used .. " M</span>")
	end,
})
local mycpu = cpu({
	settings = function()
		widget:set_markup('<span font="' .. "Roboto Mono Nerd Fonts Bold 9" .. '">' .. cpu_now.usage .. " %</span>")
	end,
})

-- system monitor
local user_widget = wibox.widget({
	{
		helpers.horizontal_pad(dpi(35)),
		network_icon,
		helpers.horizontal_pad(dpi(5)),
		net_speed_widget,
		widget = wibox.container.margin,
		forced_height = dpi(20),
		layout = wibox.layout.fixed.horizontal,
	},
	{
		helpers.horizontal_pad(dpi(35)),
		{
			cpu_icon,
			helpers.horizontal_pad(dpi(5)),
			mycpu,
			helpers.horizontal_pad(dpi(5)),
			cpu_temp,
			celcius,
			forced_width = dpi(130),
			draw_empty = true,
			widget = wibox.container.margin,
			layout = wibox.layout.fixed.horizontal,
		},
		{
			gpu_icon,
			helpers.horizontal_pad(dpi(5)),
			gpu_temp,
			celcius,
			forced_width = dpi(130),
			draw_empty = true,
			widget = wibox.container.margin,
			layout = wibox.layout.fixed.horizontal,
		},
		widget = wibox.container.margin,
		forced_height = dpi(20),
		layout = wibox.layout.fixed.horizontal,
	},
	{
		helpers.horizontal_pad(dpi(35)),
		{
			activity_icon,
			helpers.horizontal_pad(dpi(5)),
			mymem,
			forced_width = dpi(130),
			draw_empty = true,
			widget = wibox.container.margin,
			layout = wibox.layout.fixed.horizontal,
		},
		{
			disk_icon,
			helpers.horizontal_pad(dpi(5)),
			disk_used_no,
			disk_text,
			disk_max_no,
			forced_width = dpi(130),
			draw_empty = true,
			widget = wibox.container.margin,
			layout = wibox.layout.fixed.horizontal,
		},
		widget = wibox.container.margin,
		forced_height = dpi(20),
		layout = wibox.layout.fixed.horizontal,
	},
	widget = wibox.container.margin,
	spacing = dpi(10),
	layout = wibox.layout.fixed.vertical,
})

helpers.bmaker(user_widget, apps.taskmanager)
helpers.add_hover_cursor(user_widget, "hand1")
return user_widget
