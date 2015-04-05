local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
--local menubar = require("menubar")
local vicious = require("vicious")
local lain = require("lain")
local freedesktop = require('freedesktop')
local scratch = require('scratchdrop')
local eminent = require('eminent')
--local launchbar = require("launchbar")
 --local bittery = require("battery")

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, fallo durante el inicio!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops,  Ha ocurrido un fallo!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/pabucolor/theme.lua")

terminal = "mate-terminal"
terminalx = "lxterminal"  --aplicaciones
editor_cmd = "lxterminal" .. " -e " .. "vim" --editor vim
editorSubl = "sublime"
modkey     = "Mod4"
altkey     = "Mod1"
cfg_dir = "~/.config/awesome"

lain.layout.termfair.nmaster   = 3
lain.layout.termfair.ncol      = 1
lain.layout.centerfair.nmaster = 3
lain.layout.centerfair.ncol    = 1

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.magnifier,
    awful.layout.suit.tile.left,
     lain.layout.uselessfair,
    awful.layout.suit.tile.bottom,
     lain.layout.termfair,
    awful.layout.suit.tile.top,
     lain.layout.centerfair,
     lain.layout.uselesspiral.dwindle
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end

-- wallpaper for a screen
wp_index = 1
wp_timeout  = 120
wp_path = os.getenv("HOME") .."/.config/awesome/themes/pabucolor/wallpaper/"
wp_files = { "01.jpg", "02.jpg", "03.jpg", "04.jpg", "05.jpg", "06.png", "07.jpg", "08.jpg", "09.jpg", "10.jpg"  }

wp_timer = timer { timeout = wp_timeout }
wp_timer:connect_signal("timeout", function()
                  gears.wallpaper.maximized( wp_path .. wp_files[wp_index] , s, true)
                  wp_timer:stop()
                  wp_index = math.random( 1, #wp_files)
                  wp_timer.timeout = wp_timeout
                  wp_timer:start()
                  end)
wp_timer:start()
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
   names = { "一", "二", "三", "四", "五", "六" },
   layout = { layouts[2], layouts[3], layouts[7], layouts[10], layouts[4], layouts[8] }
}
for s = 1, screen.count() do
    tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ Menu
freedesktop.utils.terminal = terminal

myawesomemenu = {
    { "manual", terminal .. " -e man awesome", freedesktop.utils.lookup_icon({ icon = 'help' }) },
    { "edit config", editor_cmd .. " " .. awesome.conffile, freedesktop.utils.lookup_icon({ icon = 'package_settings' }) },
    { "edit theme", editor_cmd .. " " .. awful.util.getdir("config") 
                              .. "/themes/cesious/theme.lua", freedesktop.utils.lookup_icon({ icon = 'package_settings' }) },
    { "restart", awesome.restart, freedesktop.utils.lookup_icon({ icon = 'gtk-refresh' }) }
}

utilmenu = {
    { "Screenshot",         "gnome-screenshot --interactive" },
    { "git garfics",        "gitg" },
    { "Calculator",         "gnome-calculator" },
    { "Monitor System",     "gnome-system-monitor" },
    { "Ncftp",              terminal .. " -e ncftp" },
    { "Cmatrix",            terminal .. " -e cmatrix" },
    { "Fish-terminal",      terminal .. " -e fish" },
    { "Red Editor",         "nm-connection-editor" },
    { "Mocp",    terminalx .." -e mocp", freedesktop.utils.lookup_icon({icon = 'utilities-terminal'}) },
    { "Cmus",    terminalx .. " -e cmus", freedesktop.utils.lookup_icon({icon = 'utilities-terminal'}) },
    { "tmux",    terminalx .. " -e tmux", freedesktop.utils.lookup_icon({icon = 'utilities-terminal'}) },
}

menu_items = freedesktop.menu.new()
table.insert(menu_items, { "Awesome",  myawesomemenu, beautiful.icons_awesome })
table.insert(menu_items, { "Utileria",  utilmenu, beautiful.icons_awesome })
table.insert(menu_items, { "Pcmanfm",      "pcmanfm",          freedesktop.utils.lookup_icon({icon = 'pcmanfm'}) })
table.insert(menu_items, { "Thunar",      "thunar",          freedesktop.utils.lookup_icon({icon = 'Thunar'})})
table.insert(menu_items, { "open terminal", terminal, freedesktop.utils.lookup_icon({icon = 'lxterminal'}) })
table.insert(menu_items, { "Salir", "oblogout", freedesktop.utils.lookup_icon({ icon = 'gtk-quit' })  })

