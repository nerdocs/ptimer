# Contributing to Patient Timer

Thank you for considering contributing to Patient Timer! This document provides guidelines for contributing to the project.

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue on GitHub with:
- A clear, descriptive title
- Steps to reproduce the issue
- Expected behavior
- Actual behavior
- Your environment (Plasma version, Qt version, OS)
- Screenshots if applicable

### Suggesting Enhancements

Enhancement suggestions are welcome! Please open an issue with:
- A clear description of the enhancement
- Use cases for the feature
- Any implementation ideas you have

### Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Make your changes
4. Test thoroughly in Plasma
5. Update documentation if needed
6. Commit with clear messages (`git commit -m 'Add feature: description'`)
7. Push to your fork (`git push origin feature/your-feature`)
8. Open a Pull Request

## Development Setup

### Prerequisites

Install development dependencies:
```bash
sudo apt install cmake extra-cmake-modules qtbase6-dev \
    libkf6plasma-dev libkf6i18n-dev gettext
```

### Building for Development

```bash
# Create symlink for in-place development
mkdir -p ~/.local/share/plasma/plasmoids
ln -s $(pwd)/package ~/.local/share/plasma/plasmoids/org.nerdocs.ptimer

# Restart plasmashell to load changes
killall plasmashell && plasmashell &
```

### Testing Changes

After making changes:
1. Remove and re-add the widget from the panel
2. Or restart plasmashell: `killall plasmashell && plasmashell &`
3. Test all configurations
4. Verify translations work

## Code Style

### QML
- Use 4 spaces for indentation
- Follow Qt/KDE QML coding style
- Use descriptive property and function names
- Add comments for complex logic

### Translations
- All user-visible strings must use `i18n()`
- Keep strings concise and clear
- Test with different languages

## Adding Translations

To add a new language:

1. Create `po/LANG.po` based on `po/de.po`
2. Translate all msgstr entries
3. Test with your language locale
4. Submit a Pull Request

## Commit Messages

Follow these guidelines:
- Use present tense ("Add feature" not "Added feature")
- Use imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit first line to 72 characters
- Reference issues and PRs when applicable

Examples:
```
Add configurable font size option

Fixes #42
```

## Questions?

Feel free to open an issue for questions about contributing!
