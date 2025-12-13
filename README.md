# vibes.jukkan.com

A collection of single-file HTML utilities built with Metro design language.

## 🚀 Live Site

- **Production**: [vibes.jukkan.com](https://vibes.jukkan.com)
- **GitHub Pages**: [jukkan.github.io/vibes](https://jukkan.github.io/vibes)

## 🎨 Design

The launcher uses Windows Phone 8 Metro design language:
- Flat, colorful tiles with no borders or shadows
- Segoe UI typography
- Dark background with bold accent colors
- Responsive grid layout

## 🛠️ Available Tools

### Image to Base64
Convert images to Base64 data URLs for embedding in HTML/CSS.

### JSON Formatter
Format and validate JSON data with multiple indent options.

### Text Diff
Compare two text blocks with line-by-line difference highlighting.

## 📦 Deployment

### Automatic (Recommended)

The site automatically deploys to GitHub Pages when you push to `main`:

1. Merge your changes to `main`
2. GitHub Actions will automatically deploy
3. Visit https://vibes.jukkan.com after ~1 minute

You can also trigger manual deployment:
1. Go to [Actions tab](https://github.com/jukkan/vibes/actions)
2. Select "Deploy to GitHub Pages"
3. Click "Run workflow"

### Manual

Run the deployment script:

```bash
./deploy.sh
```

This will:
- Check for uncommitted changes
- Commit if needed
- Push to the current branch
- Provide GitHub Pages setup instructions

## ⚙️ GitHub Pages Setup

### First-time Setup

1. **Enable GitHub Pages**
   - Go to Settings → Pages
   - Source: GitHub Actions (recommended) or Deploy from branch
   - Branch: `main` (if using branch deployment)

2. **Configure Custom Domain** (optional)
   - In Pages settings, add custom domain: `vibes.jukkan.com`
   - Update DNS records:
     ```
     CNAME: vibes.jukkan.com → jukkan.github.io
     ```
   - Wait for DNS propagation (~15 minutes)

3. **Enable HTTPS**
   - Automatically enabled after DNS verification
   - Check "Enforce HTTPS" in Pages settings

### Troubleshooting

- **404 errors**: Wait a few minutes after deployment
- **DNS issues**: Verify CNAME record with `dig vibes.jukkan.com`
- **Build failures**: Check [Actions tab](https://github.com/jukkan/vibes/actions) for errors

## 🏗️ Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on adding new tools.

### Quick Start

1. Read CONTRIBUTING.md for conventions
2. Create tool HTML file (e.g., `my-tool.html`)
3. Follow single-file HTML pattern
4. Add consistent header/footer
5. Update `index.html` to add tile
6. Test locally
7. Commit and push

### File Structure

```
/
├── index.html              # Metro launcher
├── image-to-base64.html    # Example tool 1
├── json-formatter.html     # Example tool 2
├── text-diff.html          # Example tool 3
├── deploy.sh               # Manual deployment script
├── CONTRIBUTING.md         # Contribution guidelines
└── .github/
    └── workflows/
        └── deploy.yml      # GitHub Actions workflow
```

## 🎯 Design Principles

- **Zero build step**: Drag folder to GitHub, works immediately
- **Single-file tools**: All CSS/JS inline, no dependencies
- **Mobile-first**: Responsive design for all screen sizes
- **Fast loading**: Minimal code, no heavy frameworks
- **Shareable**: URL hash for state persistence

## 📝 License

See repository license.

## 🤝 Credits

Built with AI assistance (Claude Code).
