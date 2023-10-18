args@{ config, pkgs, lib, username, inputs, ... }:

with lib;
let
  cfg = config.meeriModules.hyprland;
in
{
  imports =
    [
      (import ./waybar/default.nix args)
      (import ./dunst.nix args)
      (import ./swaylock/default.nix args)
      (import ./hyprpaper/default.nix args)
    ];

  options.meeriModules.hyprland = {
    monitorConfig = mkOption {
      type = types.str;
    };
  };

  # Hyprland config is handled with home-manager
  config.home-manager.users.${username} = { pkgs, ... }: {
    imports = [
      inputs.hyprland.homeManagerModules.default
    ];

    # XWayland stuff
    home.packages = with pkgs.xorg; [
      xprop
      xhost
      xeyes  # To test for XWayland apps
      xlsclients  # To test for XWayland apps
    ];

    home.sessionVariables = {
      # Ensure QT apps use theme selected in qt5ct
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_QPA_PLATFORM = "wayland;xcb";
      
      #GDK_BACKEND = "wayland,x11";
      GDK_BACKEND = "wayland,x11";
      CLUTTER_BACKEND = "wayland";

      # Setting SDL_VIDEODRIVER to "wayland" prevents many Steam games from launching (as of 19-08-2023)
      # SDL_VIDEODRIVER = "wayland";
      SDL_VIDEODRIVER = "x11";
      # LIBGL_ALWAYS_SOFTWARE = "1";

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";

      GRIM_DEFAULT_DIR = "$HOME/80-tmp/02-screenshots";
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;  # Use system-wide package instead

      extraConfig = ''
        ${cfg.monitorConfig}

        # Default catch-all monitor config
        monitor=,preferred,auto,auto

        xwayland {
            force_zero_scaling = true
        }

        # Daemons for various desktop environment functions
        exec-once = waybar  # Status bar
        exec-once = dunst  # Notifications
        exec-once = hyprpaper  # Wallpaper
        exec-once = swayosd  # Volume & brightness indicator
        exec-once = udiskie  # USB automounter

        windowrule = workspace 2 silent,^(code)$

        # VS Code file and folder picker
        windowrule = float,title:^(Open File)$
        windowrule = float,title:^(Open Folder)$

        # Steam friends list
        windowrule = float,title:^(Friends List)$

        # For cliphist
        exec-once = wl-paste --type text --watch cliphist store #Stores only text data
        exec-once = wl-paste --type image --watch cliphist store #Stores only image data

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
        
            gaps_in = 0
            gaps_out = 0
            border_size = 3

            # For non-group windows (i.e. non-tabbed windows)
            # col.active_border = $surface2
            col.active_border = rgba(F9F5D788)
            col.inactive_border = rgba(000000aa)

            layout = dwindle
        }
        
        decoration {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
        
            rounding = 0
            blur {
                 enabled = no;
            }
        
            drop_shadow = no
        }
        
        animations {
            enabled = yes
        
            # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        
            bezier = myBezier, 0.05, 0.7, 0.1, 1.0
        
            animation = windows, 1, 4, myBezier
            animation = windowsOut, 1, 4, default, popin 80%
            animation = border, 1, 4, default
            animation = borderangle, 1, 8, default
            animation = fade, 1, 4, default
            animation = workspaces, 1, 3, default
        }

        group {
            # col.group_border_active = $surface2
            col.border_active = rgba(F9F5D788)
            col.border_inactive = rgba(000000aa)

            groupbar {
                font_size = 10
                render_titles = true
                gradients = false
            }
        }

        misc {
            enable_swallow = true
            swallow_regex = ^(Alacritty)$

            disable_hyprland_logo = true
        }
        
        dwindle {
            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = yes # you probably want this

            no_gaps_when_only = yes  # Remove border when just 1 window is present on a workspace
        }
        
        master {
            # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            new_is_master = true
        }
        
        gestures {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
            workspace_swipe = true
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
        
        $screenLockCmd = swaylock --clock --indicator --screenshots --effect-scale 0.4 --effect-vignette 0.2:0.5 --effect-blur 4x2 --datestr "%a %e.%m.%Y" --timestr "%k:%M"
        $suspendCmd = systemctl suspend
        $lockAndSuspendCmd = $screenLockCmd & sleep 1; $suspendCmd &
        
        # On lid close, lock screen and suspend
        # bindl = , switch:on:Lid Switch, exec, $lockAndSuspendCmd

        # Keybind to lock screen
        bind = $mainMod ALT, L, exec, $screenLockCmd

        # Keybind to lock screen and suspend
        bind = $mainMod ALT CTRL, L, exec, $lockAndSuspendCmd

        bind=, XF86PowerOff, exec, systemctl suspend

        # Yeet current workspace to primary or secondary monitor
        bind = $mainMod ALT, 1, movecurrentworkspacetomonitor, eDP-1
        bind = $mainMod ALT, 2, movecurrentworkspacetomonitor, DP-3

        # Go to previous workspace

        bind = $mainMod, n, workspace, previous

        # Special workspace -- scratchpad
        bind = $mainMod, S, togglespecialworkspace, scratchpad
        bind = $mainMod SHIFT, S, movetoworkspace, special:scratchpad

        # Special workspace -- hover terminal
        bind = $mainMod, A, togglespecialworkspace, hover
        bind = $mainMod SHIFT, A, exec, [workspace special:hover] alacritty
        exec-once = [workspace special:hover silent] alacritty

        # Special workspace -- kanban w/ taskell
        bind = $mainMod, T, togglespecialworkspace, kanban
        exec-once = [workspace special:kanban silent] alacritty -e taskell-manager
        
        # Special workspace -- music
        windowrule = workspace special:music silent, ^(rhythmbox)$
        bind = $mainMod, M, togglespecialworkspace, music
        bind = $mainMod SHIFT, M, exec, rhythmbox
        exec-once = rhythmbox
        
        # Special workspace -- slack
        windowrule = workspace special:slack, ^(Slack)$
        bind = $mainMod, Y, togglespecialworkspace, slack
        bind = $mainMod SHIFT, Y, exec, slack

        bind = $mainMod, period, exec, wl-copy bertbmyp@gmail.com | wl-paste --type text
        bind = $mainMod, comma, exec, wl-copy kabouter1234 | wl-paste --type text

        # Control screen brightness with hardware brightness keys
        # binde = ,XF86MonbrightnessDown, exec, swayosd --brightness lower
        # binde = ,XF86MonbrightnessUp, exec, swayosd --brightness raise

        binde = ,XF86MonbrightnessDown, exec, brightnessctl set 5%-
        binde = ,XF86MonbrightnessUp, exec, brightnessctl set +5%

        # Control audio volume with hardware volume keys
        bind = ,XF86AudioMute, exec, swayosd --output-volume mute-toggle
        binde = ,XF86AudioLowerVolume, exec, swayosd --output-volume lower
        binde = ,XF86AudioRaiseVolume, exec, swayosd --output-volume raise
        
        # Control audio playback with hardware playback keys
        bind=, XF86AudioPlay, exec, playerctl play-pause
        bind=, XF86AudioPause, exec, playerctl play-pause
        bind=, XF86AudioNext, exec, playerctl next
        bind=, XF86AudioPrev, exec, playerctl previous
        
        bind = $mainMod CTRL, G, togglegroup
        bind = $mainMod, G, changegroupactive, f
        bind = $mainMod SHIFT, G, changegroupactive, b
        bind = $mainMod ALT, G, moveoutofgroup
        
        bind = $mainMod CTRL SHIFT, H, moveintogroup, l
        bind = $mainMod CTRL SHIFT, L, moveintogroup, r
        bind = $mainMod CTRL SHIFT, K, moveintogroup, u
        bind = $mainMod CTRL SHIFT, J, moveintogroup, d

        # TODO: Add some way to control direction where window will be placed
        # bind = $mainMod CTRL SHIFT, H, moveoutofgroup
        # bind = $mainMod CTRL SHIFT, L, moveoutofgroup
        # bind = $mainMod CTRL SHIFT, K, moveoutofgroup
        # bind = $mainMod CTRL SHIFT, J, moveoutofgroup

        # For cliphist
        bind = $mainMod, V, exec, cliphist list | wofi -dmenu | cliphist decode | wl-copy
        
        # Screenshots
        bind = ,Print, exec, grim -g "$(slurp)" - | wl-copy -t image/png
        bind = SHIFT, Print, exec, grim -g "$(slurp)" - | swappy -f -
        

        # will switch to a submap called fzf-menus
        bind=$mainMod,E,submap,fzf-menus

        # will start a submap called "fzf-menus"
        submap=fzf-menus
        
        # Open select-power-profile wofi menu and exit submap
        bind=,p,exec,select-power-profile
        bind=,p,submap,reset

        # Open movie fzf menu and exit submap
        bind=,m,exec,~/projects/scripts/fzf/hyprland-movie-menu-scratchpad-wrapper.sh
        bind=,m,submap,reset

        # Open key-value store with 'set' argument and exit submap
        bind=,s,exec,wofi-key-value-store set
        bind=,s,submap,reset
        
        # Open key-value store with 'get' argument and exit submap
        bind=,g,exec,wofi-key-value-store get
        bind=,g,submap,reset

        # use reset to go back to the global submap
        bind=,escape,submap,reset 
        
        # will reset the submap, meaning end the current one and return to the global one
        submap=reset
        
        bind = $mainMod, D, exec, alacritty

        # If program is open, move focus to it; otherwise, launch program
        # bind = $mainMod,S,exec,pidof firefox && hyprctl dispatch focuswindow firefox || firefox
        # bind = $mainMod SHIFT,J,exec,pidof obsidian && hyprctl dispatch focuswindow obsidian || obsidian
        
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        bind = $mainMod, C, killactive, 
        bind = $mainMod CTRL, M, exit,

        # For use with emacs daemon
        # bind = $mainMod, Space, exec, emacsclient --create-frame

        bind = $mainMod, Space, exec, emacs

        # bind = $mainMod, O, exec, alacritty -e lf
        bind = $mainMod, O, exec, dolphin

        bind = $mainMod CTRL, F, togglefloating, 
        bind = $mainMod CTRL, S, togglesplit,
        bind = $mainMod CTRL, P, pseudo,

        bind = $mainMod, R, exec, wofi --show drun --matching=fuzzy
        
        bind = $mainMod, F, fullscreen, 1
        bind = $mainMod SHIFT, F, fullscreen, 0
        
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
}
