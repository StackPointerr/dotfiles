{ inputs, outputs, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];

  modules.virtualbox.enable = true;
    
  environment.systemPackages = with pkgs; [ git home-manager nh android-studio gparted keepassxc man-pages ];
  environment.defaultPackages = [ ];

  documentation.dev.enable = true;

  documentation.man = {
    # In order to enable to mandoc man-db has to be disabled.
    man-db.enable = false;
    mandoc.enable = true;
  };

  environment.sessionVariables = {
    FLAKE = "/home/krzysztof/.config/dotfiles/";
    MANPAGER = "nvim +Man!";
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];    
      auto-optimise-store = true;
    };
    extraOptions = "trusted-users = root krzysztof";
  };

  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      outputs.overlays.unstable-packages
      outputs.overlays.additions
    ];
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

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };

  services.xserver.xkb.layout = "pl";

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };

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

  system.stateVersion = "23.11";
}
