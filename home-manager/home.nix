{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "cat";
    homeDirectory = "/home/cat";
  };
  programs.home-manager.enable = true;

  programs.firefox.enable = true;
  programs.btop.enable = true;

  # Nicely reload system units when configs are changed
  systemd.user.startServices = "sd-switch";

  programs.git = {
    enable = true;
    userName = "Joel Jinkinson";
    userEmail = "joel.jinkinson@gmail.com";
  };

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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
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
    config = rec {
      terminal = "kitty";
      modifier = "Mod4";
      input = {
        "type:keyboard" = { xkb_layout = "gb"; };
      };
    };
  };

  home.stateVersion = "24.05";
}
