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
  in
{
  programs.firefox = {
    enable = true;
    profiles.shard = {
      id = 0;
      name = "shard";
      search = {
        force = true;
        default = "DuckDuckGo";
        order = [ "DuckDuckGo" "Google" ];
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "NixOS Wiki" = {
            urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@nw" ];
          };
          "NixOS Dev" = {
            urls = [{ template = "https://nix.dev/search.html?q={searchTerms}"; }];
            iconUpdateURL = "https://nix.dev/_static/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@nd" ];
          };
          "Bing".metaData.hidden = true;
          "Amazon.com".metaData.hidden = true;
          "Amazon.fr".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "Google".metaData.alias = "@g";
        };
      };
      bookmarks = [
        {
          name = "github";
          tags = [ "dev" ];
          keyword = "github";
          url = "https://github.com/";
        }
        {
          name = "Nix Sites";
          toolbar = true;
          bookmarks = [
            {
              name = "homepage";
              url = "https://nixos.org/";
            }
            {
              name = "wiki";
              tags = [ "wiki" "nix" ];
              url = "https://nixos.wiki/";
            }
            {
              name = "nixdev";
              tags = [ "wiki" "nix" "dev" ];
              url = "https://nix.dev/";
            }
          ];
        }
      ];
      settings = {
        # Firefox hardening settings - inspired from yokoffing/Betterfox
        # Moved to extraConfig - not sure what's the diff. here
      };
      extraConfig = builtins.readFile ./user.js;
    };
  };
}
