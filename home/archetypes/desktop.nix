{
  config,
  pkgs,
  ...
}: let
  lib = pkgs.lib;
  mpvacious = import ../../home/programs/mpvacious/mpvacious.nix {inherit pkgs lib;};
in {
  imports = [
    ../../home/programs/hyprland/hyprland.nix
  ];

  home.packages = with pkgs; [
    # --- mpv & friends ---
    pkgs.mpv
    pkgs.yt-dlp
    mpvacious
    # --- gnome themes ---
    gnome-themes-extra
    adwaita-icon-theme
    # --- zim ---
    zim
    # --- screenshots ---
    grim
    slurp
    swayimg
    # --- fonts ---
    notonoto
  ];

  xdg.configFile = {
    "fcitx5/profile".source = ../../home/programs/fcitx5/profile;
    "fcitx5/config".source = ../../home/programs/fcitx5/config;
    "fcitx5/conf/notifications.conf".source = ../../home/programs/fcitx5/conf/notifications.conf;
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };

  xdg.autostart.enable = true;

  xdg.configFile."autostart/fcitx5.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Fcitx5
    Exec=fcitx5
    X-GNOME-Autostart-enabled=true
  '';

  gtk.enable = true;

  gtk.theme = {
    name = "Adwaita-dark";
    package = pkgs.gnome-themes-extra;
  };

  gtk.iconTheme = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
  };

  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name = Adwaita-dark
    gtk-icon-theme-name = Adwaita
    gtk-font-name = Noto Sans 11
    gtk-application-prefer-dark-theme = true
  '';

  qt = {
    enable = true;

    platformTheme.name = "qt5ct"; # works for both Qt5 and Qt6 apps

    style = {
      name = "Adwaita-Dark";
      package = pkgs.adwaita-qt;
    };
  };

  xdg.configFile."qt5ct/qt5ct.conf".text = ''
    [Appearance]
    style=Adwaita-Dark
    palette=default
    icon_theme=Adwaita
    standard_dialogs=default
  '';
}
