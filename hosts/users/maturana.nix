{ pkgs
, lib
, config
, ...
}:
let
  shell = "fish";
in
{
  users.users.maturana = {
    isNormalUser = true;

    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ] ++ lib.optionals config.services.greetd.enable [
      "greeter"
    ];

    hashedPassword = "$6$t0F4VBY2NtNu73Sw$CGzB7z6/W7eptkwxcZm6J8b2E0VNFPD0JPPeq5uXm67Gmfxt/pTZPnvcT/ZupY6/UeozrcrRZruD1nUNMHrcA0";
    shell = pkgs.${shell};
  };

  programs.${shell}.enable = true;
}
