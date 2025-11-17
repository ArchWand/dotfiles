import decman
from decman import File, Directory, prg

decman.aur_packages += [
    "decman",
]

# Operating System
decman.packages += [
    "amd-ucode",
    "base",
    "base-devel",
    "efibootmgr",
    "libpulse",
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
    "openssh",
    "plocate",
    "python",
    "ripgrep",
    "rustup",
    "tailscale",
    "trash-cli",
    "tree",
    "ufw",
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
    "cava",
    "cliphist",
    "gst-plugin-pipewire",
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

# GUI Apps
decman.packages += [
    "baobab",
    "discord", # Put Vencord in here somehow!
    "firefox",
    "fuzzel",
    "kitty",
    "prismlauncher",
    "thunderbird",
] # Put Osu in here

# Fonts
decman.packages += [
    "adobe-source-code-pro-fonts",
    "adobe-source-han-sans-otc-fonts",
    "adobe-source-han-serif-otc-fonts",
    "adobe-source-sans-fonts",
    "adobe-source-serif-fonts",
    "noto-fonts",
    "noto-fonts-cjk",
    "noto-fonts-emoji",
    "noto-fonts-extra",
    "ttf-dejavu",
    "ttf-hanazono",
    "ttf-liberation",
    "ttf-iosevka-nerd",
    "ttf-sourcecodepro-nerd",
]

# Reflector
decman.enabled_systemd_units += ["reflector.timer"]

# OpenSSH hooks
decman.enabled_systemd_units += ["sshd"]
prg(["ufw","allow","22"])

# ufw hooks
prg(["ufw","default","deny","incoming"])
prg(["ufw","default","allow","outgoing"])
prg(["ufw","enable"])

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

