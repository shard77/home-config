{config, ...}: {
  programs.nixvim = {
    globals.mapleader = " ";

    keymaps = [
      # [General Keymaps]
      # INSERT Mode
      # -- go to beginning and end
      {
        mode = "i";
        action = "<ESC>^i";
        key = "<C-b>";
        options.desc = "Beginning of line";
      }
      {
        mode = "i";
        action = "<End>";
        key = "<C-e>";
        options.desc = "End of line";
      }
      # -- navigate within insert mode
      {
        mode = "i";
        action = "<Left>";
        key = "<C-h>";
        options.desc = "Move left";
      }
      {
        mode = "i";
        action = "<Right>";
        key = "<C-l>";
        options.desc = "Move right";
      }
      {
        mode = "i";
        action = "<Down>";
        key = "<C-j>";
        options.desc = "Move down";
      }
      {
        mode = "i";
        action = "<Up>";
        key = "<C-k>";
        options.desc = "Move up";
      }
      # NORMAL Mode
      {
        mode = "n";
        action = "<cmd>noh<CR>";
        key = "<Esc>";
        options.desc = "Clear highlights";
      }
      # -- switch between windows
      {
        mode = "n";
        action = "<C-w>h";
        key = "<C-h>";
        options.desc = "Window left";
      }
      {
        mode = "n";
        action = "<C-w>l";
        key = "<C-l>";
        options.desc = "Window right";
      }
      {
        mode = "n";
        action = "<C-w>j";
        key = "<C-j>";
        options.desc = "Window down";
      }
      {
        mode = "n";
        action = "<C-w>k";
        key = "<C-k>";
        options.desc = "Window up";
      }
      # -- save
      {
        mode = "n";
        action = "<cmd>w<CR>";
        key = "<C-s>";
        options.desc = "Save file";
      }
      # -- copy all
      {
        mode = "n";
        action = "<cmd>%y+<CR>";
        key = "<C-c>";
        options.desc = "Copy whole file";
      }
      # -- line numbers
      {
        mode = "n";
        action = "<cmd>set nu!<CR>";
        key = "<leader>n";
        options.desc = "Toggle line number";
      }
      {
        mode = "n";
        action = "<cmd>set rnu!<CR>";
        key = "<leader>rn";
        options.desc = "Toggle relative number";
      }

      # -- allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
      {
        mode = "n";
        action = "v:count || mode(1)[0:1] == \"no\" ? \"j\" : \"gj\"";
        key = "j";
        options = {
          desc = "Move down";
          expr = true;
        };
      }
      {
        mode = "n";
        action = "v:count || mode(1)[0:1] == \"no\" ? \"k\" : \"gk\"";
        key = "k";
        options = {
          desc = "Move up";
          expr = true;
        };
      }
      {
        mode = "n";
        action = "v:count || mode(1)[0:1] == \"no\" ? \"k\" : \"gk\"";
        key = "<Up>";
        options = {
          desc = "Move up";
          expr = true;
        };
      }
      {
        mode = "n";
        action = "v:count || mode(1)[0:1] == \"no\" ? \"j\" : \"gj\"";
        key = "<Down>";
        options = {
          desc = "Move down";
          expr = true;
        };
      }

      # -- new buffer
      {
        mode = "n";
        action = "<cmd>enew<CR>";
        key = "<leader>b";
        options.desc = "New buffer";
      }
      {
        mode = "n";
        action = "<cmd>Cheatsheet<CR>";
        key = "<leader>ch";
        options.desc = "Mapping cheatsheet";
      }
      {
        mode = "n";
        action = ''
          function()
            vim.lsp.buf.format { async = true }
          end
        '';
        lua = true;
        key = "<leader>fm";
        options.desc = "LSP formatting";
      }
      {
        mode = "t";
        action = ''
          vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true)
        '';
        lua = true;
        key = "<C-x>";
        options.desc = "Escape terminal mode";
      }
      {
        mode = "v";
        action = "v:count || mode(1)[0:1] == \"no\" ? \"k\" : \"gk\"";
        key = "<Up>";
        options = {
          desc = "Move up";
          expr = true;
        };
      }
      {
        mode = "v";
        action = "v:count || mode(1)[0:1] == \"no\" ? \"j\" : \"gj\"";
        key = "<Down>";
        options = {
          desc = "Move down";
          expr = true;
        };
      }
      {
        mode = "v";
        action = "<gv";
        key = "<";
        options.desc = "Indent line";
      }
      {
        mode = "v";
        action = ">gv";
        key = ">";
        options.desc = "Indent line";
      }
      {
        mode = "x";
        action = "v:count || mode(1)[0:1] == \"no\" ? \"j\" : \"gj\"";
        key = "j";
        options = {
          desc = "Move down";
          expr = true;
        };
      }
      {
        mode = "x";
        action = "v:count || mode(1)[0:1] == \"no\" ? \"k\" : \"gk\"";
        key = "k";
        options = {
          desc = "Move up";
          expr = true;
        };
      }
      {
        mode = "x";
        action = "p:let @+=@0<CR>:let @\"=@0<CR>";
        key = "p";
        options = {
          desc = "Dont copy replaced text";
          silent = true;
        };
      }

      ## WHICHKEY

      {
        mode = "n";
        action = ''
          function()
            vim.cmd "WhichKey"
          end
        '';
        lua = true;
        key = "<leader>wK";
        options.desc = "Which-key all keymaps";
      }
      {
        mode = "n";
        action = ''
          function()
            local input = vim.fn.input "WhichKey: "
            vim.cmd("WhichKey " .. input)
          end
        '';
        lua = true;
        key = "<leader>wk";
        options.desc = "Which-key query lookup";
      }
      ## GITSIGNS
      {
        mode = "n";
        action = ''
          function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              require("gitsigns").next_hunk()
            end)
            return "<Ignore>"
          end
        '';
        lua = true;
        key = "]c";
        options = {
          expr = true;
          desc = "Jump to next hunk";
        };
      }
      {
        mode = "n";
        action = ''
          function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              require("gitsigns").next_hunk()
            end)
            return "<Ignore>"
          end
        '';
        lua = true;
        key = "[c";
        options = {
          expr = true;
          desc = "Jump to prev hunk";
        };
      }
      {
        mode = "n";
        action = ''
          function()
            require("gitsigns").reset_hunk()
          end
        '';
        lua = true;
        key = "<leader>rh";
        options.desc = "Reset hunk";
      }
      {
        mode = "n";
        action = ''
          function()
            require("gitsigns").preview_hunk()
          end
        '';
        lua = true;
        key = "<leader>ph";
        options.desc = "Preview hunk";
      }
      {
        mode = "n";
        action = ''
          function()
            package.loaded.gitsigns.blame_line()
          end
        '';
        lua = true;
        key = "<leader>gb";
        options.desc = "Blame line";
      }
      {
        mode = "n";
        action = ''
          function()
            require("gitsigns").toggle_deleted()
          end
        '';
        lua = true;
        key = "<leader>td";
        options.desc = "Toggle deleted";
      }
      ## TELESCOPE

      {
        mode = "n";
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>ff";
        options.desc = "Find files";
      }
      {
        mode = "n";
        action = "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>";
        key = "<leader>fa";
        options.desc = "Find all";
      }
      {
        mode = "n";
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>fw";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader>fb";
        options.desc = "Find buffers";
      }
      {
        mode = "n";
        action = "<cmd>Telescope help_tags<CR>";
        key = "<leader>fh";
        options.desc = "Help page";
      }
      {
        mode = "n";
        action = "<cmd>Telescope oldfiles<CR>";
        key = "<leader>fo";
        options.desc = "Find oldfiles";
      }
      {
        mode = "n";
        action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
        key = "<leader>fz";
        options.desc = "Find in current buffer";
      }
      {
        mode = "n";
        action = "<cmd>Telescope git_commits<CR>";
        key = "<leader>cm";
        options.desc = "Git commits";
      }
      {
        mode = "n";
        action = "<cmd>Telescope git_status<CR>";
        key = "<leader>gt";
        options.desc = "Git status";
      }
      {
        mode = "n";
        action = "<cmd>Telescope terms<CR>";
        key = "<leader>pt";
        options.desc = "Pick hidden term";
      }
      {
        mode = "n";
        action = "<cmd>Telescope themes<CR>";
        key = "<leader>th>";
        options.desc = "Pick themes";
      }
      {
        mode = "n";
        action = "<cmd>Telescope marks<CR>";
        key = "<leader>ma";
        options.desc = "telescope bookmarks";
      }
    ];
  };
}
