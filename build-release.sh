#!/bin/bash
# Build release package for KDE Store submission

set -e  # Exit on error

# Get project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_ROOT"

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not a git repository"
    exit 1
fi

# Extract version from metadata.json
METADATA_FILE="package/metadata.json"
if [ ! -f "$METADATA_FILE" ]; then
    echo "Error: $METADATA_FILE not found"
    exit 1
fi

# Extract version using jq or grep
if command -v jq &> /dev/null; then
    VERSION=$(jq -r '.KPlugin.Version' "$METADATA_FILE")
else
    # Fallback to grep/sed if jq is not available
    VERSION=$(grep -oP '"Version":\s*"\K[^"]+' "$METADATA_FILE")
fi

if [ -z "$VERSION" ]; then
    echo "Error: Could not extract version from $METADATA_FILE"
    exit 1
fi

# Project name
PROJECT_NAME="ptimer"
ARCHIVE_NAME="${PROJECT_NAME}-${VERSION}"
TARBALL="${ARCHIVE_NAME}.tar.gz"

echo "Building release package..."
echo "Project: $PROJECT_NAME"
echo "Version: $VERSION"
echo "Archive: $TARBALL"
echo ""

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo "Warning: You have uncommitted changes"
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Create git archive
echo "Creating archive from git..."
git archive --format=tar.gz \
    --prefix="${ARCHIVE_NAME}/" \
    --output="$TARBALL" \
    HEAD:package

if [ -f "$TARBALL" ]; then
    SIZE=$(du -h "$TARBALL" | cut -f1)
    echo ""
    echo "✓ Successfully created: $TARBALL ($SIZE)"
    echo ""
    echo "Next steps:"
    echo "1. Test the package: tar -tzf $TARBALL"
    echo "2. Upload to KDE Store: https://store.kde.org"
    echo "3. See KDE_STORE.md for detailed instructions"
else
    echo "Error: Failed to create archive"
    exit 1
fi
