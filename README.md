# podman-arch-base

A minimal Arch Linux base image for use with Podman, built and published to the GitHub Container Registry via GitHub Actions.

## Usage

Reference this image as a base in your own Containerfile:

```dockerfile
FROM ghcr.io/jgrancell/podman-arch-base:latest
```

## What's included

- **Base image:** `archlinux:base` (pinned to a dated snapshot tag)
- **Locale:** `en_US.UTF-8`
- **Mirror:** <https://mirror.foss.ashforged.com/archlinux>
- **Packages:** `which`, `git`, `ripgrep`
- **User:** `arch` (UID/GID 1000), shell `/usr/bin/bash`
- **PATH:** `$HOME/.local/bin` included

## Image tags

| Tag | Description |
| --- | --- |
| `latest` | Most recent build from `main` |
| `vX.Y.Z` | Tagged release |
| `<sha>` | Exact build by commit SHA |

## Building locally

```bash
podman build -f Containerfile -t podman-arch-base:local .
```
