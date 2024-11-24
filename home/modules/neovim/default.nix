{ pkgs, lib, config, ... }: 
let
  module_name = "neovim";
in {
  options = {
    modules.${module_name}.enable = lib.mkEnableOption "enable neovim";
  };
  
  config = lib.mkIf config.modules.${module_name}.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;

      extraPackages = with pkgs; [
        # Language Servers
        typescript-language-server
        lua-language-server
        ccls
        nixd

        # Formatters
        prettierd
        stylua
        clang

        ripgrep
      ];   
    };
  };
}
