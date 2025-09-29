# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

Project scope and location
- The Flutter application lives in tracklet_pro/. Run all Flutter/Dart commands from that directory unless otherwise noted.

Common commands
- First-time setup
```bash path=null start=null
cd tracklet_pro
flutter pub get
```
- Run the app (pick a connected device or emulator)
```bash path=null start=null
cd tracklet_pro
flutter run
```
- Build artifacts
  - Android APK (debuggable quick build)
```bash path=null start=null
cd tracklet_pro
flutter build apk --debug
```
  - Android release APK / App Bundle
```bash path=null start=null
cd tracklet_pro
flutter build apk --release
flutter build appbundle --release
```
  - iOS release (macOS only)
```bash path=null start=null
cd tracklet_pro
flutter build ios --release
```
- Linting and static analysis (configured by analysis_options.yaml)
```bash path=null start=null
cd tracklet_pro
flutter analyze
```
- Format code (Dart formatter)
```bash path=null start=null
cd tracklet_pro
dart format .
```
- Tests
  - Run all tests
```bash path=null start=null
cd tracklet_pro
flutter test
```
  - Run a single test file
```bash path=null start=null
cd tracklet_pro
flutter test test/widget_test.dart
```
  - Run tests matching a name pattern
```bash path=null start=null
cd tracklet_pro
flutter test -n "App loads successfully"
```

High-level architecture
- Entry and app initialization
  - lib/main.dart initializes Flutter bindings, locks orientation to portrait, sets a global FlutterError handler, initializes a simple Injector, then boots TrackletApp.
  - TrackletApp composes a MultiProvider using AppProviders.providers and builds a MaterialApp with theme from core/constants/theme/theme_constants.dart, and routing via AppRouter.generateRoute. Initial route is '/'.

- Routing
  - core/routes/app_router.dart centralizes route names and onGenerateRoute. Key routes include '/': PlantBottomNavbar and '/employee': EmployeeScreen. Add new routes here to keep navigation consistent.

- State management
  - Provider (package:provider) with ChangeNotifier is the primary state management approach.
  - multi_provider/app_provider.dart aggregates all ChangeNotifierProvider registrations (e.g., LoginProvider, BottomNavProvider, OrdersProvider, HomeProvider, etc.). New feature providers should be registered here to be available app-wide.

- Dependency injection / service locator
  - di/injector.dart is a minimal static service locator. It currently exposes OrderRepository and is initialized in main() before runApp(). Providers that need repositories pull them from Injector (e.g., HomeProvider(repository: Injector.orderRepository)). This can be swapped with get_it in the future without changing callsites.

- Feature-first organization with light layering
  - Features reside under lib/features/<feature> with typical sub-areas:
    - domain: models, repositories (interfaces or simple classes), and feature-level providers
    - presentation: screens, widgets, and presentation-specific providers
    - Some features (e.g., plant -> order) also include a data/ folder for stub repositories and dummy data used by providers.
  - Example: features/plant/presentation/screens/order has OrdersProvider that maintains completed/cancelled lists and is seeded with dummy data; a stub OrderRepository simulates persistence.

- Core and shared modules
  - core/constants: assets, colors, dimensions, strings, and theme; use these instead of hard-coding values.
  - core/utils: cross-cutting helpers (logging, navigation, network, permissions, prefs, validation, dates, snackbars). Use these utilities from features to avoid duplicating logic.
  - shared/: reusable UI components (dialogs, widgets), extensions, mixins, and shared models.

- Theming and assets
  - The app theme lives in core/constants/theme/theme_constants.dart. Follow this when adding components to ensure consistent light/dark theming.
  - Assets are declared in pubspec.yaml under flutter/assets for assets/icons/ and assets/images/. Place new assets in those folders and run flutter pub get if the pubspec is updated.

- Platforms and builds
  - Android Gradle is configured with Kotlin DSL (android/build.gradle.kts and android/app/build.gradle.kts). Release builds currently use the debug signing config; configure a proper release signing config before distributing.
  - iOS project is present under ios/Runner. Build commands must be run on macOS for iOS targets.

Testing
- Tests live under test/. The repository includes a simple widget test (test/widget_test.dart). Use the single-file and name-filter commands above to iterate quickly on specific tests.

Environment and versions
- pubspec.yaml specifies environment sdk: ^3.8.1. Use a Flutter SDK that bundles a compatible Dart SDK (Dart >= 3.8). Verify with:
```bash path=null start=null
flutter --version
```

Notes derived from repository docs
- README.md is the standard Flutter template with links to Flutter documentation; it does not add project-specific commands beyond what’s listed here.

There are no CLAUDE, Cursor, or Copilot rule files in this repo at the time of writing.
