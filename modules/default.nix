# Reusable NixOS modules
{
  attic = import ./attic.nix;
  bluetooth = import ./bluetooth.nix;
  common = import ./common.nix;
  desktop = import ./desktop;
  docker = import ./docker.nix;
  gaming = import ./gaming.nix;
  home = import ./home.nix;
  headless = import ./headless.nix;
  hetzner = import ./hetzner.nix;
  keyd = import ./keyd.nix;
  laptop = import ./laptop.nix;
  locale = import ./locale.nix;
  nginx = import ./nginx.nix;
  node-exporter = import ./node-exporter.nix;
  remotebuild = import ./remotebuild.nix;
  ssh-access = import ./ssh-access.nix;
  syncthing = import ./syncthing.nix;
  tailscale = import ./tailscale.nix;
  transmission = import ./transmission.nix;
  work = import ./work.nix;
  yubikey = import ./yubikey.nix;
}
