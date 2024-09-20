{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      (pkgs.vimUtils.buildVimPlugin {
        pname = "neocord";
        version = "2024-01-11";
        src = pkgs.fetchFromGitHub {
          owner = "IogaMaster";
          repo = "neocord";
          rev = "9b624d5189f699ab454e9515262c13965395b8dd";
          sha256 = "0kvii7w1yqrzfidwky4ljmmsr33pciz1rw9v3kqf0ck36clqqxhy";
        };
      })
    ];

    extraConfigLua = ''
      require("neocord").setup({
          -- General options
          auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
          logo                = "https://repository-images.githubusercontent.com/325421844/ecb73f47-cb89-4ee0-a0fd-9743c2f3569a", -- "auto" or url
          logo_tooltip        = "Nixvim", -- nil or string
          main_image          = "logo", -- "language" or "logo"
          client_id           = "1157438221865717891",       -- Use your own Discord application client id (not recommended)
          log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
          debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
          enable_line_number  = false,                      -- Displays the current line number instead of the current project
          blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
          buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
          file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
          show_time           = true,                       -- Show the timer
          global_timer        = false,

          -- Rich Presence text options
          editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
          file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
          git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
          plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
          reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
          workspace_text      = "I use nixos btw",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
          line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
          terminal_text       = "Using Terminal",           -- Format string rendered when in terminal mode.
      })
    '';
  };
}
