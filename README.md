##Pabu COlor:

La versión trabaja con impresionante WM 3.5. en manjaro 8.10 awesome wm respin
manjaro 8.10 awesome wm respin tiene todo instalado y configurado con programa minimalista
por lo tanto es probable que solo algunos programas funcionen. 

<img src="https://raw.githubusercontent.com/gonku/awesome-wm-pabucolor/master/screenshot/Men%C3%BA_003.png" width="676" height="424" alt="Screenshot">
<img src="https://raw.githubusercontent.com/gonku/awesome-wm-pabucolor/master/screenshot/Men%C3%BA_004.png" width="476" height="224" alt="Screenshot">

###Version: v2.0

Programas a tener en consideración

*  mate-terminal
*  lxterminal
*  sublime text 2
*  vim
*  oblogout
*  mpd
*  ncmpcpp
*  compton
*  conky
*  feh
*  oblogout
*  freedesktop


####Installation


    cd $HOME/.config/awesome/
    git clone https://github.com/gonku/awesome-wm-pabucolor.git

####Use:
la secion de codigo puede ser remplazada por script a wallpaper2.sh

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
     
En el script wallpaper2.sh debe ser modificada el directorio de imagen a combeniencia ya que esta definido en
wallpaper2.sh

Los directorio lain y gears estan un poco modificados, ya que su directorios estan apra configuracion idioma ingles, lo cual fue nesesario cambiar a directorio con nombre español,para el caso de la notificacion de mpd


Author:
-------

AyumiMAy

Contributors
-------


