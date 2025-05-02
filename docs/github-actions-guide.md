# GitHub Actions Guide

This guide explains how to use the GitHub Actions workflows for the MCP AI Vision Debug UI Automation project.

## Available Workflows

### 1. Build and Test

**File:** `.github/workflows/build-and-test.yml`

This workflow builds the project and runs tests. It triggers automatically on:
- Every push to the `main` branch
- Every pull request targeting the `main` branch
- Manual trigger via GitHub UI

**What it does:**
- Sets up Node.js (both v18 and v20 environments)
- Installs dependencies
- Builds the TypeScript project
- Runs tests
- Uploads build artifacts

**Manual trigger:**
Go to the Actions tab, select "Build and Test" workflow, and click "Run workflow".

### 2. NPM Publishing

**File:** `.github/workflows/npm-publish.yml`

This workflow publishes the package to npm. It triggers:
- Automatically when a new GitHub Release is created
- Manually via GitHub UI

**What it does:**
- Builds and tests the package
- Updates version (if specified in manual run)
- Publishes to npm registry
- Creates and publishes platform-specific packages

**Required secrets:**
- `NPM_TOKEN`: npm authentication token

**Manual trigger with options:**
1. Go to the Actions tab
2. Select "Publish NPM Package" workflow
3. Click "Run workflow"
4. Enter a version parameter (patch, minor, major, or specific version)
5. Click "Run workflow" button

### 3. Docker Publishing

**File:** `.github/workflows/docker-publish.yml`

This workflow builds and publishes Docker images. It triggers:
- Automatically when a new GitHub Release is created
- Manually via GitHub UI

**What it does:**
- Sets up Docker Buildx for multi-platform builds
- Builds images for amd64 and arm64 architectures
- Tags images based on release or specified tag
- Pushes to Docker Hub (when push is enabled)

**Required secrets:**
- `DOCKERHUB_USERNAME`: Docker Hub username
- `DOCKERHUB_TOKEN`: Docker Hub access token

**Manual trigger with options:**
1. Go to the Actions tab
2. Select "Publish Docker Image" workflow
3. Click "Run workflow"
4. Enter tag name and whether to push
5. Click "Run workflow" button

### 4. Smithery Publishing

**File:** `.github/workflows/smithery-publish.yml`

This workflow packages and publishes the project to Smithery. It triggers:
- Automatically when a new GitHub Release is created
- Manually via GitHub UI

**What it does:**
- Builds the project
- Creates a Smithery-compatible package
- Publishes to Smithery via API
- Uploads package as an artifact

**Required secrets:**
- `SMITHERY_API_KEY`: Smithery API authentication key

**Manual trigger:**
Go to the Actions tab, select "Publish to Smithery" workflow, and click "Run workflow".

## Setting Up Secrets

To use these workflows, you need to set up the following secrets in your GitHub repository:

1. Go to your repository on GitHub
2. Navigate to Settings → Secrets and variables → Actions
3. Click "New repository secret"
4. Add the following secrets:
   - `NPM_TOKEN`: Your npm authentication token
   - `DOCKERHUB_USERNAME`: Your Docker Hub username
   - `DOCKERHUB_TOKEN`: Your Docker Hub access token
   - `SMITHERY_API_KEY`: Your Smithery API key

## Creating a Release

To trigger the automatic publishing workflows:

1. Go to the repository on GitHub
2. Navigate to Releases
3. Click "Create a new release"
4. Choose or create a tag (e.g., v1.0.3)
5. Fill in the release title and description
6. Click "Publish release"

This will automatically trigger the npm, Docker, and Smithery publishing workflows.

## Workflow Status

You can check the status of all workflows:

1. Go to the Actions tab in your repository
2. View current and past workflow runs
3. Click on any run to see detailed logs and outputs

## Troubleshooting

### Common Issues

1. **Workflow fails due to missing secret:**
   - Check that all required secrets are properly set up in repository settings

2. **npm publish fails:**
   - Verify npm token has correct permissions
   - Check if version already exists on npm

3. **Docker publish fails:**
   - Verify Docker Hub credentials
   - Check if your Docker Hub account has enough permissions

4. **Smithery publish fails:**
   - Verify Smithery API key is valid
   - Check Smithery API endpoint availability