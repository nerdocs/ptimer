# PTimer - Patient Timer

A KDE Plasma widget for tracking patient consultation time.

## Features

- Displays elapsed time in minutes:seconds format (MM:SS)
- Starts automatically from 0:00
- Click anywhere on the timer to reset to 0
- Works both as panel widget and desktop widget
- Configurable time thresholds with color warnings (yellow/red)
- Configurable update interval
- Multilingual support (English, German)
- Lightweight QML-based interface

## Requirements

- KDE Plasma 6.0+
- Qt 6.0+
- CMake 3.16+ (for building from source)
- Extra CMake Modules (ECM)

## Installation

### From KDE Store (Recommended)

1. Right-click on your panel or desktop
2. Select "Add Widgets..."
3. Click "Get New Widgets" → "Download New Plasma Widgets"
4. Search for "Patient Timer"
5. Click "Install"

### From Source Using CMake

```bash
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make
sudo make install
```

### Using kpackagetool6

```bash
kpackagetool6 --install package/
```

To update:
```bash
kpackagetool6 --upgrade package/
```

To uninstall:
```bash
kpackagetool6 --remove org.nerdocs.ptimer
```

## Usage

1. Right-click on your panel or desktop
2. Select "Add Widgets..."
3. Search for "Patient Timer"
4. Click on it to add it to your panel or desktop
5. Click the timer display to reset it to 0:00

## Configuration

Right-click the widget and select "Configure Patient Timer" to adjust:

- **Update interval**: How often the timer updates (default: 1000ms)
- **Warning threshold**: Time in seconds before background turns yellow (default: 300s / 5 minutes)
- **Warning color**: Color for warning state (default: #FFEB3B - yellow)
- **Critical threshold**: Time in seconds before background turns red (default: 600s / 10 minutes)
- **Critical color**: Color for critical state (default: #F44336 - red)

## Translations

The widget supports multiple languages through KDE's i18n system:

- **English** (default)
- **German** (Deutsch)

To add a new language:

1. Copy `package/translate/de.po` to `package/translate/YOUR_LANG.po`
2. Edit the translations in the new file
3. Update `build_translations.sh` to include your language
4. Run `./build_translations.sh`

## Development

For in-place development, symlink the package directory:

```bash
mkdir -p ~/.local/share/plasma/plasmoids
ln -s /path/to/ptimer/package ~/.local/share/plasma/plasmoids/org.nerdocs.ptimer
```

After making changes, restart the widget or run:
```bash
killall plasmashell && plasmashell &
```

## Project Structure

```
ptimer/
├── package/
│   ├── contents/
│   │   ├── ui/
│   │   │   ├── main.qml           # Main QML interface
│   │   │   └── configGeneral.qml  # Configuration UI
│   │   ├── config/
│   │   │   ├── main.xml           # Configuration schema
│   │   │   └── config.qml         # Config registration
│   │   └── locale/
│   │       └── de/                # German translations
│   ├── translate/
│   │   └── de.po                  # German translation source
│   ├── metadata.json              # Widget metadata
│   └── metadata.desktop           # Desktop entry
├── install.sh                     # Installation script
├── build_translations.sh          # Translation build script
└── README.md                      # This file
```

## License

MIT
