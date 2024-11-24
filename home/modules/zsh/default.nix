{ pkgs, lib, config, inputs, ... }: 
let
  module_name = "zsh";
in {
  imports = [
    inputs.nix-index-database.hmModules.nix-index
  ];

  options = {
    modules.${module_name}.enable = lib.mkEnableOption "enable zsh";
  };

  config = lib.mkIf config.modules.${module_name}.enable {
    home.packages = [ pkgs.devenv ];

    programs.bat.enable = true;

    programs.lsd = {
      enable = true;
      enableAliases = true;
    };

    programs.tmux.enable = true;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "direnv" ];
      };
      shellAliases = {
        cat = "bat";
      };
    };

    programs.starship.enable = true;

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    programs.nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
