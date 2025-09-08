local M = {}

-- Get the home directory in a cross-platform way
local home = os.getenv 'HOME' or os.getenv 'USERPROFILE'

M.bg_blurred_darker = home .. '/.config/wezterm/assets/bg-blurred-darker.png'
M.bg_blurred = home .. '/.config/wezterm/assets/bg-blurred.png'

M.bg_image = M.bg_blurred_darker

return M
