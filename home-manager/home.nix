{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  home = {
    username = "cat";
    homeDirectory = "/home/cat";
  };
  programs.home-manager.enable = true;

  # Nicely reload system units when configs are changed
  systemd.user.startServices = "sd-switch";

  programs.firefox.enable = true;
  programs.btop.enable = true;

  programs.git = {
    enable = true;
    userName = "Joel Jinkinson";
    userEmail = "joel.jinkinson@gmail.com";
  };

  programs.gh.enable = true;

  programs.eza = {
    enable = true;
    git = true;
    icons = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historySize = 100000;
    shellAliases = {
      ls = "eza --group-directories-first";
      reb = "sudo reboot";
      sht = "sudo shutdown now";
      hib = "systemctl hibernate";
    };
    initExtra = ''
      set -o vi
      bind -m vi-command 'Control-l: clear-screen'
      bind -m vi-insert 'Control-l: clear-screen'
    '';
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "Iosevka";
      size = 12;
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    config = {
      terminal = "kitty";
      modifier = "Mod4";
      input = {
        "type:keyboard" = { xkb_layout = "gb"; };
      };
      keybindings = 
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in lib.mkOptionDefault {
          "XF86MonBrightnessDown" = "exec light -U 10";
          "XF86MonBrightnessUp" = "exec light -A 10";
        };
    };
  };

  home.stateVersion = "24.05";
}
