# AI Vision Debug MCP Server

[![MCP on Glama](https://modelcontextprotocol.ai/badge/samihalawa/mcp-server-ai-vision)](https://gateway.glama.ai/servers/samihalawa/mcp-server-ai-vision)

A ModelContextProtocol (MCP) server that gives AI models the ability to analyze, debug, and interact with web interfaces through Playwright. This server enables any AI (even those without vision capabilities) to visually inspect web pages, test UI functionality, and validate user workflows.

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

## Usage Examples

### Capture and Analyze a Web Page

```javascript
// Example using the enhanced_page_analyzer tool
const result = await mcp.callTool("enhanced_page_analyzer", {
  url: "https://example.com",
  includeConsole: true,
  mapElements: true,
  fullPage: true
});

// The result contains a complete analysis of the page:
// - Interactive elements (buttons, links, forms)
// - Console logs
// - Performance metrics
// - Screenshots (annotated and plain)
```

### Validate a User Workflow

```javascript
// Example using the ui_workflow_validator tool
const workflow = await mcp.callTool("ui_workflow_validator", {
  startUrl: "https://example.com/login",
  taskDescription: "User login flow validation",
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
      description: "Verify successful login",
      action: "verifyElementVisible",
      selector: ".dashboard-welcome"
    }
  ],
  captureScreenshots: "failure"
});

// The result contains the success/failure status of each step,
// screenshots of any failures, and an overall workflow status
```

## Tools Reference

The server provides the following tools:

| Tool | Description |
|------|-------------|
| `screenshot_url` | Capture screenshot of a URL |
| `enhanced_page_analyzer` | Analyze page with screenshots, console logs, element mapping |
| `ui_workflow_validator` | Execute and validate a sequence of UI interactions |
| `api_endpoint_tester` | Test multiple API endpoints and verify responses |
| `navigation_flow_validator` | Test a sequence of user actions across pages |
| `dom_inspector` | Inspect DOM elements and their properties |
| `console_monitor` | Monitor console logs on a page |
| `performance_analysis` | Analyze page performance metrics |
| `visual_comparison` | Compare two URLs visually and highlight differences |
| `batch_screenshot_urls` | Screenshot multiple URLs in a grid |
| `playwright_*` | Direct Playwright actions (navigate, click, fill, etc.) |

## Text-Only Model Compatibility

This server is designed to work with all AI models, not just those with vision capabilities. Screenshot analysis is transformed into structured text representations of web interfaces, enabling any text-based model to:

1. Understand page structures and layouts
2. Locate interactive elements by descriptive attributes
3. Execute precise UI testing workflows
4. Analyze page contents and functionality

## License

This project is licensed under the [ISC License](LICENSE).

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. 