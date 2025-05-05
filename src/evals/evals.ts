//evals.ts

import { EvalConfig } from 'mcp-evals';
import { openai } from "@ai-sdk/openai";
import { grade, EvalFunction } from "mcp-evals";

const screenshot_urlEval: EvalFunction = {
    name: 'screenshot_url Evaluation',
    description: 'Evaluates the screenshot capturing functionality',
    run: async () => {
        const result = await grade(openai("gpt-4"), "Please take a full-page screenshot of https://example.com. Wait for the #main selector to appear, then wait 2000ms before capturing. Return the screenshot in base64 format.");
        return JSON.parse(result);
    }
};

const display_last_screenshotEval: EvalFunction = {
    name: 'display_last_screenshot Tool Evaluation',
    description: 'Evaluates the display_last_screenshot tool by requesting the last screenshot be displayed',
    run: async () => {
        const result = await grade(openai("gpt-4"), "Please display the last screenshot that was taken");
        return JSON.parse(result);
    }
};

const batch_screenshot_urlsEval: EvalFunction = {
    name: 'batch_screenshot_urls Tool Evaluation',
    description: 'Evaluates functionality for taking screenshots of multiple URLs and displaying them in a grid',
    run: async () => {
        const result = await grade(openai("gpt-4"), "Take screenshots of these URLs: 'https://example.com', 'https://google.com', 'https://github.com'. Capture full pages, wait 1000 ms before each screenshot, and display them in a 2x2 grid labeled with the respective domain names.");
        return JSON.parse(result);
    }
};

const screenshot_local_filesEval: EvalFunction = {
    name: 'screenshot_local_files',
    description: 'Evaluates the screenshot_local_files tool functionality',
    run: async () => {
        const result = await grade(openai("gpt-4"), "Could you please take screenshots of all HTML files in the 'public' directory matching '*.html'? Make them full-page screenshots and arrange them in a 2x2 grid.");
        return JSON.parse(result);
    }
};

const enhanced_page_analyzerEval: EvalFunction = {
    name: 'enhanced_page_analyzerEval',
    description: 'Evaluates the enhanced_page_analyzer tool',
    run: async () => {
        const result = await grade(openai("gpt-4"), "Please analyze the page at https://example.com with console logs, map interactive elements, capture a full page screenshot, and provide performance metrics. Wait 3000ms for the page to load before starting the analysis.");
        return JSON.parse(result);
    }
};

const config: EvalConfig = {
    model: openai("gpt-4"),
    evals: [screenshot_urlEval, display_last_screenshotEval, batch_screenshot_urlsEval, screenshot_local_filesEval, enhanced_page_analyzerEval]
};
  
export default config;
  
export const evals = [screenshot_urlEval, display_last_screenshotEval, batch_screenshot_urlsEval, screenshot_local_filesEval, enhanced_page_analyzerEval];