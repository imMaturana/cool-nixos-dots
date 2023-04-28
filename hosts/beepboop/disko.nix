{ ... }:
let
  sharedMountOptions = [
    "rw"
    "noatime"
    "compress=lzo"
    "space_cache=v2"
  ];
in
{
  disko.devices.disk.sda = {
    device = "/dev/sda";
    type = "disk";
    content = {
      type = "table";
      format = "gpt";
      partitions = [
        {
          type = "partition";
          name = "EFI";
          start = "1MiB";
          end = "512MiB";
          bootable = true;
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        }
        {
          type = "partition";
          name = "swap";
          start = "512MiB";
          end = "4G";
          part-type = "primary";
          content = {
            type = "swap";
            randomEncryption = true;
          };
        }
        {
          type = "partition";
          name = "root";
          start = "4G";
          end = "100%";
          content = {
            type = "btrfs";
            extraArgs = ["-f"];
            subvolumes = {
              "@" = {
                mountpoint = "/";
                mountOptions = sharedMountOptions;
              };

              "@home" = {
                mountpoint = "/home";
                mountOptions = sharedMountOptions;
              };

              "@nix" = {
                mountpoint = "/nix";
                mountOptions = sharedMountOptions;
              };

              "@var" = {
                mountpoint = "/var";
                mountOptions = sharedMountOptions;
              };

              "@snapshots" = {
                mountpoint = "/.snapshots";
                mountOptions = sharedMountOptions;
              };
            };
          };
        }
      ];
    };
  };
}