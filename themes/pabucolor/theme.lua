theme                 = {}
--
theme_dir         = os.getenv("HOME") .. "/.config/awesome/themes/pabucolor"
theme.wallpaper       = theme_dir .. "/wall.png"
--
theme.font            = "Terminus 7"
--
theme.bg_normal       = "#000000AA"
theme.bg_focus        = "#00000000"
theme.bg_urgent       = "#000000"
--
theme.fg_normal       = "#BBBBBB"
theme.fg_focus        = "#5629E2"
theme.fg_urgent       = "#E11E34"
theme.fg_minimize     = "#000000"
--
--theme.border_width    = "1.4"
--theme.border_normal   = "#000000"
--theme.border_focus    = "#6029E2"
--theme.border_marked   = "#1c2022"

theme.border_width    = "4"
theme.border_normal   = "#0000000"
theme.border_focus    = "#0000000"
theme.border_marked   = "#000000000"
-- color menu
theme.menu_width      	 = "110"
theme.menu_border_width  = "4"
theme.menu_fg_normal     = "#aaaaaa"
theme.menu_fg_focus      = "#ff8c00"
theme.menu_bg_normal  = "#000000"
theme.menu_bg_focus   = "#000000"
-- iconos
theme.icons_awesome 	 = theme_dir .. "/awesome.png"
theme.icons_arch 		 = theme_dir .. "/arch.png"
theme.icons_tux 		 = theme_dir .. "/tux.png"
--folder icons
theme.icons_ac			 = theme_dir .. "/icons/ac.png"
theme.icons_battery1	 = theme_dir .. "/icons/battery1.png"
theme.icons_battery2	 = theme_dir .. "/icons/battery2.png"
theme.icons_battery3	 = theme_dir .. "/icons/battery3.png"
theme.icons_battery4	 = theme_dir .. "/icons/battery4.png"
theme.icons_battery5   	 = theme_dir .. "/icons/battery5.png"
theme.icons_clock        = theme_dir .. "/icons/clock.png"
theme.icons_cpu          = theme_dir .. "/icons/cpu.png"
theme.icons_fs           = theme_dir .. "/icons/fs.png"
theme.icons_mail         = theme_dir .. "/icons/mail.png"
theme.icons_mem          = theme_dir .. "/icons/mem.png"
theme.icons_netdown      = theme_dir .. "/icons/net_down.png"
theme.icons_netup        = theme_dir .. "/icons/net_up.png"
theme.icons_nex          = theme_dir .. "/icons/next.png"
theme.icons_note         = theme_dir .. "/icons/note.png"
theme.icons_note_on      = theme_dir .. "/icons/note_on.png"
theme.icons_pause   	 = theme_dir .. "/icons/pause.png"
theme.icons_play       	 = theme_dir .. "/icons/play.png"
theme.icons_prev         = theme_dir .. "/icons/prev.png"
theme.icons_stop         = theme_dir .. "/icons/stop.png"

theme.taglist_squares_sel     = theme_dir .. "/icons/square_a.png"
theme.taglist_squares_unsel   = theme_dir .. "/icons/square_b.png"

theme.menu_submenu_icon  = theme_dir .. "/icons/submenu.png"
theme.icons_temp         = theme_dir .. "/icons/temp.png"
theme.icons_vol_mute 	 = theme_dir .. "/icons/vol_mute.png"
theme.icons_vol 		 = theme_dir .. "/icons/volume-high.png"
theme.icons_weather      = theme_dir .. "/icons/weather.png"
--layout2
theme.layout_uselessdwindle         = theme_dir .. "/layout/dwindle.png"
theme.layout_uselessfair            = theme_dir .. "/layout/fairv.png"
theme.layout_floating               = theme_dir .. "/layout/floating.png"
theme.layout_magnifier              = theme_dir .. "/layout/magnifier.png"
theme.layout_tile                   = theme_dir .. "/layout/tile.png"
theme.layout_tilebottom             = theme_dir .. "/layout/tilebottom.png"
theme.layout_tileleft               = theme_dir .. "/layout/tileleft.png"
theme.layout_tiletop                = theme_dir .. "/layout/tiletop.png"
theme.layout_centerfair             = theme_dir .. "/layout/centerfair.png"
theme.layout_termfair               = theme_dir .. "/layout/termfair.png"
theme.layout_centerwork             = theme_dir .. "/layout/centerwork.png"

---theme.layout_tilegaps               = theme_dir .. "/layout/tilegaps.png"
--theme.icon_theme = nil
theme.useless_gap_width             = 10
theme.textbox_widget_margin_top     = 1
theme.awful_widget_height           = 14
theme.awful_widget_margin_top       = 2
return theme
