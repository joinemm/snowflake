<div align="center">
    <img alt="NixOS" src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake-white.svg" width="120px"/>
    <h1>Snowflake</h1>
    <img src="https://img.shields.io/github/stars/joinemm/snowflake?style=for-the-badge&labelColor=1B2330&color=a4ffff" alt="GitHub Repo stars"/>
    <img src="https://img.shields.io/github/last-commit/joinemm/snowflake?style=for-the-badge&labelColor=1B2330&color=a4ffff" alt="GitHub last commit"/>
    <img src="https://img.shields.io/github/repo-size/joinemm/snowflake?style=for-the-badge&labelColor=1B2330&color=a4ffff" alt="GitHub repo size"/>
    <a href="https://nixos.org" target="_blank">
        <img src="https://img.shields.io/badge/NixOS-unstable-blue.svg?style=for-the-badge&labelColor=1B2330&logo=NixOS&logoColor=white&color=a4ffff" alt="NixOS Unstable"/>
    </a>
</div>

---

This is my NixOS flake, including all my system dotfiles and settings.

It contains configurations for multiple host systems, and is
split into nixos modules and home-manager modules,
which are then imported from each host according to it's needs.

Shell scripts built from the flake at <https://github.com/joinemm/bin>

## Hosts

- `zeus` - Desktop workstation/gaming pc
- `x1` - Thinkpad X1 Carbon gen11 work laptop
- `monitoring` - Grafana and prometheus server for monitoring my servers
- `hetzner` - Syncthing central sync node and webserver

## Installation

For a given `host`

```
nixos-rebuild switch --flake .#$HOST
```

## Deploying to remote servers

This goes for cloud hosts like hetzner. The target server needs to have passwordless sudo for the user you log in as.

```
nixos-rebuild switch --flake .#$HOST --use-remote-sudo --target-host $IP
```
