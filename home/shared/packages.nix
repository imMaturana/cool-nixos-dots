{ pkgs, ... }: {
  home.packages = with pkgs; [
    amfora
    keepassxc
    yt-dlp
    zip
    unzip
    cryptsetup
    imagemagick
    ffmpeg
    ripgrep
  ];
}
