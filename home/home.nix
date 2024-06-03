{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./waybar/style.css;
    settings = {
      mainBar = {
        layer = "top";
        margin-top = 5;
        margin-bottom = 5;
        modules-left = [ "custom/logo" ];
        modules-right = [ "clock" ];

        "custom/logo" = {
          format = "󱄅";
          on-click = "wofi --show drun";
          on-click-right = "killall .wofi-wrapped";
        };

        clock = {
          format = " {:%H:%M:%S 󰃭 %d/%m/%Y}";
          interval = 1;
        };
      };
    };
  };

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

#  stylix.cursor.package = pkgs.bibata-cursors;
#  stylix.cursor.name = "Bibata-Modern-Classic";

  stylix.cursor.package = pkgs.catppuccin-cursors.mochaBlue;
  stylix.cursor.name = "Catppuccin-Mocha-Blue-Cursors";
  stylix.cursor.size = 48;

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

    (nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })

    nixd

    frida-tools
    jdk

    grim
    slurp
    wl-clipboard
    wofi
    swww
    waybar
  ];

  gtk.enable = true;
  qt.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

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

  programs.firefox.enable =  true;

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
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

#      "editor.fontFamily" = "Iosevka"
      "workbench.iconTheme" = "catppuccin-mocha";
#     "workbench.colorTheme" = "Catppuccin Mocha"; 
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "editor.formatOnSave" = true;

      "explorer.excludeGitIgnore" = true;

      "apklab.jadxDirPath" = "/home/krzysztof/.apklab/jadx-1.4.7";
      "apklab.apkSignerPath" = "/home/krzysztof/.apklab/uber-apk-signer-1.3.0.jar";
      "apklab.apktoolPath" = "/home/krzysztof/.apklab/apktool_2.9.3.jar";
    };
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  fonts.fontconfig = {
    enable = true;
  };

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
