{
  inputs,
  pkgs,
  ...
}:
let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
  lock-empty-string = {
    Value = "";
    Status = "locked";
  };
in {
  programs.firefox = {
    enable = true;
    policies = {
      ExtensionSettings = {
        "*".installation_mode = "blocked";
        # uBlock Origin:
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # Cookie Quick Manager
        "{60f82f00-9ad5-4de5-b31c-b16a47c51558}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/cookie-quick-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        # Dark Reader
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/dark-reader/latest.xpi";
          installation_mode = "force_installed";
        };
        # ClearURLs
        "{74145f27-f039-47ce-a470-a662b129930a}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
          installation_mode = "force_installed";
        };
        # FoxyProxy
        "foxyproxy@eric.h.jung" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/foxyproxy-standard/latest.xpi";
          installation_mode = "force_installed";
        };
        # Hack-Tools
        "{f1423c11-a4e2-4709-a0f8-6d6a68c83d08}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/hacktools/latest.xpi";
          installation_mode = "force_installed";
        };
        # I don't care about cookies
        "jid1-KKzOGWgsW3Ao4Q@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/i_dont_care_about_cookies/latest.xpi";
          installation_mode = "force_installed";
        };
        # LocalCDN
        "{b86e4813-687a-43e6-ab65-0bde4ab75758}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/localcdn-fork-of-decentraleyes/latest.xpi";
          installation_mode = "force_installed";
        };
        # OWASP Penetration Testing Kit
        "{1ab3d165-d664-4bf2-adb7-fed77f46116f}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/penetration-testing-kit/latest.xpi";
          installation_mode = "force_installed";
        };
        # Privacy Badger
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        # TOS; Didn't read
        "jid0-3GUEt1r69sQNSrca5p8kx9Ezc3U@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/terms-of-service-didnt-read/latest.xpi";
          installation_mode = "force_installed";
        };
        # UA Switcher and Manager
        "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/user-agent-string-switcher/latest.xpi";
          installation_mode = "force_installed";
        };
        # Violentmonkey
        "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
          installation_mode = "force_installed";
        };
        # Wappalyzer
        "wappalyzer@crunchlabz.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/wappalyzer/latest.xpi";
          installation_mode = "force_installed";
        };
        # Tree Style Tab
        "treestyletab@piro.sakura.ne.jp" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tree-style-tab/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
}
