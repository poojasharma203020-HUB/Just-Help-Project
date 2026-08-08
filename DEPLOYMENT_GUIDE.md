# Deployment Guide - JustHelp Platform

## Pre-Deployment Checklist

### 1. Environment Setup
- [ ] Create Supabase project
- [ ] Get project URL and anon key
- [ ] Generate Firebase project ID
- [ ] Create signing keystore for Android
- [ ] Prepare Apple Developer certificates for iOS

### 2. Configuration Files

#### Android (`apps/mobile/android/app/build.gradle`)
```gradle
signingConfigs {
    release {
        keyAlias 'justhelp-release'
        keyPassword 'YOUR_KEY_PASSWORD'
        storeFile file('/path/to/upload-keystore.jks')
        storePassword 'YOUR_STORE_PASSWORD'
    }
}
```

#### Environment Files
```bash
# apps/mobile/env/prod.json
{
  "SUPABASE_URL": "https://your-project.supabase.co",
  "SUPABASE_ANON_KEY": "your-anon-key",
  "FIREBASE_PROJECT_ID": "your-firebase-id",
  "API_ENDPOINT": "https://api.justhelp.com"
}

# apps/web/.env
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key
VITE_API_ENDPOINT=https://api.justhelp.com
```

### 3. Database Migration

```bash
cd apps/web
supabase link --project-ref your-project-ref
supabase db push
```

## Building for Production

### Android APK Release Build

```bash
cd apps/mobile

# Build signed APK
flutter build apk --release \
  --dart-define-from-file=env/prod.json

# Output: build/app/outputs/apk/release/app-release.apk
```

### iOS Release Build

```bash
cd apps/mobile

# Build signed IPA
flutter build ios --release \
  --dart-define-from-file=env/prod.json

# Follow Xcode archive and export steps
```

### Web Production Build

```bash
cd apps/web
npm run build
# Output: dist/

# Deploy to your hosting (Vercel, Netlify, etc.)
```

## Deployment Platforms

### Google Play Store (Android)
1. Create Google Play Developer account
2. Sign APK with release keystore
3. Upload to Google Play Console
4. Configure pricing, description, screenshots
5. Submit for review (24-48 hours)

### Apple App Store (iOS)
1. Create Apple Developer account
2. Create iOS App ID
3. Build signed IPA
4. Upload with Transporter
5. Configure in App Store Connect
6. Submit for review (24-48 hours)

### Web Hosting

#### Option A: Vercel (Recommended)
```bash
npm install -g vercel
cd apps/web
vercel --prod
```

#### Option B: Netlify
```bash
npm install -g netlify-cli
cd apps/web
netlify deploy --prod
```

#### Option C: Docker
```bash
cd apps/web
docker build -t justhelp-web .
docker run -p 80:3000 justhelp-web
```

## Post-Deployment

### Monitoring
- [ ] Set up error tracking (Sentry)
- [ ] Configure analytics
- [ ] Monitor Supabase logs
- [ ] Set up alerts for critical errors

### Updates & Maintenance
- [ ] Plan hot fix process
- [ ] Schedule regular backups
- [ ] Monitor app store reviews
- [ ] Track user feedback

## Rollback Procedure

If critical issues occur post-deployment:

```bash
# Git revert to last stable version
git revert <commit-hash>
git push origin main

# Rebuild and redeploy
./scripts/deploy.sh
```

## Support & Troubleshooting

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for common deployment issues.
