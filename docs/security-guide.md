# Security Guide

## Handling Sensitive Information

This guide provides instructions for securely managing tokens, keys, and other sensitive information in this project.

### GitHub Secrets

All sensitive information should be stored as GitHub repository secrets:

1. Go to your repository on GitHub
2. Navigate to Settings → Secrets and variables → Actions
3. Click "New repository secret"
4. Add the necessary secrets (NPM_TOKEN, DOCKERHUB_TOKEN, etc.)

### Environment Variables

For local development, use environment variables via a `.env` file:

```bash
# .env file example
NPM_TOKEN=your_npm_token
SMITHERY_API_KEY=your_smithery_key
```

**Important**: The `.env` file should never be committed to git. It is already added to `.gitignore`.

### Dealing with Exposed Secrets

If you accidentally commit a secret to the repository:

1. **Revoke the exposed token immediately**
   - For npm: Create a new token at https://www.npmjs.com/settings/tokens
   - For Docker Hub: Create a new token at https://hub.docker.com/settings/security
   - For Smithery: Create a new API key through the Smithery dashboard

2. **Update GitHub Actions secrets** with the new tokens

3. **Address GitHub Secret Scanning alerts**:
   - Go to Security → Secret scanning → Alerts
   - For each alert, click "Close as..." and select the appropriate reason

4. **If you need to clean git history**:
   - Use the `scripts/clean-git-history.sh` script (requires BFG Repo-Cleaner)
   - Follow the on-screen instructions carefully as it rewrites git history

### Best Practices

1. **Never hardcode secrets** in any files
2. **Use environment variables** for configuration
3. **Review all PRs carefully** for any accidentally committed secrets
4. **Set up branch protection rules** to require reviews before merging
5. **Keep GitHub Secret Scanning enabled** to detect any accidentally committed secrets

### Secret Rotation Policy

For optimal security:

1. Rotate tokens periodically (every 90 days recommended)
2. Always rotate tokens after personnel changes
3. Update GitHub Secrets with new tokens
4. Document the rotation in a private location

### For CI/CD Workflows

Our GitHub Actions workflows are designed to use secrets securely:

```yaml
# Example from npm-publish.yml
- name: Publish to NPM
  run: npm publish
  env:
    NODE_AUTH_TOKEN: ${{secrets.NPM_TOKEN}}
```

### Security Tools

- **GitHub Secret Scanning**: Automatically scans repositories for known secret patterns
- **GitHub Push Protection**: Prevents pushing commits containing secrets
- **BFG Repo-Cleaner**: Helps remove sensitive data from git history when necessary

If you need any help with security configurations, contact the repository maintainer.