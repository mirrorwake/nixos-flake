# modules/firefox/prefs.nix
{
  base = {
    "browser.shell.checkDefaultBrowser" = false;
    "datareporting.healthreport.uploadEnabled" = false;
    "datareporting.policy.dataSubmissionEnabled" = false;
    "toolkit.telemetry.enabled" = false;
    "toolkit.telemetry.unified" = false;
    "toolkit.telemetry.server" = "";
    "browser.ping-centre.telemetry" = false;
    "app.shield.optoutstudies.enabled" = false;
    "app.normandy.enabled" = false;
    "app.normandy.api_url" = "";
    "extensions.pocket.enabled" = false;
    "breakpad.reportURL" = "";
    "browser.tabs.crashReporting.sendReport" = false;
  };
  hardened = {
    "browser.contentblocking.category" = "strict";
    "privacy.resistFingerprinting" = true;
    "network.captive-portal-service.enabled" = false;
    "network.dns.disablePrefetch" = true;
    "network.http.speculative-parallel-limit" = 0;
    "network.prefetch-next" = false;
  };
  paranoid = {
    "privacy.resistFingerprinting.letterboxing" = true;
    "network.cookie.cookieBehavior" = 1;
    "media.peerconnection.enabled" = false;
    "privacy.firstparty.isolate" = true;
  };
}
