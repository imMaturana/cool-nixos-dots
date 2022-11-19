{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 ];
    allowedUDPPorts = [ 80 ];
  };
}
