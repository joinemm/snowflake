{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  user = "joonas";
  system = "x86_64-linux";
in {
  imports = lib.flatten [
    (with outputs.nixosModules; [
      (common {inherit user pkgs outputs;})
      (syncthing {inherit user config lib;})
      (docker {inherit user;})
      laptop
      bluetooth
      gui
      work-vpn
      (bin {inherit inputs system;})
    ])
    (with inputs.nixos-hardware.nixosModules; [
      common-cpu-amd
      common-cpu-amd-pstate
      common-pc-ssd
      common-gpu-amd
    ])
    (import ./home.nix {inherit inputs outputs pkgs user;})
    ./hardware-configuration.nix
  ];

  boot = {
    # zfs requires this
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    # force S3 sleep mode
    kernelParams = ["mem_sleep_default=deep"];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "buutti";
    hostId = "4d0256d9";
  };

  services.syncthing = {
    settings.folders = {
      "code".enable = true;
      "notes".enable = true;
      "pictures".enable = true;
      "work".enable = true;
    };
  };

  services.tailscale.enable = true;

  environment.systemPackages = lib.flatten [
    (
      with pkgs; [
        # languages and dev tools
        python3
        pipenv
        rustup
        lua
        nodejs
        statix

        # apps
        spotify
        darktable
        slack
        pavucontrol
        pcmanfm
        obsidian
        dwmblocks
        gimp
        firefox
        chromium

        # cli tools
        ffmpeg-full
        slop
        acpi
        feh
        fastfetch
        wget
        mons
        file
        bottom
        xdotool
        playerctl
        pulseaudio
        alsa-utils
        pre-commit
        wirelesstools
        jq # json parser
        fd # faster find
        dig
        rsync
        glow # render markdown on the cli
        xclip

        # libs
        libnotify
      ]
    )
  ];
}
