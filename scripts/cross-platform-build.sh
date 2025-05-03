#!/usr/bin/env bash
set -e

# Visual UI Debug Agent MCP
# Build and publish script

echo "🚀 Building Visual UI Debug Agent MCP..."

# Parse command line arguments
PUBLISH=false
VERSION=""

while [[ "$#" -gt 0 ]]; do
  case $1 in
    --publish) PUBLISH=true ;;
    --version) VERSION="$2"; shift ;;
    *) echo "Unknown parameter: $1"; exit 1 ;;
  esac
  shift
done

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf build

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Build for current platform
echo "🔨 Building TypeScript..."
npm run build

# Determine current platform
PLATFORM=$(node -p "process.platform")
ARCH=$(node -p "process.arch")
echo "💻 Current platform: $PLATFORM-$ARCH"

# Update version if specified
if [ ! -z "$VERSION" ]; then
  echo "🔖 Updating version to $VERSION..."
  npm version $VERSION --no-git-tag-version
fi

# Main package is already compatible with all platforms
echo "📄 Package is compatible with all major platforms"

# Publish universal package if requested
if [ "$PUBLISH" = true ]; then
  echo "📦 Publishing universal package to npm..."
  npm publish
else
  echo "💡 Would publish universal package (use --publish to actually publish)"
fi

echo "✅ Cross-platform build completed successfully!"
echo ""
echo "Usage examples:"
echo "  ./scripts/cross-platform-build.sh                   # Build only (no publishing)"
echo "  ./scripts/cross-platform-build.sh --publish         # Build and publish to npm"
echo "  ./scripts/cross-platform-build.sh --version 1.0.1   # Build with specific version"
echo "  ./scripts/cross-platform-build.sh --version 1.0.1 --publish  # Build and publish with version"