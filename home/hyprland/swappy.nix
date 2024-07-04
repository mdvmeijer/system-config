{ config, pkgs, ... }:

{
  home.packages = [ pkgs.swappy ];

  # Default config taken from the readme on swappy's repo at July 4th, 2024
  # Only change is save_dir
  # See https://github.com/jtheoof/swappy
  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir=$HOME/08-screenshots
    save_filename_format=swappy-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    text_font=sans-serif
    paint_mode=brush
    early_exit=false
    fill_shape=false
  '';
}
