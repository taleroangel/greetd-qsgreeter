-- Hyprland configuration for running qsgreeter as the greetd greeter.
-- Launch it from /etc/greetd/config.toml:
--   command = "start-hyprland -- --config /etc/greetd/qsgreeter-hyprland.lua"

-- Start the greeter. Once it exits (after a successful login or a cancel),
-- quit Hyprland so greetd can launch the selected session.
hl.on("hyprland.start", function ()
	hl.exec_cmd("sh -c 'quickshell -c qsgreeter; hyprctl dispatch \"hl.dsp.exit()\"'")
end)

-- Fill the screen with the greeter window
hl.window_rule({
	name     = "qsgreeter-maximize",
	match    = { title = "^(qsgreeter)$" },
	maximize = true,
})

hl.config({
	general = {
		gaps_in     = 0,
		gaps_out    = 0,
		border_size = 0,
	},

	decoration = {
		rounding = 0,
		shadow   = { enabled = false },
		blur     = { enabled = false },
	},

	animations = {
		enabled = false,
	},

	misc = {
		disable_hyprland_logo    = true,
		disable_splash_rendering = true,
		force_default_wallpaper  = 0,
		background_color         = "rgb(141317)",
	},

	ecosystem = {
		no_update_news  = true,
		no_donation_nag = true,
	},

	-- input = {
	-- 	kb_layout = "us",
	-- },
})
