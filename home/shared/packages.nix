{ pkgs, ... }: {
  home.packages = with pkgs; [
    age
    amfora
    cryptsetup
    ffmpeg
    imagemagick
    keepassxc
    minisign
    ripgrep
    unzip
    yt-dlp
    zip
  ];
}
