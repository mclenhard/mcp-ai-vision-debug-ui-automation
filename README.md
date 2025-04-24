# AI Vision Debug MCP Server

[![MCP on Glama](https://modelcontextprotocol.ai/badge/samihalawa/mcp-server-ai-vision)](https://gateway.glama.ai/servers/samihalawa/mcp-server-ai-vision)

A ModelContextProtocol (MCP) server that gives AI models the ability to analyze, debug, and interact with web interfaces through Playwright. This server enables any AI (even those without vision capabilities) to visually inspect web pages, test UI functionality, and validate user workflows.

## How to Use This MCP Server

This MCP server is designed to be integrated with AI systems through the Model Context Protocol. There are three main ways to use it:

1. **With Glama**: Install via Glama Gateway for seamless integration with Glama models
2. **With custom MCP clients**: Connect your own AI clients using the MCP protocol
3. **Standalone for testing**: Run locally during development

Once connected, your AI model can call the available tools to interact with web interfaces, helping it to:

- **Capture visual information** from web pages and interpret the contents
- **Map and interact with UI elements** like buttons, forms, and navigational elements
- **Validate user workflows** by simulating actual user interactions
- **Debug web applications** by tracking console logs, performance metrics, and network activity
- **Test API endpoints** to verify backend functionality

## Installation

### Using Glama Gateway

The recommended way to install this MCP server is through the [Glama Gateway](https://gateway.glama.ai/servers/samihalawa/mcp-server-ai-vision):

1. Visit the server page on Glama Gateway
2. Click "Install Server"
3. Follow the guided installation steps

### Manual Installation 

If you prefer to install manually:

```bash
# Clone the repository
git clone https://github.com/samihalawa/mcp-server-ai-vision.git
cd mcp-server-ai-vision

# Install dependencies
npm install

# Build the project
npm run build

# Start the server
npm start
```

### Docker Deployment

For containerized deployment:

```bash
# Build the Docker image
docker build -t mcp-ai-vision .

# Run the container
docker run -p 8080:8080 mcp-ai-vision
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

## Integration with Non-Vision Models

This server can be used with any LLM, not just those with vision capabilities. The screenshot annotations and analysis are processed into structured text descriptions that can be consumed by text-only models. This allows standard LLMs to:

1. Understand page structures and layouts
2. Locate interactive elements by descriptive attributes
3. Execute precise UI testing workflows
4. Analyze page contents and functionality

## Troubleshooting

- **Connection Issues**: Ensure the MCP server is running and accessible
- **Playwright Errors**: If you encounter Playwright initialization errors, try reinstalling browsers with `npx playwright install --with-deps chromium`
- **Memory Issues**: For large workflows, monitor memory usage and consider restarting the server if performance degrades

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the [ISC License](LICENSE). 