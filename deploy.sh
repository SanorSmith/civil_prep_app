#!/bin/bash

# Civil Beredskap - Quick Deployment Script
# This script builds and deploys the Flutter web app to Vercel

echo "🚀 Civil Beredskap - Deployment Script"
echo "======================================="
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -n 1)"
echo ""

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "⚠️  Vercel CLI not found. Installing..."
    npm i -g vercel
fi

echo "✅ Vercel CLI found"
echo ""

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean
echo ""

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get
echo ""

# Build web version
echo "🔨 Building web version..."
flutter build web --release --web-renderer canvaskit
echo ""

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo ""
    
    # Ask user if they want to deploy
    read -p "Deploy to Vercel now? (y/n) " -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "🚀 Deploying to Vercel..."
        vercel --prod
        echo ""
        echo "✅ Deployment complete!"
    else
        echo "ℹ️  Build complete. Run 'vercel --prod' to deploy manually."
    fi
else
    echo "❌ Build failed. Please check the errors above."
    exit 1
fi
