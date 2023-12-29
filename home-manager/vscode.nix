{
  inputs,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      rust-lang.rust-analyzer
      github.copilot
      github.copilot-chat
      astro-build.astro-vscode
      pkief.material-icon-theme
      serayuzgur.crates
      equinusocio.vsc-material-theme
      esbenp.prettier-vscode
      ms-python.python
      ms-python.vscode-pylance
      bradlc.vscode-tailwindcss
    ];
  };
}
