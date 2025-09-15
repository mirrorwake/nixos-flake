# modules/firefox/default.nix
{
  pkgs,
  prefProfiles ? ["base"],
  extensionProfiles ? ["base" "yomitan"],
}: let
  extensionIDs = import ./extension-ids.nix;
  rawPrefs = import ./prefs.nix;
  rawExtensions = import ./extensions.nix {inherit extensionIDs;};

  mergedPrefs = builtins.foldl' (acc: key: acc // rawPrefs.${key}) {} prefProfiles;

  extraPrefsStr = pkgs.lib.concatStringsSep "\n" (pkgs.lib.mapAttrsToList
    (k: v: "pref(\"${k}\", ${builtins.toJSON v});")
    mergedPrefs);

  allExtensions = builtins.concatLists (map (key: rawExtensions.${key}) extensionProfiles);

  extensionPolicyBlock = builtins.listToAttrs (map (ext: {
      name = ext.id;
      value = {
        installation_mode = "normal_installed";
        install_url = ext.url;
      };
    })
    allExtensions);
in
  pkgs.wrapFirefox pkgs.firefox-unwrapped {
    extraPrefs = extraPrefsStr;
    extraPolicies = {
      DisableTelemetry = true;
      DisableFirefoxAccounts = true;
      DisablePocket = true;
      DisableFeedbackCommands = true;
      CaptivePortal = false;
      DNSOverHTTPS = {
        Enabled = false;
        Locked = true;
      };
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      ExtensionSettings = extensionPolicyBlock;
    };
  }
