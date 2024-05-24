{ pkgs, lib, config, inputs, ... }:

{
  packages = with pkgs; [ 
    git
    nodePackages."@angular/cli"
  ];

  languages.javascript.enable = true;
  languages.php.enable = true;

  process = {
   process-compose = pkgs.lib.mkOptionDefault {
     tui = "false";
   };
  };

  services.mysql.enable = true;
  services.mysql.ensureUsers = [
    {
      name = "root";
      password = "";
      ensurePermissions = { "*.*" = "ALL PRIVILEGES"; };
    }
  ];

  enterShell = ''
  '';
}