mymainmenu = awful.menu({ items = menu_items, theme = { width = 150 } })
mylauncher = awful.widget.launcher({ image = beautiful.icons_arch, menu = mymainmenu })

mytuxmenu = awful.menu({ items = {
    { "gnome mixer",        "gnome-alsamixer" },
    { "Lxrandr",            "lxrandr" },
    { "Surf", "surf" },
    { "Finalterm", "finalterm" } ,
  }, theme = { width = 150} 
})
--mytuxmenu = awful.menu({  } })
mytuxlaunch = awful.widget.launcher({ image = beautiful.icons_tux, menu = mytuxmenu })
-- }}}

-- {{{ Wibox
spacer = wibox.widget.textbox(" ")
separ = wibox.widget.textbox('<span color="' .. "#26CA34" .. '"> │</span>')
markup      = lain.util.markup

-- Crear un textclock widgetclockicon = wibox.widget.imagebox(beautiful.icons_clock)
clockicon = wibox.widget.imagebox(beautiful.icons_clock)
mytextclock = awful.widget.textclock(markup("#355AAF", "%A %d %B ") .. markup("#26CA34", "|") .. markup("#de5e1e", " %H:%M "))
lain.widgets.calendar:attach(mytextclock, { font_size = 10 })
-- cpu
cpu = wibox.widget.textbox()
vicious.register(cpu, vicious.widgets.cpu, '<span color="' .. "#e33a6e" .. '">$1%</span>', 2)--theme.fg_normal
cpuicon = wibox.widget.imagebox(beautiful.icons_cpu)
--- ram
memicon = wibox.widget.imagebox(beautiful.icons_mem)
mem = wibox.widget.textbox()
vicious.register(mem, vicious.widgets.mem, '<span color="' .. "#e0da37" .. '">$1% ($2MB)</span>', 5)
-- tempratura
tempicon = wibox.widget.imagebox(beautiful.icons_temp)
temp  = wibox.widget.textbox()
vicious.register(temp, vicious.widgets.thermal, '<span color="' .. "#f1af5f" .. '">$1°C  </span>', 30, { "coretemp.0", "core"})
-- red
netdownicon = wibox.widget.imagebox(beautiful.icons_netdown)
netdowninfo = wibox.widget.textbox()
netupicon = wibox.widget.imagebox(beautiful.icons_netup)
netupinfo = lain.widgets.net({
    settings = function()
        widget:set_markup(markup("#e54c62", net_now.sent .. " "))
        netdowninfo:set_markup(markup("#87af5f", net_now.received .. " "))
    end
})
-- ALSA volumen
volicon = wibox.widget.imagebox(beautiful.icons_vol)
vol = lain.widgets.alsa({
    settings = function()
        if volume_now.status == "off" then
            level = markup("#FF0000", volume_now.level .. " Mute")
        else
            level = volume_now.level .. "%"
        end
        widget:set_markup(markup("#F85EAC", "Vol: ") .. level)
    end
})
-- control de volumen con el mause sobre widget ALSA  
-- LeftClick=1 RightClick=3 ScrollUp=4 ScrollDown=5
vol:buttons(awful.util.table.join(
    awful.button({}, 1, function ()
        awful.util.spawn(awful.util.getdir("config") .. "/scripts/volume.sh mute")
        vol.update()
    end),
    awful.button({}, 3, function ()
        awful.util.spawn(terminal .. " -e alsamixer")
        vol.update()
    end),
    awful.button({}, 4, function ()
        awful.util.spawn(awful.util.getdir("config") .. "/scripts/volume.sh up")
        vol.update()
    end),
    awful.button({}, 5, function ()
        awful.util.spawn(awful.util.getdir("config") .. "/scripts/volume.sh down")
        vol.update()
    end)
))


baticon = wibox.widget.imagebox()
bat = lain.widgets.bat({
    battery = "BAT1", -- especificar bateria en  /sys/class/power_supply/
    settings = function()
        if bat_now.perc == "N/A" then
          widget:set_markup(" AC ")
            --perc = "AC"
          baticon:set_image(beautiful.icons_ac)
          return
          elseif tonumber(bat_now.perc) <= 10 then
          perc = markup("#FF0000", bat_now.perc .. "%")
            baticon:set_image(beautiful.icons_battery1)
            naughty.notify({ title    = "Bateria baja conecte el cargador"
               , timeout  = 5
               , position = "top_right"
               , fg       = "#FFFFFF"
               , bg       = beautiful.bg_focus
                          })
          elseif tonumber(bat_now.perc) <= 25 then
            baticon:set_image(beautiful.icons_battery2)
            perc = markup("#FF4200", bat_now.perc .. "%")
          elseif tonumber(bat_now.perc) <= 50 then
            baticon:set_image(beautiful.icons_battery3)
            perc = markup("#FF8A00", bat_now.perc .. "%")
          elseif tonumber(bat_now.perc) <= 75 then
            baticon:set_image(beautiful.icons_battery4)
            perc = markup("#FFF900", bat_now.perc .. "%")
          elseif tonumber(bat_now.perc) <= 90 then
            baticon:set_image(beautiful.icons_battery5)
            perc = markup("#A7FF00", bat_now.perc .. "%")
          else
            perc = bat_now.perc .. "%"
        end
        widget:set_markup(markup("#B757DD", " Bat: ") .. perc)
    end
})

-- clima
weathericon = wibox.widget.imagebox(beautiful.icons_weather)
yawn = lain.widgets.yawn(349871, {
    settings = function()
        widget:set_markup(markup("#eca4c4", forecast:lower() .. " @ " .. units .. "°C "))
    end
})
--
-- / fs
fsicon = wibox.widget.imagebox(beautiful.icons_fs)
fs = lain.widgets.fs({
    settings  = function()
       widget:set_markup(markup("#80d9d8", fs_now.used .. "% "))
    end
})

-- MPD hol0
mpdicon = wibox.widget.imagebox()
mpdicon:set_image()
prev_icon = wibox.widget.imagebox()
prev_icon:set_image(beautiful.icons_prev)
next_icon = wibox.widget.imagebox()
next_icon:set_image(beautiful.icons_nex)
stop_icon = wibox.widget.imagebox()
stop_icon:set_image(beautiful.icons_stop)
play_pause_icon = wibox.widget.imagebox()
play_pause_icon:set_image(beautiful.icons_play)

mpdwidgetbg = lain.widgets.mpd({
    settings = function()
        if mpd_now.state == "play" then
            title = mpd_now.title
            artist  = " - " .. mpd_now.artist 
            mpdicon:set_image(beautiful.icons_note_on)
        elseif mpd_now.state == "pause" then
            title = "MPD " 
            artist  = "PAUSED" 
            mpdicon:set_image(beautiful.icons_pause)
        else
            title  = ""
            artist = ""
            mpdicon:set_image(beautiful.icons_note)
        end

        widget:set_markup( markup("#00E1C6", title) .. artist)
    end
})
musicplr   = terminal .. " -e ncmpcpp "
mpdwidget = wibox.widget.background()
mpdwidget:set_widget(mpdwidgetbg)
mpdwidget:buttons(awful.util.table.join(awful.button({ }, 1,
    function () awful.util.spawn_with_shell(terminal .. " -e ncmpc") end)))

mpdicon:buttons(awful.util.table.join(awful.button({}, 1,
    function () awful.util.spawn_with_shell(terminal .. " -e ncmpcpp")
                awful.util.spawn_with_shell("mpd") end)))

prev_icon:buttons(awful.util.table.join(awful.button({}, 1,
    function ()
        awful.util.spawn_with_shell("mpc prev || ncmpcpp prev || ncmpc prev || pms prev || cmus-remote -r || mocp -r")
        mpdwidgetbg.update()
    end)))
stop_icon:buttons(awful.util.table.join(awful.button({}, 1,
    function ()
        awful.util.spawn_with_shell("mpc stop || ncmpcpp stop || ncmpc stop || pms stop || cmus-remote -s || mocp -s")
         mpdwidgetbg.update()
     end)))
play_pause_icon:buttons(awful.util.table.join(awful.button({}, 1,
    function ()
       awful.util.spawn_with_shell("mpc toggle || ncmpcpp toggle || ncmpc toggle || pms toggle || cmus-remote -u || mocp -G")
        mpdwidgetbg.update()
    end)))
next_icon:buttons(awful.util.table.join(awful.button({}, 1,
    function ()
        awful.util.spawn_with_shell("mpc next || ncmpcpp next || ncmpc next || pms next || cmus-remote -n || mocp -f")
         mpdwidgetbg.update()
    end)))

-- Crear un WiBox para cada pantalla y agregarlo
mywibox = {}
mydownwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Crear un promptbox para cada pantalla
    mypromptbox[s] = awful.widget.prompt()
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
         -- Crear un taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Crear un tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Crea el wibox superior
    mywibox[s] = awful.wibox({ position = "top", height = "18", screen = s, border_width = 2 })
   
    -- Widgets que se alinean a la izquierda
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(spacer)
    left_layout:add(mytaglist[s])
    left_layout:add(separ)
  
    -- Widgets que se alinean a la derecha
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(separ)
    right_layout:add(volicon)
    right_layout:add(vol)
    right_layout:add(separ)
    right_layout:add(spacer)
    right_layout:add(baticon)
    right_layout:add(bat)
    right_layout:add(separ)
    right_layout:add(clockicon)
    right_layout:add(mytextclock)

    -- ahora todo juntos con el tasklist al medio
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)
    mywibox[s]:set_widget(layout)

-- Crea el wibox inferior
    mydownwibox[s] = awful.wibox({ position = "bottom", screen = s, border_width = 2, height = 20 })
    mytextbox = wibox.widget.textbox (" Goshy")
               
    -- Widgets que están alineados en la parte inferior izquierda
    left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylayoutbox[s])
    left_layout:add(separ)
    left_layout:add(spacer)
    left_layout:add(mypromptbox[s])
    left_layout:add(separ) 
    left_layout:add(mytuxlaunch)
    left_layout:add(mytextbox)
    left_layout:add(separ) 
    left_layout:add(prev_icon)
    left_layout:add(stop_icon)
    left_layout:add(play_pause_icon)
    left_layout:add(next_icon)
    left_layout:add(mpdicon)
    left_layout:add(spacer)
    left_layout:add(mpdwidget)

    -- Widgets que están alineados con la parte inferior derecha
    right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(separ)
    right_layout:add(spacer)
    right_layout:add(wibox.widget.systray())
    right_layout:add(separ)
    right_layout:add(netdownicon)
    right_layout:add(netdowninfo)
    right_layout:add(netupicon)
    right_layout:add(netupinfo)
    right_layout:add(separ)
    right_layout:add(tempicon)
    right_layout:add(temp)
    right_layout:add(separ)
    right_layout:add(cpuicon)
    right_layout:add(cpu)
    right_layout:add(separ)
    right_layout:add(memicon)
    right_layout:add(mem)
    right_layout:add(separ)
    right_layout:add(fsicon)
    right_layout:add(fs)
    right_layout:add(separ)
    right_layout:add(weathericon)
    right_layout:add(yawn.widget)
    right_layout:add(separ)
    
    -- ahora todo juntos con el tasklist al medio
    bottom_layout = wibox.layout.align.horizontal()
    bottom_layout:set_left(left_layout)
    bottom_layout:set_right(right_layout)
    mydownwibox[s]:set_widget(bottom_layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ altkey }, "Left",  function () lain.util.tag_view_nonempty(-1) end),
    awful.key({ altkey }, "Right",  function () lain.util.tag_view_nonempty(1) end),
   
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),
    awful.key({ modkey            }, "b",       function ()
          mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
          mydownwibox[mouse.screen].visible = not mydownwibox[mouse.screen].visible
                end),
    -- Layout manipulacion
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard de programas
    awful.key({ modkey,           }, "Return", function () awful.util.spawn_with_shell(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
--    awful.key({ modkey, "Shift"   }, "q", awesome.quit), -- Default M-S-q command, oblogout lets you choose what to do
    awful.key({ modkey, "Shift"   }, "q", function () awful.util.spawn_with_shell("oblogout") end),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },   "r",     function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey },   "x",     function () awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget, awful.util.eval, nil, awful.util.getdir("cache") .. "/history_eval") end),

    -- Menubar
   --awful.key({ modkey }, "p", function() menubar.show() end) -- Default M-p command, dmenu is a better/faster alternative
    awful.key({ modkey }, "p", function () awful.util.spawn_with_shell("dmenu_run -h '18' -i -nb '" .. beautiful.bg_normal .. "' -nf '" .. beautiful.fg_normal .. "' -sb '" .. beautiful.bg_focus .. "' -sf '" .. beautiful.fg_focus .. "' -fn 'Terminus:size=9'") end),
  
    -- Switch to specific layout
    awful.key({ modkey, "Control" }, "Down",  function () awful.client.moveresize(  0,  20,   0,   0) end),
    awful.key({ modkey, "Control" }, "Up",    function () awful.client.moveresize(  0, -20,   0,   0) end),
    awful.key({ modkey, "Control" }, "Left",  function () awful.client.moveresize(-20,   0,   0,   0) end),
    awful.key({ modkey, "Control" }, "Right", function () awful.client.moveresize( 20,   0,   0,   0) end),
    awful.key({ modkey, "Control" }, "Next",  function () awful.client.moveresize( 20,  20, -40, -40) end),
    awful.key({ modkey, "Control" }, "Prior", function () awful.client.moveresize(-20, -20,  40,  40) end),
    awful.key({ modkey, "Control" }, "f", function () awful.layout.set(awful.layout.suit.floating) end),
    awful.key({ modkey, "Control" }, "t", function () awful.layout.set(awful.layout.suit.tile) end),
    awful.key({ modkey, "Control" }, "b", function () awful.layout.set(awful.layout.suit.tile.bottom) end),
    awful.key({ modkey, "Control" }, "s", function () awful.layout.set(awful.layout.suit.fair) end),
    awful.key({ modkey, "Control" }, "m", function () awful.layout.set(awful.layout.suit.max) end),

    -- Volumen control (Script which uses 'volnoti' as notification)
    awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn(awful.util.getdir("config") .. "/scripts/volume.sh up") vol.update() end),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn(awful.util.getdir("config") .. "/scripts/volume.sh down") vol.update() end),
    awful.key({ }, "XF86AudioMute",        function () awful.util.spawn(awful.util.getdir("config") .. "/scripts/volume.sh mute") vol.update() end),

     --awful.key({altkey }, "XF86AudioLowerVolume",   function () awful.util.spawn_with_shell("cmus-remote -v -3% && mocp -v -3%")               end),
    --awful.key({altkey }, "XF86AudioRaiseVolume",   function () awful.util.spawn_with_shell("cmus-remote -v +3% && mcop -v +3%&")              end),
    awful.key({altkey }, "F7",   function () awful.util.spawn_with_shell("cmus-remote -v -3% && mocp -v -3%")   end),
    awful.key({altkey }, "F8",   function () awful.util.spawn_with_shell("cmus-remote -v +3% && mcop -v +3%&")  end),
    awful.key({altkey }, "F10",          function () awful.util.spawn_with_shell("mocp -U") end),             
    awful.key({       }, "XF86AudioPrev",          function () awful.util.spawn_with_shell("cmus-remote -r || mocp -r || mpc prev || ncmpcpp prev || ncmpc prev || pms prev") end),
    awful.key({       }, "XF86AudioPlay",          function () awful.util.spawn_with_shell("cmus-remote -u || mocp -G || mpc toggle || ncmpcpp toggle || ncmpc toggle || pms toggle") end),
    awful.key({       }, "XF86AudioNext",          function () awful.util.spawn_with_shell("cmus-remote -n || mocp -f || mpc next || ncmpcpp next || ncmpc next || pms next") end),
    awful.key({altkey, "Control" }, "Down",       function () awful.util.spawn_with_shell("mpc stop || ncmpcpp stop || ncmpc stop || pms stop") mpdwidget.update() end),

    -- Brightness control (Script which uses 'volnoti' as notification) SYNTAX: up/down | percentage
    awful.key({ }, "XF86MonBrightnessUp",   function () awful.util.spawn_with_shell(awful.util.getdir("config") .. "/scripts/brightness.sh up") end),
    awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn_with_shell(awful.util.getdir("config") .. "/scripts/brightness.sh down") end),

    -- Screen lock
    awful.key({ modkey, "Shift" }, "l", function () awful.util.spawn_with_shell("dm-tool lock") end),


    -- Screenshot
    awful.key({ }, "Print", function () awful.util.spawn_with_shell("scrot -e 'mv $f ~/Pictures/'") end),
    awful.key({ "Shift" }, "Print", function () awful.util.spawn_with_shell("scrot -s -e 'mv $f ~/Pictures/'") end),

    --scratch
    awful.key({ modkey }, "i", function () scratch("lxterminal") end),
        
    -- Applications
    awful.key({ modkey }, "d", function () awful.util.spawn_with_shell("dwb") end),
    awful.key({ modkey }, "t", function () awful.util.spawn_with_shell("pcmanfm") end),
      --awful.key({ modkey }, "q",     function () awful.util.spawn_with_shell(" ")        end),
    awful.key({ modkey }, "e",    function () awful.util.spawn_with_shell("evolution")        end),
    awful.key({ modkey }, "a",    function () awful.util.spawn_with_shell("vlc --extraintf=luahttp --fullscreen  --qt-start-minimized")         end),
  --awful.key({ modkey }, "s",    function () awful.util.spawn_with_shell(" ")        end),
 --awful.key({ modkey }, "y",    function () awful.util.spawn_with_shell( cfg_dir .. "/scripts/xephyr.sh") end),
    awful.key({        }, "Print",  function () awful.util.spawn_with_shell("gnome-screenshot") end),
    awful.key({ modkey }, "F6",   function () awful.util.spawn("killall ffmpeg || killall mpd || killall ncmpcpp || killall mocp")        end),
    awful.key({ modkey }, "F11",  function ()
                    awful.util.spawn_with_shell("rm " ..  "~/screencast.mkv")
                    awful.util.spawn("ffmpeg -f x11grab -s " .. "1366 x 768" .. " -r 25 -i :0.0 -sameq " .. "~/screencast.mkv") end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = true               end),
    awful.key({ modkey,           }, "m",      function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.movetotag(tag)
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.toggletag(tag)
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Reglas
awful.rules.rules = {
    -- Todos los clientes que coincida con esta regla.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     size_hints_honor = false, -- Eliminar las brechas entre terminales
                     callback = awful.client.setslave } }, -- Abrir nuevos clientes como esclavo en lugar de maestro
    { rule_any = { class = { "pinentry", "Oblogout", "Galculator" },
                    name = { "Event Tester"},
                   instance = { "plugin-container", "exe" } },
                   properties = { floating = true } },
   { rule_any = { class = { "evince" }}, properties = { floating = true } },
   { rule_any = { class = { "flash-plugin", "libflashplayer.so",}}, properties = { floating = true } },
   --{ rule_any = { class = { "ranger", "mocp" }}, properties = { tag = tags[1][2]} },
  }
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Disable startup-notification globally
local oldspawn = awful.util.spawn
awful.util.spawn = function (s)
    oldspawn(s, false)
