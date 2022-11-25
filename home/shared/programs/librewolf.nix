{ pkgs
, ...
}:

{
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf-wayland;

    settings = {
      "webgl.disabled" = false;
    };
  };
}
