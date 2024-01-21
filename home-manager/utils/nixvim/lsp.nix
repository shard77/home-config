{
  programs.nixvim = {
    plugins = {
      lsp-format.enable = true;
      lspkind.enable = true;

      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          tsserver.enable = true;
          bashls.enable = true;
          lua-ls.enable = true;
          eslint.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
        };
      };
    };
  };
}
