{pkgs}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    home-manager
    cryptsetup
  ];
}
