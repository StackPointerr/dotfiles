{ pkgs, outputs, ... }:
{
  imports = [ ./modules ];

  modules.vscode.enable = true;
  modules.zsh.enable = true;
  modules.neovim.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = [
      outputs.overlays.unstable-packages
      outputs.overlays.additions
    ];
  };

  home.username = "krzysztof";
  home.homeDirectory = "/home/krzysztof";

  home.packages = with pkgs; [
    # iosevka
    (nerdfonts.override { fonts = ["Iosevka"]; })

    wl-clipboard

    veyon
  ];

  programs.firefox.enable =  true;

  fonts.fontconfig = {
    enable = true;
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
