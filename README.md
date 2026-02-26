# Sowlab Mobile Assignment - Production-Grade Flutter Implementation

This repository contains a professional, production-ready Flutter implementation for the Sowlab assignment. The solution prioritizes architectural integrity, security, and a premium user experience.

---

## 🏗 Architecture: Feature-First Clean Architecture

The project follows a **Modular Clean Architecture** (Feature-First) pattern. This approach ensures that the codebase remains scalable, testable, and maintainable as the product grows.

### Layer Breakdown
- **Presentation Layer**: Using **BLoC (Cubit)** for state management and **Material 3** for high-fidelity UI. Logic is decoupled from UI via UseCases.
- **Domain Layer**: Contains **Entities**, **UseCases**, and **Repository Interfaces**. This is the core business logic, independent of secondary frameworks.
- **Data Layer**: Implements Repository Interfaces. Handles data retrieval via **REST API (Dio)** and persistence via **Flutter Secure Storage**.

### Folder Structure
```text
lib/
├── core/                       # Shared infrastructure (API, Theme, Utils)
├── features/                   # Business modules (Self-contained)
│   └── auth/                   # Complete Authentication Module
│       ├── data/               # Repositories & Data Sources
│       ├── domain/             # Entities & UseCases
│       └── presentation/       # Cubits & UI Screens
├── injection_container.dart    # Dependency Injection (GetIt)
└── main.dart                   # App Entry & Global Providers
```

---

## 🔌 API Integration & Resilience

The network layer is built using **Dio** and is designed to handle real-world mobile challenges.

### Key Features
- **Centralized Client**: Single instance with pre-configured timeouts (15s), base URL, and JSON headers.
- **Interceptors**:
    - **Security**: Automatically attaches Bearer tokens from secure storage.
    - **Connectivity**: Short-circuits requests before execution if no internet is detected.
    - **Retry Logic**: Automatically retries transient network failures (3 attempts).
    - **Refresh Token**: Implements a silent refresh-and-retry mechanism for 401 Unauthorized errors.

---

## 🏗 Enterprise Features (Architecture & Security)

The solution has been refactored to meet enterprise standards:
- **Clean DTOs**: Separation of Data models and Domain entities via Mappers.
- **Sealed States**: Exhaustive state management using sealed class unions for predictability.
- **Security Interceptors**: Including SSL Pinning (placeholder logic) and advanced Request Signatures.
- **Environment Flavors**: Centralized configuration for Dev/Staging/Prod via `EnvConfig`.
- **Premium UX**: Integrated Shimmer/Skeleton loaders for polished transitions.

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0+)
- Android Studio / VS Code with Flutter extension
- An emulator or physical device

### Installation
1. Clone the repository.
2. Navigate to the project root:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

---

## 💎 Future Improvements
- **Unit & Integration Tests**: Adding 100% coverage for Domain UseCases.
- **Lottie Animations**: Replacing the native Flux animations with high-quality Lottie assets.
- **Local Caching**: Implementing Hive or Floor for offline data persistence beyond tokens.
- **CI/CD**: Setting up GitHub Actions for automated builds and testing.

---

## 💬 Rationale for Scaling
By segregating the app into **Features**, multiple developers can work on different modules (e.g., Auth, Profile, Home) simultaneously without merge conflicts. The use of **Dependency Injection** and **UseCases** ensures that swapping a backend or changing a business rule only requires editing a single, isolated file.
