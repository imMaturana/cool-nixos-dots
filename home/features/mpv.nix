{ pkgs
, ...
}:

{
  programs.mpv = {
    enable = true;
    package = pkgs.mpv-unwrapped;

    config = {
      geometry = "50%:50%";
      autofit = "80%x80%";
      volume = "60";
    };

    bindings = {
      h = "seek -5";
      l = "seek 5";
      "Shift+h" = "seek -60";
      "Shift+l" = "seek 60";
    };
  };
}
