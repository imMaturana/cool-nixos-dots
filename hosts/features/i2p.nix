{
  services.i2pd = {
    enable = true;

    proto = {
      http.enable = true;
      sam.enable = true;
      bob.enable = true;
      i2cp.enable = true;
      i2pControl.enable = true;

      httpProxy.enable = true;
      socksProxy.enable = true;
    };
  };
}
