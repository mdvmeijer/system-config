{ pkgs, config, inputs, pkgs-unstable, ... }:

{
  imports =
    [
      ./waybar.nix
      inputs.hyprland.nixosModules.default
    ];

  # Module from inputs.hyprland substitutes nixpkgs `programs.hyprland` with its own,
  # allowing for pulling the latest changes once they are available.
  # Besides installing the Hyprland package, this module sets some system-wide configuration
  # (e.g. polkit, xdg-desktop-portal-hyprland)
  programs.hyprland.enable = true;

  # Hyprland config is handled with home-manager
  home-manager.users.meeri = { pkgs, ... }: {
    home.stateVersion = "22.11";

    imports = [
      inputs.hyprland.homeManagerModules.default
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;  # Use system-wide package instead

      extraConfig = ''
        ########################################################################################
        AUTOGENERATED HYPR CONFIG.
        PLEASE USE THE CONFIG PROVIDED IN THE GIT REPO /examples/hypr.conf AND EDIT IT,
        OR EDIT THIS ONE ACCORDING TO THE WIKI INSTRUCTIONS.
        ########################################################################################
        
        #
        # Please note not all available settings / options are set here.
        # For a full list, see the wiki
        #
        
        autogenerated = 0 # remove this line to remove the warning
        
        source=~/.config/hypr/macchiato.conf
        
        # See https://wiki.hyprland.org/Configuring/Monitors/
        monitor=,preferred,auto,auto
        monitor=eDP-1, 2256x1504, 0x1080, 1.25
        monitor=DP-4, 1920x1080, 0x0, 1.00
        
        # See https://wiki.hyprland.org/Configuring/Keywords/ for more
        
        # Execute your favorite apps at launch
        # exec-once = waybar & hyprpaper & firefox
        exec-once = waybar & dunst
        exec-once = hyprpaper
        
        # exec-once = [workspace 1 silent] firefox
        # exec-once = [workspace 7 silent] signal-desktop  TODO: Enable later
        # exec-once = [workspace 8 silent] obsidian
        # exec-once = [workspace 9 silent] alacritty
        
        # windowrule = workspace 9 silent,^(alacritty)$
        
        # Spotify ignores window rules and stuff
        # exec-once = [workspace 6 silent;fullscreen] spotify
        # windowrule = workspace 6 silent,^(spotify)$
        
        windowrule = workspace 2 silent,^(code)$
        
        # For cliphist
        exec-once = wl-paste --type text --watch cliphist store #Stores only text data
        exec-once = wl-paste --type image --watch cliphist store #Stores only image data
        
        # Ensure QT apps use theme selected in qt5ct
        env = QT_QPA_PLATFORMTHEME,qt5ct
        
        # env = XDG_CURRENT_DESKTOP,Hyprland
        # env = XDG_SESSION_TYPE,wayland
        # env = XDG_SESSION_DESKTOP,Hyprland
        # 
        # env = GDK_BACKEND,wayland,x11
        # env = QT_QPA_PLATFORM,wayland;xcb
        # env = SDL_VIDEODRIVER,wayland
        # env = CLUTTER_BACKEND,wayland
        
        # Source a file (multi-file configs)
        # source = ~/.config/hypr/myColors.conf
        
        # Some default env vars.
        # env = XCURSOR_SIZE,24
        # exec-once=hyprctl setcursor Catppuccin-Macchiato-Rosewater-Cursors 16 
        
        # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
        input {
            kb_layout = us
            kb_variant =
            kb_model =
            kb_options = ctrl:nocaps
            kb_rules =
        
            follow_mouse = 1
        
            touchpad {
                natural_scroll = yes
            }
        
            sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        
            repeat_rate=30
            repeat_delay=250
        }
        
        general {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
        
            gaps_in = 3
            gaps_out = 8
            border_size = 3
            # col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
            # col.active_border = rgba(710193cc)
            col.active_border = $surface2
            col.inactive_border = rgba(000000aa)
        
            layout = dwindle
        }
        
        decoration {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
        
            rounding = 0
            blur = no
            blur_size = 3
            blur_passes = 1
            blur_new_optimizations = on
        
            drop_shadow = no
            shadow_range = 4
            shadow_render_power = 3
            col.shadow = rgba(1a1a1aee)
        }
        
        animations {
            enabled = yes
        
            # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        
            bezier = myBezier, 0.05, 0.9, 0.1, 1.05
        
            animation = windows, 1, 7, myBezier
            animation = windowsOut, 1, 7, default, popin 80%
            animation = border, 1, 10, default
            animation = borderangle, 1, 8, default
            animation = fade, 1, 7, default
            animation = workspaces, 1, 6, default
        }
        
        dwindle {
            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = yes # you probably want this
        }
        
        master {
            # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            new_is_master = true
        }
        
        gestures {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
            workspace_swipe = off
        }
        
        # Example per-device config
        # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
        device:epic-mouse-v1 {
            sensitivity = -0.5
        }
        
        # Example windowrule v1
        # windowrule = float, ^(kitty)$
        # Example windowrule v2
        # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
        # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
        
        
        # See https://wiki.hyprland.org/Configuring/Keywords/ for more
        $mainMod = SUPER
        
        # Custom stuff
        
        $swaylockCmd = swaylock --clock --indicator --screenshots --effect-scale 0.4 --effect-vignette 0.2:0.5 --effect-blur 4x2 --datestr "%a %e.%m.%Y" --timestr "%k:%M"
        
        # On lid close, swaylock and suspend
        # bindl = , switch:on:Lid Switch, exec, $swaylockCmd && systemctl suspend  # swaylockCmd is run synchronously
        bindl = , switch:on:Lid Switch, exec, $swaylockCmd
        
        # Control screen brightness with hardware brightness keys
        binde = ,XF86MonbrightnessDown, exec, brightnessctl set 5%-
        binde = ,XF86MonbrightnessUp, exec, brightnessctl set +5%
        
        # Control audio volume with hardware volume keys
        bind = ,XF86AudioMute, exec, pamixer -t
        binde = ,XF86AudioLowerVolume, exec, pamixer -d 5
        binde = ,XF86AudioRaiseVolume, exec, pamixer -i 5
        
        # Control audio playback with hardware playback keys
        bind=, XF86AudioPlay, exec, playerctl play-pause
        bind=, XF86AudioPause, exec, playerctl play-pause
        bind=, XF86AudioNext, exec, playerctl next
        bind=, XF86AudioPrev, exec, playerctl previous
        
        bind=, XF86PowerOff, exec, systemctl suspend
        bind = $mainMod ALT, L, exec, $swaylockCmd
        
        bind = $mainMod CTRL, G, togglegroup
        bind = $mainMod, G, changegroupactive, f
        bind = $mainMod SHIFT, G, changegroupactive, b
        bind = $mainMod ALT, G, moveoutofgroup
        
        # For cliphist
        bind = $mainMod, V, exec, cliphist list | wofi -dmenu | cliphist decode | wl-copy
        
        # Screenshots
        env = GRIM_DEFAULT_DIR=$HOME/Pictures/Screenshots
        bind = ,Print, exec, grim -g "$(slurp)" - | wl-copy -t image/png
        bind = SHIFT, Print, exec, grim -g "$(slurp)" - | swappy -f -
        
        # will switch to a submap called resize
        bind=ALT,R,submap,resize
        
        # will start a submap called "resize"
        submap=resize
        
        # sets repeatable binds for resizing the active window
        binde=,right,resizeactive,10 0
        binde=,left,resizeactive,-10 0
        binde=,up,resizeactive,0 -10
        binde=,down,resizeactive,0 10
        
        # use reset to go back to the global submap
        bind=,escape,submap,reset 
        
        # will reset the submap, meaning end the current one and return to the global one
        submap=reset
        
        bind = $mainMod, D, exec, alacritty
        bind = $mainMod,S,exec,pidof firefox && hyprctl dispatch focuswindow firefox || firefox
        # bind = $mainMod SHIFT,J,exec,pidof obsidian && hyprctl dispatch focuswindow obsidian || obsidian
        
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        bind = $mainMod, C, killactive, 
        bind = $mainMod CTRL, M, exit, 
        bind = $mainMod, E, exec, dolphin
        bind = $mainMod SHIFT, F, togglefloating, 
        bind = $mainMod, R, exec, wofi --show drun
        bind = $mainMod, P, pseudo, # dwindle
        bind = $mainMod, T, togglesplit, # dwindle
        
        bind = $mainMod, F, fullscreen, 1
        
        # Move focus with mainMod + arrow keys
        bind = $mainMod, left, movefocus, l
        bind = $mainMod, right, movefocus, r
        bind = $mainMod, up, movefocus, u
        bind = $mainMod, down, movefocus, d
        
        # Move focus with mainMod + hjkl
        bind = $mainMod, H, movefocus, l
        bind = $mainMod, L, movefocus, r
        bind = $mainMod, K, movefocus, u
        bind = $mainMod, J, movefocus, d
        
        # Move active window with mainMod + SHIFT + hjkl
        bind = $mainMod SHIFT, H, movewindow, l
        bind = $mainMod SHIFT, L, movewindow, r
        bind = $mainMod SHIFT, K, movewindow, u
        bind = $mainMod SHIFT, J, movewindow, d
        
        # Resize active window with mainMod + CTRL + hjkl
        binde = $mainMod CTRL, H, resizeactive, -20 0
        binde = $mainMod CTRL, L, resizeactive, 20 0
        binde = $mainMod CTRL, K, resizeactive, 0 -20
        binde = $mainMod CTRL, J, resizeactive, 0 20
        
        # Switch workspaces with mainMod + [0-9]
        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10
        
        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10
        
        # Scroll through existing workspaces with mainMod + scroll
        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1
        
        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    hyprpaper
    brightnessctl
    pamixer
    playerctl
    helvum
    dunst
    swaylock-effects
    pavucontrol
    wlr-randr
    xdg-utils

    # Clipboard manager
    cliphist
    wl-clipboard

    # Screenshot tools
    grim
    slurp
    swappy

    libsForQt5.qt5ct  # Setting QT themes
    glib  # Setting GTK themes

    dolphin
    libsForQt5.breeze-qt5
    papirus-icon-theme
  ];

  # Without this, swaylock will not recognize password
  security.pam.services.swaylock = {};

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
}
