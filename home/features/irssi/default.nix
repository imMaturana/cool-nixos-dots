{ config
, ...
}:
{
  programs.irssi = {
    enable = true;

    networks = {
      liberachat = {
        nick = config.home.username;

        server = {
          address = "irc.libera.chat";
          port = 6697;
          autoConnect = true;
        };

        channels = {
          libera.autoJoin = true;
        };
      };
    };
  };
}
