#!/usr/bin/env bash
set -e

# Visual UI Debug Agent MCP
# All-in-one deployment script

echo "🚀 Visual UI Debug Agent MCP Deployment Tool"
echo "============================================"

# Parse command-line arguments
VERSION=""
PLATFORM=""
TAG="latest"
ACTION=""

print_usage() {
  echo "Usage: ./scripts/mcp-deploy.sh [options] [command]"
  echo ""
  echo "Commands:"
  echo "  npm                 Build and publish to npm registry"
  echo "  docker              Build and publish Docker image"
  echo "  cross-platform      Build and publish platform-specific packages"
  echo "  all                 Do all of the above"
  echo ""
  echo "Options:"
  echo "  -v, --version VER   Set version number"
  echo "  -t, --tag TAG       Set Docker tag (default: latest)"
  echo "  -p, --platform PLAT Platforms for Docker (linux/amd64,linux/arm64)"
  echo "  -h, --help          Show this help message"
  echo ""
  echo "Examples:"
  echo "  ./scripts/mcp-deploy.sh npm --version 1.0.1"
  echo "  ./scripts/mcp-deploy.sh docker --tag 1.0.1"
  echo "  ./scripts/mcp-deploy.sh cross-platform"
  echo "  ./scripts/mcp-deploy.sh all --version 1.0.1 --tag 1.0.1"
}

# Parse options
while [[ "$#" -gt 0 ]]; do
  case $1 in
    npm|docker|cross-platform|all) ACTION="$1" ;;
    -v|--version) VERSION="$2"; shift ;;
    -t|--tag) TAG="$2"; shift ;;
    -p|--platform) PLATFORM="$2"; shift ;;
    -h|--help) print_usage; exit 0 ;;
    *) echo "Unknown parameter: $1"; print_usage; exit 1 ;;
  esac
  shift
done

if [ -z "$ACTION" ]; then
  echo "❌ Error: No command specified"
  print_usage
  exit 1
fi

# Clean and build
clean_and_build() {
  echo "🧹 Cleaning previous builds..."
  rm -rf build
  
  echo "📦 Installing dependencies..."
  npm install
  
  echo "🔨 Building TypeScript..."
  npm run build
  
  if [ ! -z "$VERSION" ]; then
    echo "🔖 Setting version to $VERSION..."
    npm version $VERSION --no-git-tag-version
  fi
}

# NPM publish function
publish_npm() {
  echo "📦 Publishing to npm..."
  
  # Use auth token if available
  if [ -f .npmrc.publish ]; then
    echo "🔑 Using authentication from .npmrc.publish"
    cp .npmrc.publish .npmrc
    npm publish
    # Remove temporary .npmrc to avoid committing tokens
    rm .npmrc
  else
    npm publish
  fi
  
  echo "✅ Published to npm successfully!"
}

# Docker publish function
publish_docker() {
  echo "🐳 Building and publishing Docker image..."
  
  # Set default platform if not specified
  if [ -z "$PLATFORM" ]; then
    PLATFORM="linux/amd64,linux/arm64"
  fi
  
  # Check if docker buildx is available
  if docker buildx version > /dev/null 2>&1; then
    echo "🔨 Building multi-platform image with buildx..."
    
    # Create builder if needed
    if ! docker buildx inspect mcp-builder > /dev/null 2>&1; then
      docker buildx create --name mcp-builder --use
    else
      docker buildx use mcp-builder
    fi
    
    # Build and push
    docker buildx build --platform $PLATFORM -t samihalawa/visual-ui-debug-agent-mcp:$TAG . --push
    
    # Tag as latest if it's a version tag
    if [[ $TAG =~ ^v?[0-9]+\.[0-9]+\.[0-9]+ ]] && [ "$TAG" != "latest" ]; then
      docker buildx build --platform $PLATFORM -t samihalawa/visual-ui-debug-agent-mcp:latest . --push
    fi
  else
    echo "⚠️ Docker buildx not available, using standard build..."
    docker build -t samihalawa/visual-ui-debug-agent-mcp:$TAG .
    docker push samihalawa/visual-ui-debug-agent-mcp:$TAG
    
    if [[ $TAG =~ ^v?[0-9]+\.[0-9]+\.[0-9]+ ]] && [ "$TAG" != "latest" ]; then
      docker tag samihalawa/visual-ui-debug-agent-mcp:$TAG samihalawa/visual-ui-debug-agent-mcp:latest
      docker push samihalawa/visual-ui-debug-agent-mcp:latest
    fi
  fi
  
  echo "✅ Published to Docker Hub successfully!"
}

# Cross-platform publish function (simplified - just publishes the universal package)
publish_cross_platform() {
  echo "🌐 Publishing universal package compatible with all platforms..."
  
  # Publish with auth if available
  if [ -f .npmrc.publish ]; then
    echo "🔑 Using authentication from .npmrc.publish"
    cp .npmrc.publish .npmrc
    npm publish
    # Remove temporary .npmrc to avoid committing tokens
    rm .npmrc
  else
    npm publish
  fi
  
  echo "✅ Package published successfully!"
}

# Main execution
clean_and_build

case $ACTION in
  npm)
    publish_npm
    ;;
  docker)
    publish_docker
    ;;
  cross-platform)
    publish_cross_platform
    ;;
  all)
    publish_npm
    publish_docker
    publish_cross_platform
    ;;
esac

echo "🎉 Deployment completed successfully!"