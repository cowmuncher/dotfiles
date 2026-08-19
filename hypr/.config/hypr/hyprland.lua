-- MONITORS --

hl.monitor({
  output    = "",
  mode      = "preferred",
  position  = "auto",
  scale     = 1,
})


-- MY PROGRAMS --

local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "rofi -show drun"


-- AUTOSTART --

hl.on("hyprland.start", function ()
  hl.exec_cmd("waybar")
  --hl.exec_cmd("swaybg -i ~/.config/hypr/wallpaper1.png -m fill")
  hl.exec_cmd("lxqt-policykit-agent")
  hl.exec_cmd("swayidle -w timeout 300 'swaylock -f -c 000000 --indicator-thickness 5' timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock -f -c 000000 --indicator-thickness 5'")
  hl.exec_cmd("sleep 0.5 && kitty --class ncspot -e ncspot")
  hl.exec_cmd("sleep 0.5 && kitty --class cava -e cava")
  hl.exec_cmd("sleep 0.5 && kitty --class kitty1")
  hl.exec_cmd("sleep 0.5 && kitty --class btop -e btop")
end)


-- ENVIRONMENT VARIABLES --

hl.env("XCURSOR_SIZE", "24")

-- PERMISSIONS --



-- LOOK AND FEEL --

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,

    border_size = 2,

    col = {
      active_border   = "rgba(55555599)",
      inactive_border = "rgba(00000000)",
    },

    resize_on_border = false,

    allow_tearing = false,

    layout = "dwindle",
  },

  decoration = {
    rounding = 0,
    rounding_power = 0,

    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = true,
      range = 10,
      render_power = 10,
      color = "rgba(55555580)",
      color_inactive = "rgba(00000099)",
    },

    blur = {
      enabled = true,
      size = 5,
      passes = 1,
      vibrancy = 0.1696,
    },
  },

  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    force_default_wallpaper = 0,
    background_color = "rgb(111111)",
  },

  animations = {
    enabled = true,
  },
})

hl.animation({ leaf = "windows",    enabled = true,   speed = 2,    bezier = "default",   style = "slide" })
hl.animation({ leaf = "border",     enabled = true,   speed = 2,    bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true,   speed = 2,    bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true,   speed = 2,    bezier = "default" })

hl.config({
  dwindle = {
    preserve_split = true,
  },
})

hl.config({
  master = {
    new_status = "master",
  },
})


-- MISC --



-- INPUT --

hl.config({
  input = {
    kb_layout   = "dk",
    kb_variant  = "",
    kb_model    = "",
    kb_options  = "",
    kb_rules    = "",

    follow_mouse = 1,

    sensitivity  = 0,

    touchpad = {
      natural_scroll = true,
    },
  },
})


-- KEYBINDINGS --

local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle"}))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + B", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("CTRL + SHIFT + left",  hl.dsp.window.resize({ x = -50, y = 0,   relative = true }), { repeating = true })
hl.bind("CTRL + SHIFT + right", hl.dsp.window.resize({ x = 50,  y = 0,   relative = true }), { repeating = true })
hl.bind("CTRL + SHIFT + up",    hl.dsp.window.resize({ x = 0,   y = -50, relative = true }), { repeating = true })
hl.bind("CTRL + SHIFT + down",  hl.dsp.window.resize({ x = 0,   y = 50,  relative = true }), { repeating = true })

hl.bind("CTRL + SHIFT + H", hl.dsp.window.resize({ x = -50, y = 0,   relative = true }), { repeating = true })
hl.bind("CTRL + SHIFT + L", hl.dsp.window.resize({ x = 50,  y = 0,   relative = true }), { repeating = true })
hl.bind("CTRL + SHIFT + K", hl.dsp.window.resize({ x = 0,   y = -50, relative = true }), { repeating = true })
hl.bind("CTRL + SHIFT + J", hl.dsp.window.resize({ x = 0,   y = 50,  relative = true }), { repeating = true })

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind("SHIFT + CTRL + S", hl.dsp.exec_cmd("~/Scripts/screenshot.sh"))


local zenMode = false

hl.bind(mainMod .. " + onehalf", function()
  hl.dispatch(hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
  
  if not zenMode then
    hl.config({ general = { gaps_in = 0 } })
    hl.config({ general = { gaps_out = 0 } })
    hl.config({ decoration = { shadow = { enabled = false } } })
    zenMode = true
    hl.device({ name = "etps/2-elantech-touchpad", enabled = false })
    hl.config({ cursor = { invisible = true } })
  else
    hl.config({ general = { gaps_in = 5 } })
    hl.config({ general = { gaps_out = 10 } })
    hl.config({ decoration = { shadow = { enabled = true } } })
    zenMode = false
    hl.device({ name = "etps/2-elantech-touchpad", enabled = true })
    hl.config({ cursor = { invisible = false } })
  end
end)


-- WINDOWS AND WORKSPACES --

local suppressMaximizeRule = hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name      = "move-hyprland-run",
    match     = { class = "hyprland-run" },

    move      = "20 monitor_h-120",
    float     = true,
})

-- CHECK SYNTAX! --
hl.window_rule({
  name        = "float-misc-class",
  match       = { class = "(org.pulseaudio.pavucontrol|blueman-manager)" },
  size        = "monitor_w*0.5 monitor_h*0.5",
  float       = true,
})

hl.window_rule({
  name        = "float-misc-title",
  match       = { title = "Open Files" },
  size        = "monitor_w*0.5 monitor_h*0.5",
  float       = true,
  center      = true,
})

hl.window_rule({
  name        = "float-steam-friends",
  match       = { title = "Friends List" },
  size        = "monitor_w*0.2 monitor_h*0.6",
  float       = true,
  move        = "monitor_w*0.8 monitor_h*0.4",
})

hl.window_rule({
  name        = "ncspot",
  match       = { class = "ncspot" },
  workspace   = 1,
  float       = true,
  size        = "monitor_w*0.46 monitor_h*0.40",
  move        = "monitor_w*0.025 monitor_h/15",
})

hl.window_rule({
  name        = "cava",
  match       = { class = "cava" },
  workspace   = 1,
  float       = true,
  size        = "monitor_w*0.46 monitor_h*0.40",
  move        = "monitor_w*0.515 monitor_h/15",
})

hl.window_rule({
  name        = "kitty",
  match       = { class = "kitty1" },
  workspace   = 1,
  float       = true,
  size        = "monitor_w*0.46 monitor_h*0.46",
  move        = "monitor_w*0.515 monitor_h*0.50",
})

hl.window_rule({
  name        = "btop",
  match       = { class = "btop" },
  workspace   = 1,
  float       = true,
  size        = "monitor_w*0.46 monitor_h*0.46",
  move        = "monitor_w*0.025 monitor_h*0.50",
})

hl.window_rule({
  name        = "float-workspace1",
  match       = { workspace = 1 },
  float       = true,
})

hl.layer_rule({
  name        = "rofi-blur",
  match       = { namespace = "rofi" },
  blur        = true,
})
