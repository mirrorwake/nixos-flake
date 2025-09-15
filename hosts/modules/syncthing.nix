{CURRENT_USER, ...}: {
  services.syncthing = {
    enable = true;
    user = CURRENT_USER;
    dataDir = "/home/${CURRENT_USER}/Sync";
    configDir = "/home/${CURRENT_USER}/.config/syncthing";
  };
}
