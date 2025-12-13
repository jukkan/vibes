#!/bin/bash

# Deploy vibes.jukkan.com to GitHub Pages
# This script pushes the current branch and provides GitHub Pages setup instructions

set -e

echo "🚀 Deploying vibes.jukkan.com"
echo ""

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo "❌ Error: Not in a git repository"
  exit 1
fi

# Get current branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "📍 Current branch: $CURRENT_BRANCH"

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
  echo "⚠️  Warning: You have uncommitted changes"
  echo ""
  git status --short
  echo ""
  read -p "Do you want to commit these changes? (y/n) " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📝 Committing changes..."
    git add .
    git commit -m "Deploy: Update site content"
  else
    echo "❌ Deployment cancelled. Please commit or stash your changes."
    exit 1
  fi
fi

# Push to remote
echo ""
echo "📤 Pushing to origin/$CURRENT_BRANCH..."

# Retry logic for push with exponential backoff
MAX_RETRIES=4
RETRY_COUNT=0
WAIT_TIME=2

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
  if git push -u origin "$CURRENT_BRANCH"; then
    echo "✅ Successfully pushed to origin/$CURRENT_BRANCH"
    break
  else
    RETRY_COUNT=$((RETRY_COUNT + 1))
    if [ $RETRY_COUNT -lt $MAX_RETRIES ]; then
      echo "⚠️  Push failed. Retrying in ${WAIT_TIME}s... (Attempt $RETRY_COUNT/$MAX_RETRIES)"
      sleep $WAIT_TIME
      WAIT_TIME=$((WAIT_TIME * 2))
    else
      echo "❌ Push failed after $MAX_RETRIES attempts"
      exit 1
    fi
  fi
done

echo ""
echo "✨ Deployment complete!"
echo ""
echo "📋 Next steps to enable GitHub Pages:"
echo ""
echo "1. Go to: https://github.com/jukkan/vibes/settings/pages"
echo "2. Under 'Build and deployment':"
echo "   - Source: Deploy from a branch"
echo "   - Branch: Select '$CURRENT_BRANCH' and '/ (root)'"
echo "   - Click 'Save'"
echo ""
echo "3. Configure custom domain (optional):"
echo "   - In the 'Custom domain' field, enter: vibes.jukkan.com"
echo "   - Click 'Save'"
echo "   - Update your DNS records:"
echo "     - Add CNAME record: vibes.jukkan.com → jukkan.github.io"
echo ""
echo "4. Wait a few minutes for deployment"
echo "   - Check status at: https://github.com/jukkan/vibes/deployments"
echo ""
echo "🌐 Your site will be available at:"
echo "   - https://jukkan.github.io/vibes (GitHub domain)"
echo "   - https://vibes.jukkan.com (custom domain, after DNS setup)"
echo ""
