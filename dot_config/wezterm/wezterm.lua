-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

-- Smart splits
local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

-- This will hold the configuration.
local config = wezterm.config_builder()

-- My custom theme
local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.tab_bar.background = custom.background
custom.tab_bar.active_tab.bg_color = custom.background
custom.tab_bar.active_tab.fg_color = custom.foreground
custom.tab_bar.inactive_tab.bg_color = "#64667B"
custom.tab_bar.inactive_tab.fg_color = custom.foreground
custom.tab_bar.new_tab.bg_color = custom.background
custom.tab_bar.new_tab.fg_color = custom.foreground
config.color_schemes = {
	["Myppuccin"] = custom,
}

config.color_scheme = "Myppuccin"
config.use_fancy_tab_bar = false
config.tab_max_width = 32

config.scrollback_lines = 5000
config.adjust_window_size_when_changing_font_size = false

-- Font
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14

-- Keybinds
config.send_composed_key_when_left_alt_is_pressed = true
config.leader = { key = "Space", mods = "CTRL" }
config.keys = {
	{
		key = "\\",
		mods = "LEADER",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},
	{
		key = "z",
		mods = "LEADER",
		action = "TogglePaneZoomState",
	},
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
	},
	{
		key = "n",
		mods = "LEADER",
		action = "SpawnWindow",
	},
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},
	{
		key = "h",
		mods = "LEADER|SHIFT",
		action = wezterm.action({ ActivateTabRelative = -1 }),
	},
	-- move between split panes
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	-- resize panes
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),
}

config.key_tables = {
	resize_pane = {
		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },

		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },

		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },

		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },

		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},
}

-- and finally, return the configuration to wezterm
return config
