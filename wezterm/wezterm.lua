local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()
local constants = require("constant")
local keymaps = require("keymaps")

-- Keybinding override
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = keymaps.keys
config.key_tables = keymaps.key_tables
for i = 0, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i),
	})
end

-- Font settings
config.font_size = 14
config.line_height = 1.2
config.font = wezterm.font("GeistMono Nerd Font")

-- Colors
config.color_scheme = "Tokyo Night"
config.colors = {
	cursor_bg = "white",
	cursor_border = "white",
}

-- Appearance
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true
config.window_background_image = constants.bg_image
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.default_prog = { "pwsh.exe", "-NoLogo" }

-- wezterm.on("gui-startup", function(cmd)
-- 	-- allow `wezterm start -- something` to affect what we spawn
-- 	-- in our initial window
-- 	local args = {}
-- 	if cmd then
-- 		args = cmd.args
-- 	end
--
-- 	-- Set a workspace for coding on a current project
-- 	-- Top pane is for the editor, bottom pane is for the build tool
-- 	local home_dir = wezterm.home_dir
-- 	local work_dir = "F:/work"
-- 	local personal_dir = "F:/personal"
-- 	local dotflies_dir = home_dir .. "/dotfiles"
-- 	mux.spawn_window({
-- 		workspace = "Work",
-- 		cwd = work_dir,
-- 		args = args,
-- 	})
-- 	mux.spawn_window({
-- 		workspace = "Personal",
-- 		cwd = personal_dir,
-- 		args = args,
-- 	})
-- 	mux.spawn_window({
-- 		workspace = "Dotfiles",
-- 		cwd = dotflies_dir,
-- 		args = args,
-- 	})
-- 	mux.set_active_workspace("Work")
-- end)

wezterm.on("update-right-status", function(window, pane)
	local stat = window:active_workspace()
	local stat_color = "#7aa2f7" -- default workspace color
	local prefix = ""

	-- Colors
	local arrow_color = "#c6a0f6"
	local folder_color = "#7dcfff"
	local command_color = "#e0af68"

	-- Adjust if key table is active
	if window:active_key_table() then
		stat = window:active_key_table()
		stat_color = "#bb9af7" -- key table purple
	end

	-- Adjust if leader key is active
	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1f30a) -- ocean wave emoji
		stat_color = "#9ece6a" -- green for active leader
	end

	-- Change arrow color if tab is not first
	if window:active_tab():tab_id() ~= 0 then
		arrow_color = "#1e2030"
	end

	local function basename(s)
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end

	-- Get current directory
	local cwd = pane:get_current_working_dir()
	cwd = cwd and basename(cwd.file_path) or ""

	-- Get current command
	local cmd = pane:get_foreground_process_name()
	cmd = cmd and basename(cmd) or ""

	-- Left status
	window:set_left_status(wezterm.format({
		{ Foreground = { Color = stat_color } },
		{ Text = prefix },
		{ Foreground = { Color = arrow_color } },
	}))

	-- Right status
	window:set_right_status(wezterm.format({
		{ Foreground = { Color = stat_color } },
		{ Text = stat },
		{ Text = " | " },
		{ Foreground = { Color = folder_color } },
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		{ Text = " | " },
		{ Foreground = { Color = command_color } },
		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		{ Text = "  " },
	}))
end)

return config
