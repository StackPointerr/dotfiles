# programs.waybar = {
#   enable = true;
#   style = builtins.readFile ./waybar/style.css;
#   settings = {
#     mainBar = {
#       layer = "top";
#       margin-top = 5;
#       margin-bottom = 5;
#       modules-left = [ "custom/logo" ];
#       modules-right = [ "clock" ];
#
#       "custom/logo" = {
#         format = "󱄅";
#         on-click = "wofi --show drun";
#         on-click-right = "killall .wofi-wrapped";
#       };
#
#       clock = {
#         format = " {:%H:%M:%S 󰃭 %d/%m/%Y}";
#         interval = 1;
#       };
#     };
#   };
# };

# imports = [ ./config/hyprland.nix ];

# stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
#
# stylix.image = pkgs.fetchurl {
#   url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
#   sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
# };
#
# stylix.fonts = {
#   serif = {
#     package = pkgs.dejavu_fonts;
#     name = "DejaVu Serif";
#   };
#
#   sansSerif = {
#     package = pkgs.dejavu_fonts;
#     name = "DejaVu Sans";
#   };
#
#   monospace = {
#     package = pkgs.iosevka;
#     name = "Iosevka";
#   };
# };

#  stylix.cursor.package = pkgs.bibata-cursors;
#  stylix.cursor.name = "Bibata-Modern-Classic";

stylix.cursor.package = pkgs.catppuccin-cursors.mochaBlue;
stylix.cursor.name = "Catppuccin-Mocha-Blue-Cursors";
stylix.cursor.size = 48;

stylix.polarity = "dark";


wayland.windowManager.hyprland = {
  enable = true;
  xwayland.enable = true;
};

programs.kitty = {
  enable = true;
  settings = {
    font_size = 11;
    font_family = "Iosevka";
    
    window_padding_width = 4;
  };
};
