local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("global.helpers")
local dpi = beautiful.xresources.apply_dpi

local M = {}

M.misc = {
	search = "",
	bulb = "",
	terminal = "",
	color = "",
	dashboard = "",
	dropper = "",
	plus = "",
	steam = "",
	arch = "",
	pen = "",
	brighness = "",
	code = "",
	gauge = "",
	lightbulb = "",
	calender = " ",
	clock = "",
}

M.git = {
	LineAdded = " ",
	LineModified = " ",
	LineRemoved = " ",
	FileDeleted = " ",
	FileIgnored = "◌",
	FileRenamed = "➜",
	FileStaged = "S",
	FileUnmerged = "",
	FileUnstaged = "",
	FileUntracked = "U",
	Diff = " ",
	Repo = " ",
	Octoface = " ",
	Branch = "",
	omega = "",
}

M.headphones = {
	on = "  ",
	off = " ﳌ ",
}

M.sysmon = {
	activity = "  ",
	internet = "  ",
	microchip = "  ",
	memory = "  ",
	gpu = " 菉",
	disk = "  ",
}

M.wifi = {
	on = "直",
	off = "睊",
}

M.volume = {
	mute = " 婢",
	full = " 墳",
	medium = " 奔",
	low = " 奄",
}

M.bluetooth = {
	on = "",
	off = "",
}

M.microphone = {
	on = "  ",
	off = "  ",
}

M.user = {
	power = "  ",
	sleep = "  ",
	restart = " ﯩ ",
}

M.navigation = {
	ArrowCircleDown = "  ",
	ArrowCircleLeft = "  ",
	ArrowCircleRight = "  ",
	ArrowCircleUp = "  ",
	BoldArrowDown = "  ",
	BoldArrowLeft = "  ",
	BoldArrowRight = "  ",
	BoldArrowUp = "  ",
	BoldClose = "  ",
	BoldDividerLeft = "  ",
	BoldDividerRight = "  ",
	TriangleShortArrowDown = "  ",
	TriangleShortArrowLeft = "  ",
	TriangleShortArrowRight = "  ",
	TriangleShortArrowUp = "  ",
}

M.setup = function(args)
	local name = args.name or " "
	local size = args.size or "14"
	local width = args.width or dpi(40)
	local height = args.height or dpi(40)
	local color = args.color or beautiful.icon_color
	local icon = wibox.widget({
		font = beautiful.icon_fonts .. " " .. size,
		markup = helpers.colorize_text(name, color),
		align = "center",
		valign = "center",
		forced_width = width,
		forced_height = height,
		widget = wibox.widget.textbox,
	})
	return icon
end

return M
