{ config, pkgs, ... }:

{
  # Settings and style taken from frisodubach's config
  programs.wofi = {
    enable = true;
    settings = {
      width=500;
      height=210;
      location="center";
      show="drun";
      prompt="Search...";
      filter_rate=100;
      allow_markup=true;
      no_actions=true;
      halign="fill";
      orientation="vertical";
      content_halign="fill";
      insensitive=true;
      allow_images=false;
      image_size=16;
      gtk_dark=true;
      always_parse_args=true;
      show_all=false;
      print_command=true;
      layer="overlay";
      hide_scroll=true;
      hide_search=false;
    };
    style = ''
      window {
        margin: 0px;
        border: 2px solid #282828;
        border-radius: 10px;
        background-color: #32302f;
        font-family: Jetbrains Mono;
        font-size: 14px;
      }

      #input {
        margin: 5px;
        border: 1px solid #282828;
        border-radius: 10px;
        color: #ebdbb2;
        background-color: #282828;
      }

      #input image {
        color: #ebdbb2;
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: #32302f;
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: #32302f;
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: #ebdbb2;
      }

      #entry:selected {
        background-color: #83a598;
        font-weight: normal;
        border-radius: 10px;
      }

      #text:selected {
        background-color: #83a598;
        color: #32302f;
        font-weight: normal;
      }
    '';
  };
}
