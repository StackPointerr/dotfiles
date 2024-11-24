{ pkgs, lib, config, ... }: 
let
  module_name = "virtualbox";
in {
  options = {
    modules.${module_name}.enable = lib.mkEnableOption "enable virtualbox";
  };
  
  config = lib.mkIf config.modules.${module_name}.enable {
    virtualisation.virtualbox = {
      host.enable = true;
      guest = {
        enable = true;
        dragAndDrop = true;
      };
    };

    users.users.krzysztof.extraGroups = [ "vboxusers" ];
  };
}
