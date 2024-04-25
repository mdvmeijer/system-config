{ config, pkgs, ... }:

{
  home.file.".config/hypr/hyprlock.conf".text = let
    wallpaper-laptop = ../hyprpaper/wallpapers/anime_skull.png;
    wallpaper-external = ../hyprpaper/wallpapers/sif.png;
  in
  ''
    general {
      hide_cursor = true
    }
    
    background {
        monitor = eDP-1
        path = ${wallpaper-laptop}
        color = rgba(25, 20, 20, 1.0)
    
        # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
        blur_passes = 1 # 0 disables blurring
        blur_size = 7
        noise = 0.0117
        contrast = 0.8916
        brightness = 0.8172
        vibrancy = 0.1696
        vibrancy_darkness = 0.0
    }
    
    background {
        monitor = DP-7
        path = ${wallpaper-external}
        color = rgba(25, 20, 20, 1.0)
    
        # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
        blur_passes = 1 # 0 disables blurring
        blur_size = 7
        noise = 0.0117
        contrast = 0.8916
        brightness = 0.8172
        vibrancy = 0.1696
        vibrancy_darkness = 0.0
    }

    background {
        monitor = HDMI-A-1
        path = ${wallpaper-external}
        color = rgba(25, 20, 20, 1.0)
    
        # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
        blur_passes = 1 # 0 disables blurring
        blur_size = 7
        noise = 0.0117
        contrast = 0.8916
        brightness = 0.8172
        vibrancy = 0.1696
        vibrancy_darkness = 0.0
    }

    input-field {
        monitor =
        size = 200, 50
        outline_thickness = 3
        dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = false
        dots_rounding = -1 # -1 default circle, -2 follow input-field rounding
        outer_color = rgb(151515)
        inner_color = rgb(200, 200, 200)
        font_color = rgb(10, 10, 10)
        fade_on_empty = true
        fade_timeout = 1000 # Milliseconds before fade_on_empty is triggered.
        placeholder_text = <i>Input Password...</i> # Text rendered in the input box when it's empty.
        hide_input = false
        rounding = -1 # -1 means complete rounding (circle/oval)
        check_color = rgb(204, 136, 34)
        fail_color = rgb(204, 34, 34) # if authentication failed, changes outer_color and fail message color
        fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i> # can be set to empty
        fail_transition = 300 # transition time in ms between normal outer_color and fail_color
        capslock_color = -1
        numlock_color = -1
        bothlock_color = -1 # when both locks are active. -1 means don't change outer color (same for above)
        invert_numlock = false # change color if numlock is off
        swap_font_color = false # see below
    
        position = 0, -20
        halign = center
        valign = center
    }

    label {
        monitor =
        text = $TIME
        text_align = center # center/right or any value for default left. multi-line text alignment inside label container
        color = rgba(200, 200, 200, 1.0)
        font_size = 50
        font_family = PT Serif
        rotate = 0 # degrees, counter-clockwise
    
        position = 0, 120
        halign = center
        valign = center
    }
  '';
}

