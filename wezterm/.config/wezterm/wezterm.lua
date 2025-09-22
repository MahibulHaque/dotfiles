local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local constants = require 'constant'
local keymaps = require 'keymaps'
local commands = require 'commands'

-- Keybinding override
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000 }
config.keys = keymaps.keys
config.key_tables = keymaps.key_tables

-- leader + number (1-9) to activate tab 0-8
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

-- Font settings
config.font_size = 20
config.line_height = 1.2
config.font = wezterm.font('JetBrains Mono', { italic = false })

-- Colors
config.color_scheme = 'Tokyo Night'
config.colors = {
  cursor_bg = 'white',
  cursor_border = 'white',
}

config.window_close_confirmation = 'NeverPrompt'

config.macos_window_background_blur = 40

-- Miscellaneous settings
config.max_fps = 120
config.prefer_egl = true

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

-- Custom commands
wezterm.on('augment-command-palette', function()
  return commands
end)

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

wezterm.on('update-right-status', function(window, pane)
  local stat = window:active_workspace()
  local stat_color = '#7aa2f7' -- default workspace color
  local prefix = ''

  -- Colors
  local arrow_color = '#c6a0f6'
  local folder_color = '#7dcfff'
  local command_color = '#e0af68'

  -- Adjust if key table is active
  if window:active_key_table() then
    stat = window:active_key_table()
    stat_color = '#bb9af7' -- key table purple
  end

  -- Adjust if leader key is active
  if window:leader_is_active() then
    prefix = ' ' .. utf8.char(0x1f30a) -- ocean wave emoji
    stat_color = '#9ece6a' -- green for active leader
  end

  -- Change arrow color if tab is not first
  if window:active_tab():tab_id() ~= 0 then
    arrow_color = '#1e2030'
  end

  local function basename(s)
    return string.gsub(s, '(.*[/\\])(.*)', '%2')
  end

  -- Get current directory
  local cwd = pane:get_current_working_dir()
  cwd = cwd and basename(cwd.file_path) or ''

  -- Get current command
  local cmd = pane:get_foreground_process_name()
  cmd = cmd and basename(cmd) or ''

  -- Left status
  window:set_left_status(wezterm.format {
    { Foreground = { Color = stat_color } },
    { Text = prefix },
    { Foreground = { Color = arrow_color } },
  })

  -- Right status
  window:set_right_status(wezterm.format {
    { Foreground = { Color = stat_color } },
    { Text = stat },
    { Text = ' | ' },
    { Foreground = { Color = folder_color } },
    { Text = wezterm.nerdfonts.md_folder .. '  ' .. cwd },
    { Text = ' | ' },
    { Foreground = { Color = command_color } },
    { Text = wezterm.nerdfonts.fa_code .. '  ' .. cmd },
    { Text = '  ' },
  })
end)

return config
