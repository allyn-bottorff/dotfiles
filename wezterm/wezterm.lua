local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.dpi = 138
-- config.freetype_load_flags = "FORCE_AUTOHINT"
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"
config.audible_bell = "Disabled"
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.window_frame = {
	font_size = 11,
}

config.color_scheme_dirs = { "$HOME/.config/wezterm/colors" }
config.color_scheme = "nordic"
config.font = wezterm.font({
	family = "Berkeley Mono Variable",
	-- harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.font_size = 11

return config
