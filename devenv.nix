{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  languages.javascript.enable = true;
  languages.javascript.pnpm.enable = true;
  languages.javascript.pnpm.install.enable = true;
}
