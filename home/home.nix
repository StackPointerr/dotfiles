{ config, pkgs, ... }:

let
  username = "krzysztof";
in
{
  imports = [ ./config/hyprland.nix ];

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

  stylix.image = pkgs.fetchurl {
    url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
    sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
  };

  stylix.fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    monospace = {
      package = pkgs.iosevka;
      name = "Iosevka";
    };
  };

  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.polarity = "dark";

  home.username = "krzysztof";
  home.homeDirectory = "/home/krzysztof";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    zsh
    iosevka
    vscode
    devenv
    direnv
  ];

  home.file = {
  };

  gtk.enable = true;

  qt.enable = true;
  qt.platformTheme.name = "gtk";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "direnv" ];
      theme = "robbyrussell";
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.kitty = {
    enable = true;
    settings = {
      font_size = 11;
      font_family = "Iosevka";
      
      window_padding_width = 4;
    };
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [ 
      esbenp.prettier-vscode
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      angular.ng-template
      bmewburn.vscode-intelephense-client
    ];
    userSettings = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "prettier.tabWidth" = 4;
      "prettier.printWidth" = 160;

      "terminal.integrated.defaultProfile.linux" = "zsh";

#      "editor.fontFamily" = "Iosevka";
      "workbench.iconTheme" = "catppuccin-mocha";
#     "workbench.colorTheme" = "Catppuccin Mocha"; 
    };
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  fonts.fontconfig = {
    enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
