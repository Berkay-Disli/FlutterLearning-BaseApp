# Flutter App Architecture

This document describes the folder structure and architecture of the Flutter app.

## Folder Structure

```
lib/
├── core/                           # Core app functionality
│   ├── constants/                  # App-wide constants
│   │   └── app_constants.dart      # Colors, dimensions, text styles
│   └── theme/                      # App theming
│       └── app_theme.dart          # Theme configuration
├── features/                       # Feature-based modules
│   ├── home/                       # Home feature
│   │   └── presentation/           # UI layer
│   │       ├── pages/              # Full pages
│   │       │   └── home_page.dart  # Home page
│   │       └── widgets/            # Feature-specific widgets
│   │           └── home_widgets.dart
│   └── search/                     # Search feature
│       └── presentation/           # UI layer
│           ├── pages/              # Full pages
│           │   └── search_page.dart # Search page
│           └── widgets/            # Feature-specific widgets
│               └── search_widgets.dart
├── models/                         # Data models
│   └── search_result.dart          # Search result model
├── navigation/                     # Navigation components
│   └── main_tab_bar.dart          # Main tab navigation
├── services/                       # External services
│   └── api_service.dart           # API service layer
├── shared/                         # Shared components
│   └── widgets/                    # Reusable widgets
│       └── common_widgets.dart     # Loading, error, empty state widgets
├── utils/                          # Utility functions
│   └── helpers.dart               # Helper functions
└── main.dart                      # App entry point
```

## Architecture Principles

### 1. Feature-Based Organization
- Each feature has its own folder with presentation, domain, and data layers
- Features are self-contained and can be developed independently
- Clear separation of concerns between features

### 2. Clean Architecture
- **Presentation Layer**: UI components (pages, widgets)
- **Domain Layer**: Business logic and use cases (to be added)
- **Data Layer**: Data sources and repositories (to be added)

### 3. Shared Resources
- **Core**: App-wide constants, themes, and configurations
- **Shared**: Reusable widgets and components
- **Utils**: Helper functions and utilities

### 4. Navigation
- Centralized navigation management
- Tab-based navigation structure

## Key Components

### Core
- `app_constants.dart`: Centralized constants for colors, dimensions, and text styles
- `app_theme.dart`: Theme configuration for light/dark modes

### Features
- **Home**: Main landing page with welcome content
- **Search**: Search functionality with input field and results

### Services
- `api_service.dart`: HTTP client for API calls with error handling

### Models
- `search_result.dart`: Data model for search results with JSON serialization

### Shared Widgets
- `LoadingWidget`: Loading indicator
- `ErrorWidget`: Error display with retry functionality
- `EmptyStateWidget`: Empty state display

### Utils
- `helpers.dart`: Utility functions for date formatting, validation, and UI helpers

## Best Practices

1. **Import Organization**: Use relative imports for local files, package imports for external dependencies
2. **Naming Conventions**: Use snake_case for files, PascalCase for classes
3. **Separation of Concerns**: Keep UI, business logic, and data access separate
4. **Reusability**: Create shared widgets for common UI patterns
5. **Constants**: Centralize app-wide constants in the core folder

## Future Enhancements

- Add state management (Provider, Bloc, or Riverpod)
- Implement proper error handling and logging
- Add unit and widget tests
- Implement caching and offline support
- Add internationalization support
