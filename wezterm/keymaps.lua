local wezterm = require("wezterm")

local action = wezterm.action
local M = {}

M.keys = {
	-- Send C-a when pressing C-a twice
	{ mods = "LEADER", key = "a", action = action.SendKey({ key = "a", mods = "CTRL" }) },

	{ key = "c", mods = "LEADER", action = action.ActivateCopyMode },
	{ key = ":", mods = "LEADER", action = action.ActivateCommandPalette },
	{ key = "s", mods = "LEADER", action = action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
	{ key = "w", mods = "LEADER", action = action.ShowTabNavigator },
	{ key = "c", mods = "LEADER", action = action.SpawnTab("CurrentPaneDomain") },
	{ key = "p", mods = "LEADER", action = action.ActivateTabRelative(-1) },
	{ key = "n", mods = "LEADER", action = action.ActivateTabRelative(1) },
	-- Pane keybindings
	{ key = "-", mods = "LEADER", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- SHIFT is for when caps lock is on
	{ key = "|", mods = "LEADER|SHIFT", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "LEADER", action = action.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = action.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = action.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = action.ActivatePaneDirection("Right") },
	{ key = "x", mods = "LEADER", action = action.CloseCurrentPane({ confirm = true }) },
	{ key = "z", mods = "LEADER", action = action.TogglePaneZoomState },

	-- Key table for moving tabs and resizing panes
	{ key = "r", mods = "LEADER", action = action.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
	{ key = ".", mods = "LEADER", action = action.ActivateKeyTable({ name = "move_tab", one_shot = false }) },
}

M.key_tables = {
	resize_pane = {
		{ key = "h", action = action.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", action = action.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = action.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", action = action.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
	move_tab = {
		{ key = "h", action = action.MoveTabRelative(-1) },
		{ key = "j", action = action.MoveTabRelative(-1) },
		{ key = "k", action = action.MoveTabRelative(1) },
		{ key = "l", action = action.MoveTabRelative(1) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

return M
