{
  inputs,
  lib,
  user,
  pkgs,
  self,
  ...
}:
{
  imports = lib.flatten [
    (with self.nixosModules; [
      attic
      bluetooth
      common
      desktop
      docker
      gaming
      home
      locale
      remotebuild
      syncthing
      tailscale
      transmission
      work
      yubikey
    ])
    (with inputs.nixos-hardware.nixosModules; [
      common-cpu-amd
      common-gpu-amd
      common-pc-ssd
      common-pc
    ])
    inputs.sops-nix.nixosModules.sops
    ./hardware-configuration.nix
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  };

  networking = {
    hostName = "rome";
    hostId = "c5a9072d";
  };

  services.syncthing.settings.folders = {
    "camera".enable = true;
    "code".enable = true;
    "documents".enable = true;
    "notes".enable = true;
    "pictures".enable = true;
    "videos".enable = true;
    "work".enable = true;
    "share".enable = true;
  };

  services.xserver = {
    deviceSection = ''
      Option "VariableRefresh" "true"
    '';
    xrandrHeads = [
      {
        output = "DisplayPort-0";
        primary = true;
        monitorConfig = ''
          Modeline "3440x1440_144.00"  1086.75  3440 3744 4128 4816  1440 1443 1453 1568 -hsync +vsync
          Option "PreferredMode" "3440x1440_144.00"
        '';
      }
      {
        # LG TV that should be off by default.
        # Option "Enable" "false" is broken, but
        # Option "Disable" "true" works, even though it's undocumented
        output = "HDMI-A-0";
        monitorConfig = ''
          Option "Disable" "true"
          Option "RightOf" "DisplayPort-0"
        '';
      }
    ];
  };

  # Allow access to keyboard firmware
  users.groups.plugdev = { };
  users.users.${user.name}.extraGroups = [
    "plugdev"
    "libvirtd"
  ];
  services.udev.extraRules = ''
    KERNEL=="hidraw*", ATTRS{idVendor}=="6582", ATTRS{idProduct}=="075c", MODE="0666", GROUP="plugdev"
  '';

  hardware.amdgpu = {
    initrd.enable = true;
    amdvlk = {
      enable = true;
      support32Bit.enable = true;
      supportExperimental.enable = true;
    };
  };

  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_kvm;
    };
  };

  environment.systemPackages = with pkgs; [ quickemu ];

  home-manager.users."${user.name}" = { };

  system.stateVersion = "23.11";
}