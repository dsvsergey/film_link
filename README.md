# FilmLink

A cross-platform Flutter application for collecting, organizing, and searching links — designed around user-owned directories with full-text search and archiving. FilmLink is built on a Clean Architecture foundation with Riverpod for state management and Supabase as the backend.

## Features

- **Email/password authentication** backed by Supabase, with sessions persisted in `flutter_secure_storage`.
- **Personal link library** scoped per user, with create / update / delete and an archive flag.
- **Directories** for grouping related links, including per-directory listings.
- **Full-text search** across both links and directories.
- **Auth-aware routing** — unauthenticated users are redirected to sign-in on every navigation.
- **Material 3** themed UI with light/dark mode support that follows the system setting.

## Tech Stack

| Concern              | Library                                              |
| -------------------- | ---------------------------------------------------- |
| Framework            | Flutter (Dart SDK `^3.9.2`)                          |
| State management & DI| `flutter_riverpod` 3 + `riverpod_generator`          |
| Navigation           | `go_router`                                          |
| Backend              | `supabase_flutter` (Postgres + Auth)                 |
| Secure storage       | `flutter_secure_storage`                             |
| Functional core      | `dartz` (`Either<Failure, T>`)                       |
| Immutable models     | `freezed` + `json_serializable`                      |
| Lints                | `flutter_lints`                                      |

## Architecture

The codebase follows Clean Architecture, applied per feature:

```
lib/
├── core/                       # Cross-cutting infrastructure
│   ├── config/                 # SupabaseConfig (env-based credentials)
│   ├── error/                  # Failure / Exception hierarchies
│   ├── router/                 # GoRouter + auth-redirect guard
│   ├── usecases/               # UseCase<Type, Params> base contract
│   ├── network/                # Connectivity helpers
│   ├── constants/              # Storage keys, etc.
│   └── utils/                  # Logger, helpers
└── features/
    ├── auth/
    │   ├── data/               # Supabase + secure-storage data sources, models, repository impl
    │   ├── domain/             # Pure entities, repository contract, use cases
    │   └── presentation/       # Pages, widgets, Riverpod providers + state notifiers
    └── links/
        ├── data/
        ├── domain/
        └── presentation/
```

### Conventions

- **Either-based error handling.** Repositories and use cases return `Future<Either<Failure, T>>`. Datasources throw typed exceptions (`AuthException`, `ServerException`, `CacheException`); repositories translate them into `AuthFailure`, `ServerFailure`, `NetworkFailure`, etc.
- **Use cases** extend `UseCase<Type, Params>` (see `lib/core/usecases/usecase.dart`). Parameter-less ones take `NoParams`.
- **Riverpod wiring is layered.** Each feature exposes a `*_providers.dart` (datasource → repository → use cases) and a `*_state_provider.dart` exposing a freezed sealed state union (`Initial | Loading | Loaded | Error`) consumed by the UI.
- **Single Supabase client provider.** All remote datasources depend on `supabaseClientProvider` rather than reaching for `Supabase.instance.client` directly.

## Project Structure (data model)

| Table       | Description                                                  |
| ----------- | ------------------------------------------------------------ |
| `link`      | A saved URL with optional title, description, archive flag, and a `directory_id` foreign key. |
| `directory` | A user-owned grouping of links.                              |

`LinkEntity.userId` and `LinkEntity.directoryId` are integer surrogate keys, while `supabaseClient.auth.currentUser.id` is a UUID string — datasources bridge between them.

## Getting Started

### Prerequisites

- Flutter SDK matching `^3.9.2` (Dart 3)
- A Supabase project with `link` and `directory` tables and RLS policies that scope rows to `auth.uid()`

### 1. Install dependencies

```bash
flutter pub get
```

### 2. Generate code

The repository commits the generated `*.freezed.dart` and `*.g.dart` files. Regenerate them after pulling or whenever you edit a `@freezed`, `@JsonSerializable`, or Riverpod-annotated class:

```bash
dart run build_runner build --delete-conflicting-outputs

# Or, while iterating
dart run build_runner watch --delete-conflicting-outputs
```

### 3. Configure Supabase credentials

Credentials are read at compile time via `String.fromEnvironment` in `lib/core/config/supabase_config.dart` — **not** from a `.env` file at runtime. Pass them through `--dart-define`:

```bash
flutter run \
  --dart-define=SUPABASE_URL=https://<your-project>.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=<your-anon-key>
```

Without these defines, the app still boots against placeholder values (with a warning logged) but every Supabase call will fail. The `.env_example` file documents the variable names for convenience.

#### Building release artifacts

```bash
flutter build apk     --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
flutter build ios     --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
flutter build web     --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
flutter build macos   --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
```

## Development

```bash
# Static analysis
flutter analyze

# Format
dart format lib

# Tests
flutter test
```

Supported targets: Android, iOS, Web, macOS, Windows, Linux (the `android/`, `ios/`, `web/`, `macos/`, `windows/`, and `linux/` directories are all checked in).

## Repository Layout

```
.
├── lib/                 # Application source
├── android/ ios/ web/   # Platform projects
├── macos/ windows/ linux/
├── pubspec.yaml         # Dependencies & Flutter config
├── analysis_options.yaml
└── CLAUDE.md            # Guidance for Claude Code working in this repo
```

## License

This project does not currently declare a license. All rights reserved by the authors until one is added.