end
---- }}}

-- {{{ Aplicaciones de arranque Auto-inicio, sólo una vez
function autostart(cmd, delay)
    delay = delay or 0
    awful.util.spawn_with_shell("pgrep -u $USER -x -f '" .. cmd .. "' || ( sleep " .. delay .. " && " .. cmd .. " )")
end

--  Aplicaciones de inicio automático. El argumento adicional es opcional, 
-- significa el período de retardo de un comando antes de iniciarlo (en segundos).
--autostart("compton -b", 0)
autostart("compton --config ~/.config/compton.conf --backend glx --vsync opengl-swc --shadow-exclude 'n:a:Conky' -b &", 0)
autostart("volnoti", 1)
autostart("conky", 2)
--autostart("sh ~/.config/awesome/themes/pabucolor/wallpaper2.sh", 3)
autostart("volumeicon", 2)
--autostart("nm-applet", 2)
autostart("xbindkys", 2)
-- }}}

-- {{{ Run .desktop files with dex
-- Because 'dex' is not an application, autostart("dex -ae Awesome") will always
-- execute every entry (which is unwanted).
local dex_output = io.popen("dex -ade Awesome")
for cmd in dex_output:lines() do
    autostart(cmd:gsub("Executing command: ", ""), 4)
end
dex_output:close()
-- }}}
