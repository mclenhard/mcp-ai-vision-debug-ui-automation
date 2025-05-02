# MCP AI Vision Debug UI Automation

[![MCP Server](https://img.shields.io/badge/MCP-AI%20Vision%20Debug-blue)](https://github.com/samihalawa/mcp-ai-vision-debug-ui-automation) [![GLAMA Compatible](https://img.shields.io/badge/GLAMA-Compatible-green)](https://github.com/samihalawa/mcp-ai-vision-debug-ui-automation) [![Smithery Compatible](https://img.shields.io/badge/Smithery-Compatible-orange)](https://smithery.ai/docs/config)

A ModelContextProtocol (MCP) server that gives AI models the ability to analyze, debug, and interact with web interfaces through Playwright. This server enables any AI (even those without vision capabilities) to visually inspect web pages, test UI functionality, and validate user workflows.

![UI Automation Screenshot](publicresources/screenshot1.png)

## How to Use This MCP Server

This MCP server is designed to be integrated with AI systems through the Model Context Protocol. There are several ways to use it:

1. **With MCP Gateways**: Install via your preferred MCP gateway for seamless integration
2. **With custom MCP clients**: Connect your own AI clients using the MCP protocol
3. **Standalone for testing**: Run locally during development

Once connected, your AI model can call the available tools to interact with web interfaces, helping it to:

- **Capture visual information** from web pages and interpret the contents
- **Map and interact with UI elements** like buttons, forms, and navigational elements
- **Validate user workflows** by simulating actual user interactions
- **Debug web applications** by tracking console logs, performance metrics, and network activity
- **Test API endpoints** to verify backend functionality

## Installation

### Using an MCP Gateway

The recommended way to install this MCP server is through any MCP-compatible gateway:

1. Visit the server page on your preferred MCP gateway
2. Follow the standard MCP server installation process
3. Ensure your model has access to the newly installed server

### Quick Installation Script

Use our one-line installation script:

```bash
curl -s https://raw.githubusercontent.com/samihalawa/mcp-ai-vision-debug-ui-automation/main/scripts/install-global.sh | bash
```

### NPM Installation

For global installation via npm:

```bash
# Install globally
npm install -g mcp-ai-vision-debug-ui-automation

# Start the server
mcp-ai-vision-debug-ui-automation
```

### Docker Hub Installation

For containerized deployment:

```bash
# Pull the image from Docker Hub
docker pull samihalawa/mcp-ai-vision-debug-ui-automation:latest

# Run the container
docker run -p 8080:8080 samihalawa/mcp-ai-vision-debug-ui-automation:latest
```

### Smithery Integration

This package is fully Smithery-compatible using the included configuration file:

1. **Clone and Build**:
   ```bash
   git clone https://github.com/samihalawa/mcp-ai-vision-debug-ui-automation.git
   cd mcp-ai-vision-debug-ui-automation
   npm install
   npm run build
   ```

2. **Run with Smithery Configuration**:
   ```bash
   npm run smithery
   ```

3. **Connect to Claude**:
   Configure Claude or other Smithery clients to use the MCP URL: `http://localhost:8080/mcp`

For full installation and usage instructions, see the [Smithery Integration Guide](./SMITHERY-GUIDE.md).

### Manual Installation 

If you prefer to install manually:

```bash
# Clone the repository
git clone https://github.com/samihalawa/mcp-ai-vision-debug-ui-automation.git
cd mcp-ai-vision-debug-ui-automation

# Install dependencies
npm install

# Build the project
npm run build

# Start the server
npm start
```

### Cross-Platform Support

MCP AI Vision Debug UI Automation supports the following platforms:

- **Operating Systems**: macOS, Linux, Windows
- **CPU Architectures**: x64, arm64 (Apple Silicon)

Platform-specific packages are also available:

```bash
# For macOS (Intel)
npm install -g mcp-ai-vision-debug-ui-automation-darwin-x64

# For macOS (Apple Silicon)
npm install -g mcp-ai-vision-debug-ui-automation-darwin-arm64

# For Linux (x64)
npm install -g mcp-ai-vision-debug-ui-automation-linux-x64

# For Windows (x64)
npm install -g mcp-ai-vision-debug-ui-automation-win32-x64
```

## Key Features

- **Visual Analysis**: Capture and analyze screenshots of web pages
- **Interactive Element Mapping**: Automatically identify and map clickable elements, forms, and controls
- **Workflow Testing**: Define and validate complete user journeys through web interfaces
- **API Testing**: Test REST endpoints and validate responses
- **Performance Analysis**: Measure and track page load performance metrics
- **Visual Comparison**: Compare before/after states of web interfaces

## Detailed Tool Reference

### 1. `screenshot_url`

Captures screenshots of any URL.

**Parameters:**
- `url` (string): The URL to capture a screenshot of
- `fullPage` (boolean, optional): Whether to capture the full page or just viewport
- `selector` (string, optional): CSS selector to screenshot only that element
- `waitForSelector` (string, optional): CSS selector to wait for before taking screenshot
- `waitTime` (number, optional): Time to wait in milliseconds before taking screenshot
- `device` (string, optional): Device to emulate (e.g., "iPhone 13", "Pixel 5")

**Example:**
```javascript
const result = await mcp.callTool("screenshot_url", {
  url: "https://example.com/login",
  fullPage: true,
  waitForSelector: "form.login",
  waitTime: 2000
});
```

### 2. `enhanced_page_analyzer`

Performs comprehensive analysis of a web page.

**Parameters:**
- `url` (string): URL to analyze
- `includeConsole` (boolean, optional): Whether to include console logs
- `mapElements` (boolean, optional): Whether to map interactive elements
- `fullPage` (boolean, optional): Whether to analyze full page
- `waitForSelector` (string, optional): CSS selector to wait for before analysis
- `waitTime` (number, optional): Time to wait in milliseconds
- `device` (string, optional): Device to emulate

**Example:**
```javascript
const analysis = await mcp.callTool("enhanced_page_analyzer", {
  url: "https://example.com",
  includeConsole: true,
  mapElements: true,
  fullPage: true,
  waitTime: 3000
});

// You can then access:
// analysis.screenshot - Base64 screenshot data
// analysis.interactiveElements - Mapped UI elements
// analysis.consoleMessages - Console output
// analysis.performance - Performance metrics
```

### 3. `ui_workflow_validator`

Executes a sequence of UI interactions to simulate a user workflow.

**Parameters:**
- `startUrl` (string): Initial URL for the workflow
- `taskDescription` (string): Description of the user task being simulated
- `steps`: Array of step objects:
  - `description` (string): Description of the user action
  - `action` (string): Action type (navigate, click, fill, select, etc.)
  - `selector` (string, optional): CSS selector for interaction
  - `value` (string, optional): Value for fill/select actions
  - `url` (string, optional): URL for navigate action
  - `script` (string, optional): JavaScript for evaluate action
  - `waitTime` (number, optional): Time to wait in milliseconds
  - `isOptional` (boolean, optional): Whether failure should stop workflow
- `captureScreenshots` (string): When to capture screenshots ("all", "failure", "none")
- `device` (string, optional): Device to emulate

**Example:**
```javascript
const workflow = await mcp.callTool("ui_workflow_validator", {
  startUrl: "https://example.com/login",
  taskDescription: "User login and profile update flow",
  steps: [
    {
      description: "Enter username",
      action: "fill",
      selector: "#username",
      value: "testuser"
    },
    {
      description: "Enter password",
      action: "fill",
      selector: "#password",
      value: "password123"
    },
    {
      description: "Click login button",
      action: "click",
      selector: "#login-btn"
    },
    {
      description: "Verify dashboard is loaded",
      action: "verifyElementVisible",
      selector: ".dashboard-welcome"
    },
    {
      description: "Navigate to profile page",
      action: "click",
      selector: "a[href='/profile']"
    },
    {
      description: "Update bio information",
      action: "fill",
      selector: "textarea#bio",
      value: "This is my updated profile bio."
    },
    {
      description: "Save profile changes",
      action: "click",
      selector: "button[type='submit']"
    },
    {
      description: "Verify success message appears",
      action: "verifyText",
      selector: ".alert-success",
      value: "Profile updated successfully"
    }
  ],
  captureScreenshots: "failure"
});
```

### 4. `api_endpoint_tester`

Tests multiple API endpoints and verifies responses.

**Parameters:**
- `url` (string): Base URL of the API
- `endpoints`: Array of endpoint objects:
  - `path` (string): Endpoint path
  - `method` (string): HTTP method
  - `data` (object, optional): Request body data
  - `headers` (object, optional): Request headers
- `authToken` (string, optional): Auth token to include in all requests

**Example:**
```javascript
const apiTest = await mcp.callTool("api_endpoint_tester", {
  url: "https://api.example.com/v1",
  endpoints: [
    {
      path: "/users",
      method: "GET"
    },
    {
      path: "/users",
      method: "POST",
      data: {
        name: "Test User",
        email: "test@example.com"
      }
    },
    {
      path: "/users/1",
      method: "PUT",
      data: {
        name: "Updated Name"
      }
    }
  ],
  authToken: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
});
```

### 5. `navigation_flow_validator`

Tests a sequence of user actions across multiple pages.

**Parameters:**
- `startUrl` (string): URL to start the navigation flow from
- `steps`: Array of step objects:
  - `action` (string): Action to perform
  - `selector` (string, optional): CSS selector
  - `value` (string, optional): Value to input
  - `url` (string, optional): URL to navigate to
  - `script` (string, optional): JavaScript to evaluate
  - `waitTime` (number, optional): Time to wait in ms
- `captureScreenshots` (boolean, optional): Whether to capture screenshots
- `includeConsole` (boolean, optional): Whether to include console logs
- `device` (string, optional): Device to emulate

**Example:**
```javascript
const navFlow = await mcp.callTool("navigation_flow_validator", {
  startUrl: "https://example.com",
  steps: [
    { action: "click", selector: "a.login-link" },
    { action: "wait", waitTime: 1000 },
    { action: "fill", selector: "#username", value: "testuser" },
    { action: "fill", selector: "#password", value: "password123" },
    { action: "click", selector: "button[type='submit']" },
    { action: "wait", waitTime: 2000 },
    { action: "evaluate", script: "return document.title" }
  ],
  captureScreenshots: true,
  includeConsole: true
});
```

### 6. `dom_inspector`

Inspects DOM elements and their properties.

**Parameters:**
- `url` (string): URL to inspect
- `selector` (string): CSS selector to inspect
- `includeChildren` (boolean, optional): Whether to include children elements
- `includeStyles` (boolean, optional): Whether to include computed styles
- `waitTime` (number, optional): Time to wait before inspecting

**Example:**
```javascript
const elementInfo = await mcp.callTool("dom_inspector", {
  url: "https://example.com",
  selector: "header nav.main-nav",
  includeChildren: true,
  includeStyles: true
});
```

### Additional Tools

The server also provides these specialized tools:

- `console_monitor`: Monitor console logs on a page
- `performance_analysis`: Analyze page performance metrics
- `visual_comparison`: Compare two URLs visually
- `batch_screenshot_urls`: Take screenshots of multiple URLs
- `playwright_navigate`, `playwright_click`, etc.: Direct Playwright actions

### Visual Element Comparison

![Visual Comparison Screenshot](publicresources/screenshot2.png)

The visual comparison tool allows you to detect differences between UI states, making it perfect for regression testing and verifying visual changes.

## Integration with GLAMA

AI Vision Debug UI Automation fully integrates with the GLAMA ecosystem, providing:

- **One-click installation** through the GLAMA marketplace
- **Pre-configured templates** for common UI testing scenarios
- **Shareable configurations** across your team
- **Standardized interfaces** for use with other GLAMA-compatible tools

```json
// Example GLAMA integration configuration
{
  "name": "mcp-ai-vision-debug-ui-automation",
  "version": "1.0.0",
  "settings": {
    "port": 8080,
    "debugMode": true,
    "headless": true
  }
}
```

## Integration with Smithery

Smithery compatibility enables seamless integration into CI/CD workflows:

```yaml
# Example Smithery configuration
startCommand:
  type: stdio
  configSchema:
    type: object
    required:
      - port
    properties:
      port:
        type: number
        description: Port number for the MCP server
```

## Integration with Non-Vision Models

This server can be used with any LLM, not just those with vision capabilities. The screenshot annotations and analysis are processed into structured text descriptions that can be consumed by text-only models. This allows standard LLMs to:

1. Understand page structures and layouts
2. Locate interactive elements by descriptive attributes
3. Execute precise UI testing workflows
4. Analyze page contents and functionality

## Example Workflow

The following diagram illustrates a typical workflow:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│                 │    │                 │    │                 │
│  AI Assistant   │◄───┤  MCP Gateway    │◄───┤  AI Vision      │
│                 │    │                 │    │  Debug UI Auto  │
└────────┬────────┘    └─────────────────┘    └────────┬────────┘
         │                                             │
         │                                             │
         │                                             ▼
┌────────▼────────┐                          ┌─────────────────┐
│                 │                          │                 │
│  User Interface │                          │  Web Browser    │
│                 │                          │                 │
└─────────────────┘                          └─────────────────┘
```

## Troubleshooting

- **Connection Issues**: Ensure the MCP server is running and accessible
- **Playwright Errors**: If you encounter Playwright initialization errors, try reinstalling browsers with `npx playwright install --with-deps chromium`
- **Memory Issues**: For large workflows, monitor memory usage and consider restarting the server if performance degrades

### Common Errors

| Error | Solution |
|-------|----------|
| Browser launch failure | Check Playwright installation with `npx playwright install --with-deps` |
| Connection timeout | Verify network connectivity and firewall settings |
| Screenshot error | Ensure target URL is accessible and valid |
| Element not found | Verify selector syntax and wait for page load |

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the [ISC License](LICENSE). 