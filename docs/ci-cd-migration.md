# CI/CD Migration Guide

This document explains the migration from script-based deployment to GitHub Actions for continuous integration and deployment.

## Overview

We have migrated from manual bash scripts to GitHub Actions workflows for all CI/CD operations. This change brings several benefits:

- **Automation**: Workflows trigger automatically on code changes and releases
- **Consistency**: Standard environment used for all builds
- **Visibility**: Build and deployment status visible in GitHub UI
- **Security**: Secrets stored securely in GitHub rather than local files

## Workflow Files

All GitHub Actions workflows are stored in the `.github/workflows/` directory:

- **build-and-test.yml**: Runs on all pushes and PRs to validate code quality
- **npm-publish.yml**: Publishes to npm registry when releases are created
- **docker-publish.yml**: Builds and pushes Docker images
- **smithery-publish.yml**: Packages and publishes to Smithery

## Original Scripts Mapping

The following table maps the original bash scripts to their GitHub Actions equivalents:

| Original Script | GitHub Actions Workflow | Notes |
|-----------------|-------------------------|-------|
| `build-publish.sh` | `build-and-test.yml` + `npm-publish.yml` | Split into build validation and publishing |
| `docker-publish.sh` | `docker-publish.yml` | Added multi-platform build support |
| `mcp-deploy.sh` | All workflows combined | Separated concerns into dedicated workflows |
| `publish-to-smithery.sh` | `smithery-publish.yml` | Same functionality in GitHub Actions |
| `smithery-api-publish.js` | `smithery-publish.yml` | JavaScript logic ported to workflow |
| `cross-platform-build.sh` | `npm-publish.yml` | Platform-specific builds handled by matrix strategy |

## Secret Management

Instead of using `.env` files or hardcoded tokens, the GitHub Actions workflows use GitHub Secrets:

- `NPM_TOKEN`: Token for publishing to npm registry
- `DOCKERHUB_USERNAME`: Docker Hub username
- `DOCKERHUB_TOKEN`: Docker Hub access token
- `SMITHERY_API_KEY`: API key for Smithery publishing

## Manual Workflow Execution

All workflows can be triggered manually from the GitHub UI:

1. Go to the "Actions" tab in the repository
2. Select the desired workflow
3. Click "Run workflow"
4. Enter any required inputs (version, tag, etc.)
5. Click "Run workflow" to start

## Legacy Scripts

The original bash scripts remain in the `/scripts` directory for reference and local development use, but they are no longer used for production deployments.

For local development and testing, you can still use:

```bash
# Build and test locally
npm run build
npm run test

# Test Smithery integration locally
npm run smithery
```

## Future Improvements

Potential improvements to consider:

1. Add workflow for automatic PR validation with status checks
2. Implement semantic versioning automation
3. Add automated release notes generation
4. Implement caching for faster builds
5. Add automated code quality checks (linting, etc.)