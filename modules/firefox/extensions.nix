# modules/firefox/extensions.nix
{extensionIDs}: {
  base = [
    {
      id = extensionIDs.ublock;
      url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
    }
    {
      id = extensionIDs.clearurls;
      url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
    }
    {
      id = extensionIDs.RES;
      url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/reddit-enhancement-suite/latest.xpi";
    }
  ];

  yomitan = [
    {
      id = extensionIDs.yomitan;
      url = "https://addons.mozilla.org/firefox/downloads/latest/yomitan/latest.xpi";
    }
  ];

  paranoid = [
    {
      # add stuff here
    }
  ];
  proton = [
    {
      id = extensionIDs.protonPass;
      url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
    }
    {
      id = extensionIDs.protonVPN;
      url = "https://addons.mozilla.org/firefox/downloads/latest/proton-vpn-firefox-extension/latest.xpi";
    }
  ];
}
