wezterm = require "wezterm"
util = require "util"
local config = {}

require("appearance").apply_to_config(config)
require("fonts").apply_to_config(config)
require("keybindings").apply_to_config(config)
require("config").apply_to_config(config)
require("events").apply_to_config(config)

return config
