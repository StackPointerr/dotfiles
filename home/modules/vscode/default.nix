{ pkgs, lib, config, ... }: 
let
  module_name = "vscode";
in {
  options = {
    modules.${module_name}.enable = lib.mkEnableOption "enable vscode";
  };
  
  config = lib.mkIf config.modules.${module_name}.enable {
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

        "workbench.iconTheme" = "catppuccin-mocha";
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "editor.formatOnSave" = true;

        "explorer.excludeGitIgnore" = true;

        "apklab.jadxDirPath" = "/home/krzysztof/.apklab/jadx-1.4.7";
        "apklab.apkSignerPath" = "/home/krzysztof/.apklab/uber-apk-signer-1.3.0.jar";
        "apklab.apktoolPath" = "/home/krzysztof/.apklab/apktool_2.9.3.jar";
      };
    };
  };
}
