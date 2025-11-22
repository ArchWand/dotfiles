from decman import Module

class Fonts(Module):
    def __init__(self):
        super().__init__(name="fonts", enabled=True, version="1")

    def pacman_packages(self) -> list[str]:
        return [
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
