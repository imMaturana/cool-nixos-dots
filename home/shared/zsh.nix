{ osConfig
, ...
}:
{
  programs.zsh = {
    inherit (osConfig.programs.zsh) enable;
    shellAliases = import ./_shellAliases.nix;
  };
}
