{ pkgs, ... }: {
  fonts = {
    fontconfig.defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };

    packages = with pkgs; [
      # noto fonts
      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk
      noto-fonts-emoji
    ];
  };
}
