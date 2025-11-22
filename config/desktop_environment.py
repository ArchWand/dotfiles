from decman import Module, prg

import env

# Firewall
class Ufw(Module):
    def __init__(self):
        super().__init__(name="ufw", enabled=True, version="1")

    def on_enable(self):
        prg(["ufw","default","deny","incoming"])
        prg(["ufw","default","allow","outgoing"])
        prg(["ufw","enable"])

    def on_disable(self):
        prg(["ufw","disable"])

    def pacman_packages(self) -> list[str]:
        return ["ufw"]

# Remote file syncing
class Syncthing(Module):
    def __init__(self):
        super().__init__(name="syncthing", enabled=True, version="1")

    def on_enable(self):
        # Allow traffic through firewall
        prg(["ufw", "allow", "syncthing"])

    def on_disable(self):
        # Unsubscribe
        prg(["ufw", "deny", "syncthing"])

    def pacman_packages(self) -> list[str]:
        return ["syncthing"]

    def systemd_user_units(self) -> dict[str, list[str]]:
        return {env.user: ["syncthing.service"]}

class Ssh(Module):
    def __init__(self):
        super().__init__(name="ssh", enabled=True, version="1")

    def on_enable(self):
        # Allow traffic through firewall
        prg(["ufw","allow","22"])

    def on_disable(self):
        # Unsubscribe
        prg(["ufw","deny","22"])

    def pacman_packages(self) -> list[str]:
        return ["openssh"]

    def systemd_units(self) -> list[str]:
        return ["sshd"]
