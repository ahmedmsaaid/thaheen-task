# 🧠 Thaheen Mini Offline LMS (Health Sciences Learning Platform)

> **A production-grade, 100% Offline-First Learning Management System (LMS)** built as a Technical Screening Task for **Thaheen (ذهين)** healthcare students. Engineered with modern **Clean Architecture**, **Feature-Driven Design**, **Riverpod 2.0**, and **Strict SOLID Principles** in Flutter.

[🇸🇦 النسخة العربية (Arabic Version)](README_AR.md)

---

## 📑 Table of Contents
1. [Project Overview](#-project-overview)
2. [Getting Started & Prerequisites](#-getting-started--prerequisites)
3. [Architecture & Folder Structure](#-architecture--folder-structure)
4. [Requirements Compliance Matrix](#-requirements-compliance-matrix)
5. [Core & Required Features](#-core--required-features)
6. [Bonus & Value-Added Features](#-bonus--value-added-features)
7. [Screen Responsiveness & Fluid UI](#-screen-responsiveness--fluid-ui)
8. [Testing & Quality Assurance](#-testing--quality-assurance)
9. [Technical Stack & Design Decisions](#-technical-stack--design-decisions)
10. [Roadmap & Production Enhancements](#-roadmap--production-enhancements)
11. [Project Developer](#-project-developer)

---

## 🌟 Project Overview

**Thaheen Mini LMS** is designed to provide medical and health sciences students with an uninterrupted, distraction-free educational experience that operates **100% offline**. All courses, modules, lessons, and video content are bundled locally within the app bundle (`assets/data/courses.json` and local MP4 assets), with real-time watch progress tracked locally using persistent storage.

### Key Highlights
* **Zero Internet Required**: All assets and data loaded completely offline.
* **Arabic & RTL Native**: Full Right-To-Left layout integration with unified **Cairo** typography.
* **Internationalization**: Powered by `easy_localization` supporting instant dynamic switching between Arabic and English.
* **Smart Arabic Search**: Diacritic/tashkeel removal and letter normalization (`أ/إ/آ` ➔ `ا`, `ة` ➔ `ه`, `ى` ➔ `ي`).
* **Offline Lesson Notes**: Full CRUD persistence for timestamped notes using Hive.
* **Strict Architecture Rules**: No file exceeds 100 lines of code; zero hardcoded strings.
* **Robust Automated Testing**: 41 Unit, Domain, and Widget tests covering domain rules, state changes, and UI workflows.

---

## 🚀 Getting Started & Prerequisites

### Prerequisites
* **Flutter SDK**: `^3.19.0` or later (Dart `^3.3.0+`)
* **Java JDK**: 17+
* **Android Studio / VS Code** with Flutter & Dart extensions installed

### Quick Start Commands

```bash
# 1. Clone repository and navigate to directory
git clone git@github.com:ahmedmsaaid/thaheen-task.git
cd thaheen-task

# 2. Install dependencies
flutter pub get

# 3. Run the application on connected device/emulator
flutter run

# 4. Execute full automated test suite (41 Unit + Widget tests)
flutter test

# 5. Run static analysis for code quality & style checks
dart analyze lib test
```

---

## 📐 Architecture & Folder Structure

The project follows **Clean Architecture** combined with a **Feature-Driven Pattern** to enforce separation of concerns, high maintainability, and testability. Every single file is constrained to $\le 100$ lines.

```
lib/
├── main.dart                     # App entry point with EasyLocalization, ProviderScope & ScreenUtilInit
├── core/                         # Shared core infrastructure layer
│   ├── constants/                # AppStrings, PlayerStrings, Asset paths, and static configurations
│   ├── providers/                # Global dependency injection & shared providers
│   ├── router/                   # GoRouter configuration & custom smooth transitions
│   ├── theme/                    # Dynamic dual-theme system, AppColors & typography
│   ├── utils/                    # ArabicNormalizer, formatters, toasts & extensions
│   └── widgets/                  # Reusable atomic UI widgets
└── features/                     # Independent domain & feature slices
    ├── splash/                   # Animated startup screen
    ├── main_layout/              # Root scaffold with floating navigation & language toggle
    ├── courses/                  # Course catalog, search bar & "Continue Watching" card
    ├── course_details/           # Module tree, lesson states, and locked lesson modal
    ├── watched_courses/          # History of opened/completed courses & timestamps
    ├── progress_tracking/        # Learning statistics, total hours & achievement badges
    ├── lesson_player/            # Video engine, Hive notes, watermark, and 90% completion
    └── settings/                 # Theme toggle (Dark/Light mode) & user preferences
```

---

## 📋 Requirements Compliance Matrix

| Requirement (from Spec) | Status | Implementation Details |
|:---|:---:|:---|
| **Bundled Offline Data** | ✅ **Completed** | Bundled `courses.json` with local asset video files. |
| **Courses Screen** | ✅ **Completed** | Grid/List view with progress bars, instructor metadata, and **Continue Watching** card. |
| **Course Details Screen** | ✅ **Completed** | Hierarchical module & lesson tree with status icons (Not Started, In Progress, Completed, Locked). |
| **Sequential Unlocking** | ✅ **Completed** | Enforces strict sequence. First lesson unlocked; subsequent lessons unlock only after previous completion. |
| **90% Completion Rule** | ✅ **Completed** | Lesson marked completed and next lesson unlocked automatically when $\ge 90\%$ watched. |
| **Advanced Video Player** | ✅ **Completed** | Play/Pause, RTL interactive Seek Bar, +10s/-10s buttons, Speed control (1x–2x), Fullscreen & PiP. |
| **Auto/Prompt Next Lesson** | ✅ **Completed** | Countdown banner & prompt bottom sheet suggesting next lesson upon video completion. |
| **Local Persistence** | ✅ **Completed** | Persistent watch progress and completion flags via `SharedPreferences`, and notes via `Hive`. |
| **Arabic & RTL Support** | ✅ **Completed** | Native RTL/LTR layouts, dynamic language switcher (Arabic ⇄ English), and unified Cairo typography. |
| **State & Error Handling** | ✅ **Completed** | Custom Lottie loading, Empty course state, Empty search results, and explicit Failed state test lessons with retry actions. |
| **Search & Normalization** | ✅ **Completed** | Real-time search with Arabic character normalization (diacritics, alef, taa marbouta). |
| **Lesson Notes CRUD** | ✅ **Completed** | Full local persistence for per-lesson timestamped notes with add & delete capabilities. |
| **Automated Tests** | ✅ **Completed** | **41 Tests passing** (Unit tests for domain math + Widget tests for interactions). |

---

## 🎯 Core & Required Features

All mandatory technical specifications requested in the screening document:

1. **100% Offline Capability**:
   * Reads course, section, and lesson metadata from bundled `assets/data/courses.json`.
   * Plays local MP4 video assets without network dependency.
2. **Course Catalog & Smart Search**:
   * Displays medical courses with covers, instructor name, and lesson count.
   * Real-time search with Arabic normalization (matches variations like `أ/إ/ا`, `ة/ه`, `ى/ي` and ignores tashkeel).
   * Top **Continue Watching** card instantly resumes the latest in-progress lesson.
3. **Course Details Screen**:
   * Groups curriculum into structured sections and lessons.
   * Clear visual indicators for lesson status: *Not Started*, *In Progress (with percentage)*, *Completed (✅)*, and *Locked (🔒)*.
4. **Sequential Unlocking Policy**:
   * Only the first lesson is accessible initially.
   * Tapping a locked lesson opens an informative modal bottom sheet explaining the prerequisite lesson.
5. **90% Progress Rule**:
   * Watching $\ge 90\%$ marks the lesson as complete and unlocks the subsequent lesson immediately.
6. **Feature-Packed Video Player**:
   * Play / Pause toggle with animated feedback.
   * Interactive seek bar adapted for RTL layouts with precise timestamps (`03:15 / 10:00`).
   * Quick skip controls (+10s forward / -10s rewind).
   * Playback speed selector (`1.0x`, `1.25x`, `1.5x`, `2.0x`).
   * Fullscreen rotation and Picture-in-Picture (PiP) support.
   * Automatic playback resumption from the last saved second.
7. **Next Lesson Flow**:
   * In-player "Next Lesson" banner and completion countdown.
   * Persistent bottom banner on the main screen prompting to continue to the next lesson.
8. **State & Error Handling**:
   * Shimmer & Lottie animations during loading states.
   * Dedicated empty state for courses without content (e.g., Emergency Medicine).
   * Dedicated empty search state when no courses match query.
   * Failed state resilience with dedicated test lessons ("Antibiotics & Resistance Mechanisms - Failed State Test") featuring retry controls.

---

## 🌟 Bonus & Value-Added Features

Architectural and UX innovations added to elevate the platform:

1. **Smart Arabic Search with Character Normalization**:
   * Fast, real-time filtering that normalizes diacritics and Arabic letter variations.
2. **Per-Lesson Notes CRUD (Local Persistence via Hive)**:
   * Students can record timestamped notes per lesson, jump to exact playback seconds upon tap, and delete notes.
3. **Dynamic Multi-Language Toggle (`easy_localization`)**:
   * Instant one-tap switch in the top AppBar dynamically updating text direction (`RTL` / `LTR`), JSON dictionaries, and UI strings.
4. **True Dark / Light Mode**:
   * Dynamic theming system via Riverpod and custom `ThemeExtension` with saved user preference.
5. **Embedded Mini Player**:
   * Floating mini-player preview inside the home screen "Continue Watching" card when navigating back from the player.
6. **Picture-in-Picture (PiP)**:
   * Floating window playback allowing students to multitask while listening to lectures.
7. **Dynamic Security Watermark**:
   * Floating anti-piracy overlay displaying student name & ID across video frames to protect academic content.
8. **Glassmorphic Floating Navigation Bar**:
   * Contemporary floating bottom navigation bar with blur effect (`BackdropFilter`) and smooth tab transitions.
9. **Watched Courses History Screen**:
   * Dedicated tab tracking all started and finished courses with exact viewing timestamps.
10. **Progress Analytics & Achievement Badges**:
    * Analytics dashboard summarizing completed courses, total watch hours, and motivational milestone badges.
11. **Strict SRP Code Standards**:
    * Every file in `lib/` strictly contains $\le 100$ lines.
12. **Comprehensive Automated Test Suite (41 Tests)**:
    * 41 Unit, Domain, and Widget tests verifying calculations, policies, search, notes, and UI workflows.

---

## 📱 Screen Responsiveness & Fluid UI

The UI is built with **`flutter_screenutil`** for full responsiveness across phone, phablet, and tablet screens:
* **Vertical Spacing & Heights**: Scaled using `.h`.
* **Horizontal Spacing & Widths**: Scaled using `.w`.
* **Border Radii & Square Dimensions**: Scaled using `.r`.
* **Font Sizes & Icon Sizes**: Scaled using `.sp`.
* **Base Artboard Size**: `Size(375, 812)` standard mobile design canvas.

---

## 🧪 Testing & Quality Assurance

The codebase includes a comprehensive automated test suite of **41 tests**:

| Test Category | File Path | Scope & Verified Logic |
|:---|:---|:---|
| **Unit Tests** | `test/domain/progress_calculator_test.dart` | 90% completion rule, boundary values, zero duration, and progress math. |
| **Unit Tests** | `test/domain/unlock_policy_test.dart` | Sequential unlocking, prerequisite checks, next lesson resolution, and resume logic. |
| **Unit Tests** | `test/domain/arabic_normalizer_test.dart` | Diacritics stripping, letter normalization (Alef, Taa Marbuta, Yaa), and fuzzy Arabic query matching. |
| **Unit Tests** | `test/domain/notes_test.dart` | Hive local persistence CRUD operations for timestamped lesson notes. |
| **Widget Tests** | `test/widgets/course_card_test.dart` | Course card rendering, badges, and progress bar calculations. |
| **Widget Tests** | `test/widgets/continue_watching_card_test.dart` | Continue watching card layout, duration formatting, and tap callbacks. |
| **Widget Tests** | `test/widgets/locked_lesson_sheet_test.dart` | Locked lesson bottom sheet rendering and dismissal. |
| **Widget Tests** | `test/widgets/next_lesson_prompt_sheet_test.dart` | Next lesson prompt bottom sheet actions and auto-trigger. |
| **Widget Tests** | `test/widgets/bottom_nav_bar_test.dart` | Floating navigation bar items and tab switching. |
| **Widget Tests** | `test/widgets/theme_toggle_button_test.dart` | Dark/Light mode toggle button and state updates in Riverpod. |
| **Smoke Tests** | `test/widget_test.dart` | Application launch and initial home screen mounting. |

---

## 🛠️ Technical Stack & Design Decisions

* **Flutter & Dart SDK**: Flutter 3.19+ / Dart 3.3+ for modern pattern matching, records, and null safety.
* **State Management (Riverpod 2.0)**: Compile-time safe, context-free dependency injection, testable via `ProviderContainer`.
* **Localization (`easy_localization`)**: Robust JSON-based multi-language engine with dynamic live locale switching.
* **Video Engine (Better Player Plus / ExoPlayer)**: Robust playback controls, precise seeking, speed scaling, PiP, and lifecycle handling.
* **Routing (GoRouter)**: Declarative routing with parameterized paths and custom transition animations.
* **Storage (Hive + SharedPreferences)**: Fast, structured NoSQL persistence for notes and key-value storage for progress.
* **Typography (Cairo Font)**: Unified Cairo font family tailored for professional Arabic medical and scientific educational content.

---

## 🔮 Roadmap & Production Enhancements

1. **Scalable Media Streaming (HLS & AES-128)**:
   * *Screening Scope*: Local bundled MP4 assets for self-contained offline evaluation.
   * *Production Scope*: Integration with AWS S3 / Cloudflare Stream using HLS segmented video caching with encrypted storage.
2. **Cloud Progress Synchronization**:
   * Sync adapter layer to synchronize watch progress and certificates upon internet reconnection with timestamp-based conflict resolution.
3. **End-to-End Integration Testing**:
   * Automated cross-device UI flows via Flutter Driver and integration tests.

---

## 👨‍💻 Project Developer

**Ahmed Saaid (أحمد سعيد)**  
*Flutter Developer with 3+ years of experience in mobile application engineering.*

* 📧 **Email:** [ahmedsaaid908@gmail.com](mailto:ahmedsaaid908@gmail.com)
* 📌 **Portfolio:** [https://flutter-glow-sphere.vercel.app/](https://flutter-glow-sphere.vercel.app/)
* 📄 **Resume / CV:** [Google Drive Link](https://drive.google.com/file/d/1Eozjil0AaGG6Wi2X-xiIZJj6KnDuO5a5/view?usp=drivesdk)
* 💬 **WhatsApp:** [+201020183845](https://wa.me/201020183845)

---

🎯 **Engineered with precision to exceed all technical evaluation benchmarks for Thaheen.**
