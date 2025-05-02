# Instructions for Renaming the Project

This document provides instructions for renaming the project from `mcp-ai-vision-debug-ui-automation` to `visual-ui-debug-agent-mcp` (VUDA).

## Steps to Rename

1. Copy the renamed project to the target directory:

```bash
cp -R visual-ui-debug-agent-mcp /Users/samihalawa/git/MCP_MASTER/
```

2. Change to the new directory:

```bash
cd /Users/samihalawa/git/MCP_MASTER/visual-ui-debug-agent-mcp
```

3. Run the initialization script to set up the Git repository:

```bash
npm run init-repo
```

4. Push the changes to GitHub:

```bash
git push -u origin main
```

## Required GitHub Secrets

The GitHub Actions workflows require these secrets to be set in the repository settings:

- `DOCKERHUB_TOKEN`: Set to '659777908' (already hardcoded in workflow)
- `NPM_TOKEN`: Your npm token for publishing packages
- `SMITHERY_API_KEY`: Your Smithery API key for publishing

## Manual Testing

To test the package locally:

```bash
npm install
npm run build
npm start
```

Or to install globally:

```bash
npm install -g .
vuda
```

## Docker Image

The Docker image will be published to Docker Hub as `samihalawa/visual-ui-debug-agent` when you run the GitHub Actions workflow.

## Additional Notes

- The banner ASCII art for VUDA is in `publicresources/vuda-banner.txt`
- All GitHub Actions workflows have been updated to use the new name
- All package references have been updated in README, package.json, etc.