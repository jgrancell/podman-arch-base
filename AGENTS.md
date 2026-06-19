# AGENTS.md

Context for AI coding assistants working in this repository.

## Purpose

This repo produces a minimal Arch Linux base container image published to `ghcr.io/jgrancell/podman-arch-base`. It is intended as a common base for downstream Podman-based images, not as a standalone application image.

## Key files

| File | Role |
| --- | --- |
| `Containerfile` | Image definition — always `Containerfile`, never `Dockerfile` |
| `etc/pacman.d/mirrorlist` | Pacman mirror config, copied into the image at build time |
| `home/arch/.bashrc` | User dotfile, copied into the image at build time |
| `.github/workflows/build.yml` | GitHub Actions workflow — builds and pushes to GHCR |

## Conventions

- **Containerfile, not Dockerfile.** This project uses OCI conventions throughout.
- **Podman, not Docker.** All build and push steps use `podman`. Do not introduce Docker CLI calls or Docker-specific syntax.
- **Base image is pinned** to a dated `archlinux:base-YYYYMMDD.0.XXXXXX` tag. Bump the tag deliberately; do not change it incidentally.
- **Package upgrades via `-Syu`.** The image runs `pacman -Syu --noconfirm` to keep installed packages consistent with the mirror. Do not split this into `-Sy` + `-S`.
- **Pacman cache is cleared** after the install step (`/var/cache/pacman/pkg/` and `/var/lib/pacman/sync/`). Downstream images must run `pacman -Syu` before installing additional packages.
- **User is `arch`** (UID/GID 1000). Do not change the username without updating all references: `groupadd`, `useradd`, `WORKDIR`, `COPY --chown`, and `home/arch/`.
- **No `sudo`, `rm -rf /`, or destructive shell commands** outside of the explicit cache cleanup lines.

## What downstream images should do

Derived images that install additional packages must refresh the package database first:

```dockerfile
FROM ghcr.io/jgrancell/podman-arch-base:latest

RUN pacman -Syu --noconfirm <packages>
```

## Publishing

The GitHub Actions workflow handles all publishing. Images are pushed to `ghcr.io/jgrancell/podman-arch-base` with three tag forms: `latest`, a semver tag (on tag push), and the commit SHA.
