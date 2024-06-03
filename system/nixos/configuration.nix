{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ git home-manager];
  environment.defaultPackages = [ ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];    
      auto-optimise-store = true;
    };
    extraOptions = "trusted-users = root krzysztof";
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "boot.shell_on_fail" ];
  };

  security.sudo.extraConfig = ''Defaults pwfeedback'';

  networking = {
    hostName = "mcos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "pl_PL.UTF-8";
  console.keyMap = "pl2";

  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];
    xkb.layout = "pl";
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.printing.enable = true;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';

  users.users.krzysztof = {
    isNormalUser = true;
    description = "Krzysztof";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    packages = [ ];
    shell = pkgs.zsh;
  };

  programs.adb.enable = true;
  programs.zsh.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.image = pkgs.fetchurl {
    url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
    sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
  };

  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.polarity = "dark";

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  system.stateVersion = "23.11";
}
