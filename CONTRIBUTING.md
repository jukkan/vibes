# Contributing Tools to vibes.jukkan.com

## Overview
This is a collection of single-file HTML utilities. Tools are built with AI assistance (primarily Claude Code) and must follow strict conventions for consistency.

## File Structure Rules

### Single-file HTML only
- All CSS inlined in `<style>` tags
- All JavaScript inlined in `<script>` tags  
- External dependencies loaded from CDN only (cdnjs.com, jsdelivr.com, unpkg.com)
- File naming: `kebab-case.html` (e.g., `capacity-calculator.html`)

### No build steps
- ❌ No React, Vue, Svelte, Angular
- ❌ No npm, webpack, vite, rollup
- ❌ No TypeScript, JSX, or transpilation
- ✅ Vanilla HTML/CSS/JavaScript only
- ✅ Works by opening HTML file directly in browser

### File location
- Tools at repo root (e.g., `/capacity-calculator.html`)
- URLs: `vibes.jukkan.com/capacity-calculator.html`
- Move to `/tools/` subdirectory only when 20+ tools exist

## Tool Requirements

### 1. Mobile-first responsive design
```css
/* Use viewport meta tag */
<meta name="viewport" content="width=device-width, initial-scale=1">

/* Mobile breakpoints */
@media (max-width: 640px) { /* Mobile styles */ }
@media (min-width: 641px) { /* Tablet+ styles */ }
```

### 2. Consistent header/footer
Every tool must include:

**Header:**
```html
<header style="padding: 20px; background: #1d1d1d; color: white;">
  <a href="/" style="color: #0078d4; text-decoration: none;">← vibes</a>
  <h1>Tool Name</h1>
  <p>Brief one-line description</p>
</header>
```

**Footer:**
```html
<footer style="padding: 20px; text-align: center; color: #666;">
  <a href="/">← Back to launcher</a> | 
  <a href="https://github.com/jukkan/vibes">View source</a>
</footer>
```

### 3. State management patterns

**URL hash for shareable state:**
```javascript
// Save state to URL
function saveState(state) {
  location.hash = JSON.stringify(state);
}

// Load state from URL
function loadState() {
  if (location.hash) {
    return JSON.parse(decodeURIComponent(location.hash.slice(1)));
  }
  return {};
}
```

**localStorage for secrets only:**
```javascript
// API keys, tokens - NEVER in URL
function getApiKey() {
  let key = localStorage.getItem('apiKey');
  if (!key) {
    key = prompt('Enter API key (stored locally):');
    localStorage.setItem('apiKey', key);
  }
  return key;
}
```

### 4. Copy-to-clipboard pattern
```javascript
async function copyToClipboard(text) {
  await navigator.clipboard.writeText(text);
  // Show visual feedback
  button.textContent = '✓ Copied!';
  setTimeout(() => { button.textContent = 'Copy'; }, 2000);
}
```

### 5. Error handling
```javascript
try {
  // Operation
} catch (err) {
  document.getElementById('error').textContent = 
    `Error: ${err.message}`;
  console.error(err);
}
```

## Updating the Launcher

When adding a new tool, update `index.html`:

1. Add entry to `tools` array:
```javascript
const tools = [
  // Existing tools...
  {
    name: "Your Tool Name",
    description: "One-sentence description under 60 chars",
    color: "#0078d4", // Pick from Metro palette
    path: "your-tool-name.html"
  }
];
```

2. Metro color palette:
- Blue: `#0078d4` (default/general utilities)
- Green: `#107c10` (success/creation tools)
- Orange: `#ff8c00` (warning/calculation tools)
- Red: `#e81123` (debugging/analysis tools)
- Purple: `#5c2d91` (creative/transformation tools)
- Teal: `#008272` (data/API tools)

## Dependency Guidelines

### Allowed CDNs
- cdnjs.cloudflare.com
- cdn.jsdelivr.net
- unpkg.com

### Common dependencies
- **JSON formatting:** No library needed (use `JSON.stringify(obj, null, 2)`)
- **Syntax highlighting:** highlight.js from CDN
- **Markdown rendering:** marked.js from CDN
- **YAML parsing:** js-yaml from CDN
- **CSV parsing:** papaparse from CDN
- **Date handling:** day.js from CDN (not moment.js - too heavy)
- **Charts:** Chart.js or lightweight alternatives

### Avoid heavy dependencies
- ❌ Lodash (use native JS methods)
- ❌ jQuery (use vanilla DOM)
- ❌ Moment.js (use day.js or native)
- ❌ Bootstrap (write minimal custom CSS)

## Code Style

### Minimal, readable
- Prefer clarity over cleverness
- Comment complex logic
- Use descriptive variable names
- Keep functions under 50 lines

### CSS
```css
/* Inline styles acceptable for single-file constraint */
/* Use CSS custom properties for theming */
:root {
  --primary: #0078d4;
  --bg: #1d1d1d;
  --text: #ffffff;
}
```

### JavaScript
```javascript
// Modern ES6+ is fine (async/await, arrow functions, etc.)
// No TypeScript
// Avoid classes unless genuinely needed (functions preferred)
```

## Testing Checklist

Before committing a new tool:

- [ ] Opens in browser without errors (check console)
- [ ] Works offline (except CDN dependencies)
- [ ] Responsive on mobile (test in DevTools)
- [ ] Copy-to-clipboard works
- [ ] State persists in URL hash (if applicable)
- [ ] Footer links work
- [ ] Added to launcher in index.html
- [ ] No console warnings
- [ ] File size under 100KB (preferably under 50KB)

## AI Agent Workflow

1. Ask user for tool requirements
2. Read this CONTRIBUTING.md
3. Check existing tools for similar patterns
4. Build tool following templates
5. Update index.html launcher
6. Test locally
7. Commit with message: "Add [tool-name]: [description]"

## Example Commit Messages
```
Add capacity-calculator: Dataverse storage entitlement tool
Add flow-formatter: Format Power Automate action JSON
Fix license-comparator: Handle missing SKU data
Update launcher: Add 3 new Power Platform tools
```

## Questions?
Open an issue or ask @jukkan
