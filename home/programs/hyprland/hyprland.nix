{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    hyprland
    xwayland
    waybar
    wofi
    kdePackages.dolphin
    kdePackages.kio
    kdePackages.kio-extras
    libmtp
    mtpfs
    gvfs
    desktop-file-utils
  ];

  programs.kitty.enable = true;
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      daemonize = true;
      show-failed-attempts = true;
    };
  };

  # You can add settings or config files here
  xdg.configFile."hypr/hyprland.conf".source = ./config/hyprland.conf;
  xdg.configFile."kitty/kitty.conf".source = ../kitty/config/kitty.conf;
  xdg.configFile."kitty/current-theme.conf".source = ../kitty/config/themes/blackmetal.conf;

  services = {
    swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 300;
          command = "${pkgs.swaylock-effects}/bin/swaylock -f";
        }
        {
          timeout = 600;
          command = "hyprctl dispatch dpms off";
        }
      ];
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock-effects}/bin/swaylock -f";
        }
      ];
    };
  };

  systemd.user.services.fcitx5 = {
    Unit = {
      Description = "Fcitx5 input method";
      After = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.fcitx5}/bin/fcitx5";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
