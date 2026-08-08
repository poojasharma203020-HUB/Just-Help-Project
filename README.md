# JustHelp — Full Stack Service Platform

A comprehensive two-client, one-backend architecture for a service marketplace.

```
apps/
  mobile/    Flutter app  — customer, provider, vendor, delivery
  web/       React app    — admin, website, and the same four surfaces
             web/supabase/  ← the database. Migrations + edge functions.
.github/workflows/
  build-apk.yml
  build-ios.yml
  deploy-web.yml
```

## Platform Coverage

| Feature | Flutter (Mobile) | React (Web) |
|---------|------------------|-------------|
| Customer | ✅ 34 screens | ✅ |
| Provider | ✅ 20 screens | ✅ |
| Vendor | ✅ 23 screens | ✅ |
| Delivery | ✅ 13 screens | ✅ |
| **Admin** | ❌ | ✅ **28 pages** |
| Public Website | ❌ | ✅ |

## Project Status: Deployment Ready ✅

- ✅ All code compiled and analyzer errors fixed
- ✅ Database migrations verified
- ✅ CI/CD pipelines configured
- ✅ Security and secrets management set up
- ✅ Production build configurations ready
- ✅ Testing framework integrated

## Quick Start

### Web App (React)
```bash
cd apps/web
npm install
cp .env.example .env
npm run dev
```

### Mobile App (Flutter)
```bash
cd apps/mobile
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run --dart-define-from-file=env/dev.json
```

### Deploy to Production
```bash
# Android APK (signed release build)
flutter build apk --release --dart-define-from-file=env/prod.json

# iOS App (requires Mac)
flutter build ios --release --dart-define-from-file=env/prod.json

# Web deployment
cd apps/web
npm run build
```

## Documentation

All detailed documentation is located in `apps/mobile/docs/`:

- **[DEPLOYMENT.md](apps/mobile/docs/DEPLOYMENT.md)** - Complete deployment guide
- **[SECURITY.md](apps/mobile/docs/SECURITY.md)** - Security best practices
- **[TESTING.md](apps/mobile/docs/TESTING.md)** - Testing guidelines
- **[DATABASE.md](apps/mobile/docs/DATABASE.md)** - Database schema and migrations
- **[API.md](apps/mobile/docs/API.md)** - API endpoint reference

## Architecture

### Backend: Supabase
- 49 PostgreSQL tables
- 4 edge functions for business logic
- Real-time subscriptions
- Row-level security (RLS) policies

### Frontend: Flutter & React
- Shared Dart/TypeScript models
- Identical business logic
- Platform-specific UI
- Offline-first architecture

## Support & Troubleshooting

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for common issues and solutions.

## License

All rights reserved.
