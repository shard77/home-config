{pkgs, ...}: {
  programs.nixvim = {
    enableMan = true;
    luaLoader.enable = true;
    options = {
      list = true;
      listchars = "tab:┊»,trail:·,nbsp:⎵";
      timeoutlen = 300;
      ttimeoutlen = 50;
      mouse = "vc";
      foldmethod = "marker";
      conceallevel = 0;
      filetype = "on";
      confirm = true;
      backup = false;
      swapfile = false;
      pumblend = 10;
      splitbelow = true;
      splitright = true;
      ignorecase = true;
      smartcase = true;
      undofile = true;
      undolevels = 10000;
      updatetime = 300;
      scrolloff = 7;
      sidescrolloff = 5;
      wrap = false;
      linebreak = true;
      synmaxcol = 1000;
      foldopen = "block,hor,insert,jump,mark,percent,quickfix,search,tag,undo";
      grepprg = "${pkgs.ripgrep}/bin/rg --vimgrep --hidden --glob '!.git'";

      # Also handled by vim-sleuth
      shiftround = true;
      smartindent = true;
      shiftwidth = 2;
      autoindent = true;
      smarttab = true;
      tabstop = 2;
      expandtab = true;
    };
    clipboard = {
      register = "unnamedplus";
      providers = {
        xsel.enable = true;
        wl-copy.enable = true;
      };
    };
    extraConfigVim = ''
      " Faster keyword completion
      set complete-=i   " disable scanning included files
      set complete-=t   " disable searching tags

      " https://neovim.io/doc/user/faq.html#faq
      " set shortmess-=F
    '';
  };
}
