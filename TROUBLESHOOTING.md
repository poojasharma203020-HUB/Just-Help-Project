# Troubleshooting Guide

## Flutter Build Issues

### Issue: "flutter analyze" errors on first build
**Solution:**
```bash
cd apps/mobile
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
```

### Issue: Missing .g.dart files
**Solution:**
```bash
cd apps/mobile
dart run build_runner build --delete-conflicting-outputs
# Re-run: flutter run
```

### Issue: Android build fails - gradle wrapper
**Solution:**
```bash
cd apps/mobile/android
./gradlew wrapper --gradle-version 8.0
```

### Issue: iOS build fails - CocoaPods
**Solution:**
```bash
cd apps/mobile/ios
pod repo update
pod install
```

## Supabase Issues

### Issue: Migrations fail to apply
**Solution:**
```bash
cd apps/web
supabase status
supabase db push --dry-run  # Preview changes
supabase db push             # Apply changes
```

### Issue: provider_locations table missing
**Solution:**
```bash
# This migration creates the table if it doesn't exist
supabase db push
# The migration includes CREATE TABLE IF NOT EXISTS
```

## React Web Issues

### Issue: Environment variables not loading
**Solution:**
```bash
cd apps/web
cp .env.example .env
# Edit .env with your Supabase credentials
npm run dev
```

### Issue: Build fails - Node version
**Solution:**
```bash
node --version  # Should be 18.0.0 or higher
nvm use 18
npm install
npm run build
```

## Database Issues

### Issue: Foreign key constraint violations
**Solution:**
Check the order of migrations:
```bash
cd apps/web
supabase db list
supabase migration list
```

### Issue: RLS policies blocking queries
**Solution:**
1. Verify authentication token is valid
2. Check RLS policies in Supabase dashboard
3. Ensure user has correct role

## API/Edge Function Issues

### Issue: Edge functions not responding
**Solution:**
```bash
cd apps/web/supabase
supabase functions deploy
supabase functions serve  # Test locally
```

## Performance Issues

### Issue: Slow database queries
**Solution:**
1. Add database indexes
2. Optimize N+1 queries in client
3. Use caching (Redis/Memcached)

### Issue: Large APK size
**Solution:**
```bash
flutter build apk --release --split-per-abi
# Creates separate APKs for different CPU architectures
```

## Security Issues

### Issue: API keys exposed in logs
**Solution:**
- Use .env files (never commit)
- Enable secret masking in CI/CD
- Rotate compromised keys immediately

### Issue: CORS errors
**Solution:**
Update Supabase CORS settings:
```sql
-- In Supabase dashboard, configure CORS origins
```

## Common Fixes

### Clean Build
```bash
# Flutter
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs

# React
rm -rf node_modules package-lock.json
npm install

# Start fresh
flutter run  # or npm run dev
```

### Network Issues
```bash
# Check Supabase connectivity
curl https://your-project.supabase.co

# Verify firewall rules
# Check API status page
```

## Getting Help

1. Check error message carefully - often self-explanatory
2. Search [Flutter issues](https://github.com/flutter/flutter/issues)
3. Check [Supabase docs](https://supabase.com/docs)
4. Ask in [Flutter Discord](https://discord.gg/N7Qwnqvgvd)
5. Contact support with:
   - Error message (full)
   - Steps to reproduce
   - Environment details (OS, versions)
   - Relevant logs
