#!/usr/bin/env bash
set -e

# Visual UI Debug Agent MCP
# Global Installation Script

echo "🚀 Installing Visual UI Debug Agent MCP globally"
echo "=============================================="

# Check if npm is available
if ! command -v npm &> /dev/null; then
    echo "❌ Error: npm is not installed. Please install Node.js and npm first."
    exit 1
fi

# Check if the package is already published to npm
PACKAGE_INFO=$(npm view visual-ui-debug-agent-mcp 2>/dev/null || echo "")

if [ -z "$PACKAGE_INFO" ]; then
    echo "❌ Error: Package not found on npm registry. Has it been published?"
    echo "   You can publish it using: npm run deploy:npm"
    exit 1
fi

# Install the package globally
echo "📦 Installing package globally..."
npm install -g visual-ui-debug-agent-mcp

# Verify installation
if command -v visual-ui-debug-agent-mcp &> /dev/null; then
    echo "✅ Installation successful!"
    echo ""
    echo "You can now run the MCP server using:"
    echo "visual-ui-debug-agent-mcp"
    echo ""
    echo "To configure the server, use environment variables:"
    echo "PORT=9090 DEBUG=true visual-ui-debug-agent-mcp"
else
    echo "❌ Installation failed. Please check for errors above."
    exit 1
fi