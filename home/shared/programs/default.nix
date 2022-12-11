{pkgs, ...}: {
  imports = [
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./gpg.nix
    ./lazygit.nix
    ./librewolf.nix
    ./neovim.nix
    ./syncthing.nix
    ./tmux.nix
  ];

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

  programs = {
    home-manager.enable = true;
    jq.enable = true;
    fzf.enable = true;
    nix-index.enable = true;
    starship.enable = true;
    zoxide.enable = true;

    bat = {
      enable = true;
      config.theme = "base16";
    };

    exa = {
      enable = true;
      enableAliases = true;
    };
  };
}
