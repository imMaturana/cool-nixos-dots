{
  # safety
  mv = "mv -i";
  cp = "cp -i";
  rm = "rm -i";
  srm = "shred -n 5 -zvu";

  # mkdir
  mkdir = "mkdir -p";

  # cd
  ".." = "cd ..";
  ".2" = "cd ../..";
  ".3" = "cd ../../..";
  ".4" = "cd ../../../..";
  ".5" = "cd ../../../../..";

  # systemd
  sysd = "systemctl";
  sysdu = "systemctl --user";

  # bluetooth
  bt = "bluetoothctl";
  btc = "bluetoothctl connect";
  btd = "bluetoothctl disconnect";
  bton = "bluetoothctl power on";
  btoff = "bluetoothctl power off";
}
