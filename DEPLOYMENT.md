# 🚀 Civil Beredskap - Web Deployment Guide

This guide explains how to deploy the Civil Beredskap Flutter app to Vercel as a web application.

---

## ✅ Prerequisites Completed

- ✅ Flutter web support enabled
- ✅ Web platform files created
- ✅ Dependencies updated (url_strategy added)
- ✅ Platform detection utilities created
- ✅ Responsive design utilities created
- ✅ Vercel configuration files created
- ✅ App already running successfully on Chrome

---

## 🌐 Current Status

**Your app is already running on web!**
- Debug service: `ws://127.0.0.1:55803/mvQfeLCSVuQ=/ws`
- The app loads successfully with all features working

---

## 📦 Deployment Methods

### Method 1: Vercel CLI (Recommended - Fastest)

```bash
# 1. Install Vercel CLI globally
npm i -g vercel

# 2. Login to Vercel
vercel login

# 3. Navigate to project root
cd "g:/Windsurf Workspace/civil_prep_app"

# 4. Deploy to Vercel
vercel

# Follow the prompts:
# - Set up and deploy? Y
# - Which scope? (select your account)
# - Link to existing project? N
# - Project name? civil-beredskap-test
# - Directory? ./
# - Override settings? N

# 5. Your app will be live at:
# https://civil-beredskap-test.vercel.app

# 6. For production deployment:
vercel --prod
```

---

### Method 2: GitHub + Vercel (Automatic Deployments)

```bash
# 1. Commit and push your changes
git add .
git commit -m "Add web version with Vercel configuration"
git push origin main

# 2. Go to https://vercel.com
# 3. Click "Add New Project"
# 4. Click "Import Git Repository"
# 5. Select "SanorSmith/civil_prep_app"
# 6. Configure build settings:
#    - Framework Preset: Other
#    - Build Command: flutter build web --release --web-renderer canvaskit
#    - Output Directory: build/web
#    - Install Command: flutter pub get
# 7. Click "Deploy"

# ✨ Now every push to main = automatic deployment!
```

---

### Method 3: Manual Build + Upload

```bash
# 1. Build the web version locally
flutter build web --release --web-renderer canvaskit

# 2. Go to https://vercel.com
# 3. Click "Add New Project"
# 4. Drag and drop the "build/web" folder
# 5. Click "Deploy"
```

---

## 🧪 Local Testing

### Test in Development Mode
```bash
# Run in Chrome
flutter run -d chrome

# Run in Edge
flutter run -d edge
```

### Test Production Build Locally
```bash
# Build for production
flutter build web --release

# Serve locally (requires Python)
cd build/web
python -m http.server 8000

# Visit: http://localhost:8000
```

---

## 📋 Pre-Deployment Checklist

Before deploying, verify:

- ✅ App loads without errors in Chrome
- ✅ All navigation works (language selection → onboarding → home → settings)
- ✅ Language switching works (Swedish ↔ English)
- ✅ Theme switching works (Light ↔ Dark)
- ✅ Forms work (postal code, household size, etc.)
- ✅ Data persists after page refresh
- ✅ No console errors in browser DevTools (F12)
- ✅ Responsive layout works on mobile/tablet/desktop

---

## 🔧 Configuration Files Created

### 1. `vercel.json`
- Build command configured
- Output directory set to `build/web`
- URL rewrites for SPA routing
- Cache headers optimized

### 2. `.vercelignore`
- Excludes unnecessary files from deployment
- Keeps deployment fast and clean

### 3. `lib/core/utils/platform_utils.dart`
- Platform detection (Web, Android, iOS)
- Feature support checks
- Web-safe implementations

### 4. `lib/core/utils/responsive.dart`
- Responsive breakpoints (mobile, tablet, desktop)
- Adaptive padding and max-width
- Screen size utilities

---

## 🎯 Features

### ✅ Fully Functional Web App
- Complete bilingual support (Swedish ↔ English)
- Light and dark themes
- All onboarding screens
- Home screen with categories
- Settings screen
- Data persistence (SharedPreferences)

### ✅ Web-Optimized
- CanvasKit renderer for best performance
- Responsive design for all screen sizes
- Progressive Web App (PWA) support
- Service worker for offline capability
- Optimized loading screen

### ✅ Test Mode Features
- Orange "TEST VERSION" badge
- Platform detection utilities
- Debug information available
- Easy data reset

---

## 🌍 Post-Deployment

After deployment, your app will be available at:
- **Preview URL**: `https://civil-beredskap-test-[random].vercel.app`
- **Production URL**: `https://civil-beredskap-test.vercel.app`

### Test on Multiple Devices
- ✅ Desktop Chrome (Windows/Mac)
- ✅ Desktop Firefox
- ✅ Desktop Safari (Mac)
- ✅ Mobile Chrome (Android)
- ✅ Mobile Safari (iPhone)
- ✅ iPad Safari

---

## 🐛 Common Issues & Solutions

### Issue: "MissingPluginException"
**Solution**: Some plugins don't work on web. Use `PlatformUtils.isWeb` to conditionally disable them.

### Issue: Images not loading
**Solution**: Ensure images are in `assets/` folder and declared in `pubspec.yaml`.

### Issue: Fonts not showing
**Solution**: Declare fonts in `pubspec.yaml` under `flutter > fonts`.

### Issue: CORS errors with Supabase
**Solution**: Configure allowed origins in Supabase dashboard.

### Issue: Build fails on Vercel
**Solution**: Check Vercel build logs. Ensure Flutter SDK is available.

---

## 📊 Build Information

- **Flutter Version**: 3.x
- **Web Renderer**: CanvasKit
- **Target Platforms**: Web (Chrome, Firefox, Safari, Edge)
- **Deployment Platform**: Vercel
- **Build Output**: `build/web/`

---

## 🎉 Next Steps

1. **Deploy Now**: Run `vercel` in your terminal
2. **Test Thoroughly**: Visit the deployed URL and test all features
3. **Share**: Send the URL to testers for feedback
4. **Iterate**: Make improvements based on feedback
5. **Go Live**: Deploy to production with `vercel --prod`

---

## 📞 Support

If you encounter issues:
1. Check browser console (F12) for errors
2. Review Vercel deployment logs
3. Verify all configuration files are correct
4. Test locally first with `flutter run -d chrome`

---

**Your app is ready for deployment! 🚀**

Run `vercel` to deploy now!
