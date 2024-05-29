{ pkgs, lib, config, ... }:
{	
  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = {
      monitor = ",preferred,auto,1";      
      
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
 
        "col.active_border" = lib.mkForce "rgba(ffebbcba) rgba(ff31748f) rgba(ffeb6f92) rgba(ffc4a7e7) 90deg";
      };

      decoration = {
        rounding = 5; 
      };

      animations = {
        enabled = true;

        bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05"
	"linear, 0.0, 0.0, 1.0, 1.0" ];

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 100, linear, loop"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      misc.disable_hyprland_logo = false;

      input = {
	kb_layout = "pl";

	touchpad.natural_scroll = true;
      };

      "$mod" = "SUPER";
      bindm = [
	"$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      bind = [
	"$mod, RETURN, exec, kitty"
	"$mod, X, exec, firefox"
	"$mod SHIFT, S, exec, grim -l 0 -g \"$(slurp)\" - | wl-copy"
	"$mod, SPACE, exec, wofi --show drun"

	"$mod, ., exec, hyprctl dispatch dpms"

	"$mod, W, killactive"
	"$mod, M, fullscreen"

	"$mod, H, movefocus, l"
	"$mod, L, movefocus, r"
	"$mod, K, movefocus, u"
	"$mod, J, movefocus, d"

	"$mod SHIFT, H, movewindow, l"
	"$mod SHIFT, L, movewindow, r"
	"$mod SHIFT, K, movewindow, u"
	"$mod SHIFT, J, movewindow, d"

	"$mod SHIFT, 1, movetoworkspace, 1"
	"$mod SHIFT, 2, movetoworkspace, 2"
	"$mod SHIFT, 3, movetoworkspace, 3"

	"$mod ALT, H, resizeactive, -30 0"
	"$mod ALT, L, resizeactive, 30 0"
	"$mod ALT, K, resizeactive, 0 -20"
	"$mod ALT, J, resizeactive, 0 20"

	"$mod, 1, workspace, 1"
	"$mod, 2, workspace, 2"
	"$mod, 3, workspace, 3"
      ];

      exec-once = "bash ~/.config/dotfiles/home/config/start.sh";
    };
  };
}
