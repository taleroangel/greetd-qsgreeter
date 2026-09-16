# qsgreeter

A [QuickShell](https://quickshell.org/)-based greeter for [greetd](https://sr.ht/~kennylevinsen/greetd/). It provides a simple QML-based login interface for Wayland.

| User List | Login Screen |
| :---: | :---: |
| ![Users](docs/screenshot_users.png) | ![Login](docs/screenshot_login.png) |

<video src="https://github.com/user-attachments/assets/b735015b-3ff1-487f-8bdd-55576835c9d0" controls width="100%"></video>

## 🪛 Installation
Use _make_ to copy files into standard _quickshell_ directories. If _niri_ is present, the script
will also install `qsgreeter-niri.kdl` into `/etc/greetd/`; if _Hyprland_ is present, it will also
install `qsgreeter-hyprland.lua` there.

```sh
git clone https://github.com/taleroangel/greetd-qsgreeter
cd greetd-qsgreeter
sudo make install
```

Uninstall the package with:
```sh
sudo make uninstall
```

### Arch Linux
Currenlty not in the AUR. Download the [PKGBUILD](PKGBUILD) file and run `makepkg`.

```sh
mkdir greetd-qsgreeter
cd greetd-qsgreeter
curl -O https://raw.githubusercontent.com/taleroangel/greetd-qsgreeter/main/PKGBUILD
makepkg -si
```

```sh
git clone https://github.com/taleroangel/greetd-qsgreeter
cd greetd-qsgreeter
sudo mkdir -p /etc/xdg/quickshell
sudo cp -r qsgreeter /etc/xdg/quickshell/
sudo chmod -R 755 /etc/xdg/quickshell/qsgreeter
```

## 🚀 Launch

To use **qsgreeter**, run the following command from your chosen Wayland compositor:

```sh
quickshell -c qsgreeter
```

i.e, running from Niri `spawn-at-startup "quickshell" "-c" "qsgreeter"`, or from Hyprland
`hl.exec_cmd("quickshell -c qsgreeter")`

### Using with Niri
If you have [niri](https://github.com/niri-wm/niri) installed, you can use the provided [niri configuration file](niri/qsgreeter-niri.kdl) to start the greeter automatically. Place the configuration file at `/etc/greetd/qsgreeter-niri.kdl` (Automatically installed when using `makepkg` on _Arch_) and edit `/etc/greetd/config.toml` to launch niri with the specified configuration:

```toml
[terminal]
vt = 1

[default_session]
command = "niri --config /etc/greetd/qsgreeter-niri.kdl"
user = "greeter"
```

### Using with Hyprland
If you have [Hyprland](https://hypr.land) installed, you can use the provided [Hyprland configuration file](hyprland/qsgreeter-hyprland.lua) instead. Place the configuration file at `/etc/greetd/qsgreeter-hyprland.lua` (Automatically installed when using `makepkg` on _Arch_) and edit `/etc/greetd/config.toml` to launch Hyprland with the specified configuration:

```toml
[terminal]
vt = 1

[default_session]
command = "start-hyprland -- --config /etc/greetd/qsgreeter-hyprland.lua"
user = "greeter"
```

The configuration uses Hyprland's Lua config format, selected by the `.lua` extension. It starts
the greeter, maximizes its window, and exits Hyprland once the greeter quits so greetd can launch
the selected session. `start-hyprland` is Hyprland's watchdog launcher; running the `Hyprland`
binary directly works too but shows a warning banner on the greeter screen.

## 🎨 Customization

Configuration files are located at `/etc/xdg/quickshell/qsgreeter`. You can customize the look and fell by editing `colorscheme.json` and `style.json`.

Since the greeter is written entirely in **QML**, you can also rearrange elements as you wish.

## 🤖 AI Disclosure
Code was written entirely by me, but AI was used for technical guidance
