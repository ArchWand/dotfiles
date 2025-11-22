import decman
from decman import File, Directory, prg

from desktop_environment import *
from fonts import Fonts

decman.aur_packages += [
    "decman",
]

# Operating System
decman.packages += [
    "amd-ucode",
    "base",
    "base-devel",
    "efibootmgr",
    "linux",
    "linux-firmware",
    "networkmanager",
    "reflector",
    "sof-firmware",
    "unzip",
    "zram-generator",
]

# Terminal tools
decman.packages += [
    "acpi",
    "btop",
    "ed",
    "fastfetch",
    "fd",
    "ffmpeg",
    "fzf",
    "git",
    "github-cli",
    "jdk-openjdk",
    "jq",
    "lazygit",
    "less",
    "man-db",
    "man-pages",
    "msedit",
    "nano",
    "neovim",
    "npm",
    "plocate",
    "python",
    "ripgrep",
    "rustup",
    "tailscale",
    "trash-cli",
    "tree",
    "vi",
    "vim",
    "wget",
    "yarn",
    "yazi",
    "zip",
    "zoxide",
    "zsh",
]
decman.aur_packages += [
    "paru",
]
# Python
decman.packages += [
    "python-matplotlib",
    "python-pandas",
]

# Desktop Environment
decman.packages += [
    "bluez",
    "bluez-utils",
    "brightnessctl",
    "cava",
    "cliphist",
    "gst-plugin-pipewire",
    "libpulse",
    "matugen",
    "niri",
    "pipewire",
    "pipewire-alsa",
    "pipewire-jack",
    "pipewire-pulse",
    "qt6-multimedia-ffmpeg",
    "wireplumber",
    "wl-clipboard",
    "xdg-desktop-portal-gnome",
    "xdg-desktop-portal-gtk",
    "xwayland-satellite",
]
decman.aur_packages += [
    "appimagelauncher",
    "dms-shell-bin",
]
decman.modules += [Syncthing(), Ufw(), Ssh()]

# GUI Apps
decman.packages += [
    "baobab",
    "discord", # Put Vencord+OpenASAR in here somehow!
    "firefox",
    "fuzzel",
    "kitty",
    "obsidian",
    "prismlauncher",
    "thunderbird",
] # Put Osu in here

# Fonts
decman.modules += [Fonts()]

# Reflector
decman.enabled_systemd_units += ["reflector.timer"]

# Tailscale hooks
decman.enabled_systemd_units += ["tailscaled"]
prg(["tailscale","up"])

# Auto Timezone
decman.aur_packages += ["tzupdate"]
decman.files["/etc/NetworkManager/dispatcher.d/09-timezone"] = File(content=
"""#!/bin/sh
case "$2" in
    up)
        sudo tzupdate
    ;;
esac""")

