{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  packages = [
    pkgs.git
    pkgs.nodePackages.prettier
  ];

  git-hooks.hooks = {
    nixfmt.enable = true;
    prettier = {
      enable = true;
      excludes = [ "\\.nix$" ];
    };
  };
}
