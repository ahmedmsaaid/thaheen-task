# خطة تنفيذ تاسك Thaheen – Flutter Screening Task
### Mini Offline LMS with Video Player

> ملخص سريع: التاسك مطلوب فيه تطبيق طالب صغير أوفلاين بالكامل (بدون باكند/API)، فيه شاشة كورسات → شاشة تفاصيل كورس (سكاشن ودروس مقفولة تسلسليًا) → شاشة تشغيل فيديو (مع Resume, Speed, Fullscreen, إكمال تلقائي عند 90%). الهدف الأساسي: **كود نظيف ومنظم + تجربة عربي/RTL صح + الـ persistence شغّال بعد إعادة تشغيل التطبيق**، مش كمية فيتشرز.

---

## 1) الهوية البصرية (مبنية على براند "ذهين")

بعد معاينة اللوجو والسكرين شوتس + موقع thaheensa.com، الهوية عندهم:

- منصة أكاديمية صحية، طابع "علمي/جامعي" هادئ.
- اللون الأساسي **أزرق** (اللوجو، أزرار "تسجيل/دخول"، "ابدأ رحلتك الآن"، "اشتر الآن").
- تدرّج أزرق غامق → أزرق متوسط في هيدر كروت الكورسات.
- تفاصيل ذهبية/برتقالية في الـ stars والـ accents (السهم في الهيرو، النجوم).
- سعر العرض بلون **أخضر** (لتمييزه عن السعر الأصلي المشطوب بالرمادي).
- خلفيات فاتحة جدًا (تينت أزرق فاتح/لافندر) بدل الأبيض الخالص في السكاشن.
- الخط عربي واضح ومريح (Cairo / Tajawal / Almarai كلها مناسبة تصريحيًا لهذا النوع من المنصات) — هستخدم `google_fonts` مع Cairo كخيار افتراضي، وأي منهم قابل للتبديل بسطر واحد.

> ملاحظة أمانة: الألوان دي مستخرجة بالعين من السكرين شوتس اللي بعتيها + الموقع، مش من ملف تصميم رسمي (Figma/Brand Guide). لو عندك عندك ملف تصميم رسمي أو Design Tokens من الشركة، الأفضل نستبدل الأرقام دي بيه مباشرة. الهدف هنا إننا نبني هوية "قريبة جدًا وواقعية" من غير ما ندّعي إنها الرسمية 100%.

### 1.1 ملف الألوان (Light / Dark)

نفس الباترن اللي بعتيه (static const + كلاس ياخد Context)، بس بألوان ذهين الزرقاء بدل الأحمر، ومقسّم Light/Dark:

```dart
import 'package:flutter/material.dart';

/// Thaheen brand colors — Light theme
class AppColorsLight {
  final BuildContext context;
  AppColorsLight(this.context);

  // ─── Primary (Thaheen Blue) ─────────────────────────────
  static const Color primary = Color(0xFF1868E0);
  static const Color primaryDark = Color(0xFF0B3E7A);
  static const Color primaryDarkNavy = Color(0xFF082C58);
  static const Color primaryLight = Color(0xFF3A8DFF);
  static const Color primaryTint = Color(0xFFEAF3FF);
  static const Color primaryTintSec = Color(0xFFD7E9FF);
  static const Color primaryVariant = Color(0xFF1868E0);

  // ─── Accent / Semantic ──────────────────────────────────
  static const Color accentGold = Color(0xFFF5A623);   // نجوم التقييم
  static const Color success = Color(0xFF1FA25A);      // سعر / إكمال الدرس
  static const Color warning = Color(0xFFF5A623);
  static const Color error = Color(0xFFE53935);
  static const Color locked = Color(0xFF9AA5B1);       // درس مقفول

  // ─── Neutrals ───────────────────────────────────────────
  static const Color background = Color(0xFFF7FAFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF141B2D);
  static const Color textSecondary = Color(0xFF5F6B7A);
  static const Color divider = Color(0xFFE3E8EF);

  static const Color circularUnSelectedContainerColor = Color(0xFFE3E2E2);
  static const Color circularSelectedContainerColor = Color(0xFFE9F1FF);
  static const Color unSelectedIconColor = Color(0xFF5F5E5E);
}

/// Thaheen brand colors — Dark theme
class AppColorsDark {
  final BuildContext context;
  AppColorsDark(this.context);

  // ─── Primary (Thaheen Blue - adjusted for contrast) ────
  static const Color primary = Color(0xFF4C8DFF);
  static const Color primaryDark = Color(0xFF1868E0);
  static const Color primaryDarkNavy = Color(0xFF0B3E7A);
  static const Color primaryLight = Color(0xFF7DB2FF);
  static const Color primaryTint = Color(0xFF16233A);
  static const Color primaryTintSec = Color(0xFF1D2E4A);
  static const Color primaryVariant = Color(0xFF4C8DFF);

  // ─── Accent / Semantic ──────────────────────────────────
  static const Color accentGold = Color(0xFFFFC24B);
  static const Color success = Color(0xFF3ECF8E);
  static const Color warning = Color(0xFFFFC24B);
  static const Color error = Color(0xFFFF6B6B);
  static const Color locked = Color(0xFF6B7684);

  // ─── Neutrals ───────────────────────────────────────────
  static const Color background = Color(0xFF0D1117);
  static const Color surface = Color(0xFF161B22);
  static const Color textPrimary = Color(0xFFF3F6FB);
  static const Color textSecondary = Color(0xFF9AA5B1);
  static const Color divider = Color(0xFF262D38);

  static const Color circularUnSelectedContainerColor = Color(0xFF262D38);
  static const Color circularSelectedContainerColor = Color(0xFF1D2E4A);
  static const Color unSelectedIconColor = Color(0xFF9AA5B1);
}
```

هوصل الاتنين بـ `ThemeExtension` واحدة اسمها `AppColors` بحيث في الكود كله بنكتب `context.appColors.primary` بس، من غير ما نعمل `if (isDark)` في كل مكان — ده بيخلي الكود نضيف ومركزي.

### 1.2 ملفات `AppTextStyles` و `AppStrings` (نفس مبدأ فصل `AppColors`)

بنفس الروح: مفيش `TextStyle` ولا نص يتكتب حر في أي شاشة، الاتنين ليهم ملف واحد مركزي لكل واحد:

```dart
// core/theme/app_text_styles.dart
class AppTextStyles {
  static TextStyle h1(BuildContext context) => GoogleFonts.cairo(
        fontSize: 22, fontWeight: FontWeight.bold, color: context.appColors.textPrimary,
      );
  static TextStyle body(BuildContext context) => GoogleFonts.cairo(
        fontSize: 15, fontWeight: FontWeight.w400, color: context.appColors.textPrimary,
      );
  static TextStyle bodyLocked(BuildContext context) => GoogleFonts.cairo(
        fontSize: 15, color: context.appColors.locked,
      );
  static TextStyle caption(BuildContext context) => GoogleFonts.cairo(
        fontSize: 12, color: context.appColors.textSecondary,
      );
}
```

```dart
// core/constants/app_strings.dart
class AppStrings {
  AppStrings._();

  // Courses screen
  static const continueWatching = 'متابعة المشاهدة';
  static const coursesTitle = 'كورساتي';
  static const coursesEmpty = 'لا توجد كورسات بعد';
  static const coursesLoadError = 'حدث خطأ أثناء تحميل الكورسات';

  // Course details
  static const lessonLockedMessage = 'أكمل الدرس السابق أولاً 😊';
  static const lessonStatusCompleted = 'مكتمل';
  static const lessonStatusInProgress = 'قيد التقدم';
  static const lessonStatusNotStarted = 'لم يبدأ';

  // Lesson player
  static const nextLesson = 'الدرس التالي';
  static const playbackSpeed = 'سرعة التشغيل';
  static const videoLoadError = 'تعذّر تشغيل هذا الفيديو';
}
```

لو عملنا Bonus (عربي/إنجليزي)، هنخلي `AppStrings` نفسها بتقرأ من ملفات `localization` بدل ما تكون Hardcoded، لكن برضو أي Widget هينادي `AppStrings.xxx` بس ومش هيعرف مصدر النص من فين.

---

## 2) اختيار الباكيجات (State Management + كل حاجة تانية) + السبب

| الغرض | الباكيج | السبب |
|---|---|---|
| **State Management** | **Riverpod** (`flutter_riverpod` + `riverpod_annotation`) | Testable بسهولة من غير `BuildContext`، compile-safe، بيقلل الـ boilerplate عن Bloc في تاسك بالحجم ده، وسهل نعمل منه `AsyncNotifier` لكل من (الكورسات، التقدّم، مشغّل الفيديو) بشكل منفصل ونظيف. |
| **تشغيل الفيديو** | `video_player` + `chewie` | `chewie` بيدّينا UI جاهز لـ play/pause/seek/fullscreen واحنا بس بنكستمايز الألوان والـ speed menu، فبنوفر وقت التاسك (4-6 ساعات) ونركز على الـ logic بدل إعادة بناء UI بلاير من الصفر. |
| **التخزين المحلي** | **Hive** (`hive` + `hive_flutter`) | مفيش حاجة معقدة محتاجة SQL (مفيش علاقات/queries معقدة)، الداتا بسيطة (Map<lessonId, Progress>)، Hive أسرع من SharedPreferences للـ objects المركّبة وأخف من sqflite/Isar لحجم التاسك ده، وسهل نعمل منها Mock في الـ unit tests. |
| **Navigation** | `go_router` | Routes معرّفة بشكل declarative (`/courses`, `/courses/:id`, `/courses/:id/lessons/:lessonId`)، وبيدعم deep linking لو حبينا نرجع لدرس معيّن مباشرة (مفيد لما نرجع من الـ "متابعة المشاهدة"). |
| **الخطوط العربية** | `google_fonts` (Cairo) | خط عربي احترافي قريب من هوية ذهين، من غير ما نحمّل fonts يدوي. |
| **الأيقونات** | `flutter_svg` (لو استخدمنا أيقونات SVG للّوجو/الأيقونات) | جودة أعلى من الـ PNG على كل الدقّات. |
| **الاختبارات** | `flutter_test` + `mocktail` | `mocktail` بيدّينا mocking من غير code generation، مناسب لحجم التاسك. |
| **Freezed / json_serializable** (اختياري) | لو الوقت سمح | Models نظيفة (`Course`, `Section`, `Lesson`, `LessonProgress`) مع `copyWith` و equality جاهزين. لو الوقت ضيّق، هكتبهم يدوي عادي — مش أولوية.

**ملاحظة مهمة:** مش هستخدم أي باكيج زيادة عن كده. حتى `dio`/`http` مش هينزلوا لأن مفيش API خالص.

---

## 3) البنية المعمارية (Architecture)

بنية طبقات بسيطة (مش Clean Architecture كاملة بكل تفاصيلها عشان ما نـ Over-engineer التاسك، بس مفصولة بشكل واضح):

```
lib/
 ├─ core/
 │   ├─ theme/
 │   │    ├─ app_colors.dart        (AppColorsLight + AppColorsDark فقط — ولا لون تاني يتكتب في أي فايل تاني)
 │   │    ├─ app_text_styles.dart   (AppTextStyles فقط — ولا TextStyle يتكتب Inline في أي Widget)
 │   │    └─ app_theme.dart         (ThemeData اللي بيجمع اللي فوق دول لـ MaterialApp)
 │   ├─ constants/
 │   │    ├─ app_strings.dart       (AppStrings فقط — كل نص عربي/إنجليزي في التطبيق بييجي من هنا)
 │   │    ├─ app_assets.dart        (مسارات assets/images, assets/videos)
 │   │    └─ app_durations.dart     (أي Duration ثابت: مدة الـ auto-hide للكونترولز، مدة الـ debounce...)
 │   ├─ localization/     (ar/en لو عملنا bonus الترجمة — AppStrings بتاخد منها مش العكس)
 │   └─ router/           (go_router setup)
 │
 ├─ data/
 │   ├─ models/           (Course, Section, Lesson, LessonProgress)
 │   ├─ datasources/
 │   │    ├─ local_courses_datasource.dart   (قراءة assets/data/courses.json)
 │   │    └─ progress_local_storage.dart     (Hive box wrapper)
 │   └─ repositories/
 │        ├─ courses_repository.dart   (كل اللوجيك المتعلق بالكورسات بيتنادى من هنا، مش من الـ UI)
 │        └─ progress_repository.dart  (كل اللوجيك المتعلق بالتقدّم بيتنادى من هنا)
 │
 ├─ domain/                (منطق بحت، بدون Flutter widgets، ده اللي بيستخدمه الـ Repository)
 │   ├─ progress_calculator.dart   (نسبة الإكمال، قاعدة الـ 90%)
 │   └─ unlock_policy.dart         (قاعدة الفتح التسلسلي)
 │
 ├─ features/
 │   ├─ courses/
 │   │    ├─ courses_page.dart              (استدعاء Widgets بس، صفر منطق)
 │   │    ├─ courses_controller.dart        (Riverpod Notifier — الحالة والقرارات)
 │   │    └─ widgets/
 │   │         ├─ continue_watching_card.dart
 │   │         ├─ course_list_item.dart
 │   │         ├─ course_progress_bar.dart
 │   │         └─ courses_empty_state.dart / courses_error_state.dart
 │   │
 │   ├─ course_details/
 │   │    ├─ course_details_page.dart       (استدعاء Widgets بس)
 │   │    ├─ course_details_controller.dart
 │   │    └─ widgets/
 │   │         ├─ section_expansion_tile.dart
 │   │         ├─ lesson_list_item.dart
 │   │         └─ locked_lesson_sheet.dart
 │   │
 │   └─ lesson_player/
 │        ├─ lesson_player_page.dart        (استدعاء Widgets بس)
 │        ├─ lesson_player_controller.dart  (كل منطق: resume, 90%, speed, unlock)
 │        └─ widgets/
 │             ├─ video_controls_overlay.dart
 │             ├─ speed_selector_sheet.dart
 │             └─ next_lesson_button.dart
 │
 └─ main.dart
```

- **data**: مسؤولة عن القراءة/الكتابة بس (JSON + Hive)، مفيش أي "قرار" منطقي هنا.
- **domain**: فيه القواعد المهمة اللي التاسك هيتقيّم عليها فعليًا (unlock, 90% completion, progress %) — علشان تبقى **قابلة للاختبار لوحدها** من غير Flutter أو Hive.
- **features**: كل Page بتستدعي Widgets وبس، وكل منطق (state, decisions) في `*_controller.dart` (Riverpod Notifier)، والـ Controller بينادي على الـ Repository — الـ Page لا تعرف Hive ولا JSON ولا حتى الـ domain rules مباشرة.

---

## 3.1) قواعد صارمة للكود (Coding Rules) — إلزامية طول التاسك

دي القواعد اللي هنمشي عليها بدون استثناء:

| # | القاعدة | التطبيق العملي |
|---|---|---|
| 1 | **ممنوع أي String هارد كود في الـ UI** | كل نص (عربي أو إنجليزي، حتى `SnackBar` أو `Tooltip` أو `semanticsLabel`) لازم يتكتب مرة واحدة في `core/constants/app_strings.dart` كـ `static const`، والـ Widget بينادي `AppStrings.continueWatching` مثلاً. حتى الأخطاء (Error messages) والـ Empty states بنفس القاعدة. |
| 2 | **ممنوع أي Color أو Style هارد كود** | مفيش `Color(0xFF...)` ولا `TextStyle(...)` جوه أي `build()`. اللون بييجي من `context.appColors.xxx` (القسم 1)، والخط/الحجم/الوزن من `AppTextStyles.xxx` (مثلاً `AppTextStyles.h1`, `AppTextStyles.body`, `AppTextStyles.caption`). لو محتاجين لون/ستايل جديد، بيتضاف مرة واحدة في الفايل المركزي، مش بتاريخ الاستخدام. |
| 3 | **كل حاجة في فايلها المخصص** | `AppColors` في فايله، `AppTextStyles` في فايله، `AppStrings` في فايله — الثلاثة منفصلين تمامًا عن بعض وعن أي Widget، بالظبط زي ما اتفقنا. |
| 4 | **صفر منطق داخل الـ UI (Page/Widget)** | أي `if` بيحدد سلوك حقيقي (هل الدرس مقفول؟ هل التقدّم وصل 90%؟ هل الكورس فاضي؟) ممنوع يتكتب جوه `build()`. الـ Widget بس بيقرأ Boolean/State جاهزة من الـ Controller ويعرضها. أي عملية حسابية (نسبة %، مقارنة وقت، فحص حالة) تتكتب في الـ **Repository/Domain**، والـ UI بيستقبل النتيجة النهائية بس. |
| 5 | **الصفحة (`*_page.dart`) = تجميع Widgets فقط** | ملف الصفحة نفسه ميكونش فيه غير `Scaffold` + استدعاء لـ Widgets جاهزة (`ContinueWatchingCard()`, `CourseListItem(course: ...)`...). لو لاقيت نفسك بتكتب `Container`/`Row`/`Column` معقّدة جوه الـ Page مباشرة، ده معناه إنها لازم تتقلع Widget مستقلة في `widgets/`. |
| 6 | **Widget واحد = فايل واحد** | مفيش Widget بتتكرر تستخدم في أكتر من مكان أو بتاخد أكتر من ٣٠-٤٠ سطر تفضل معرّفة جوه فايل تاني — كل Widget بجسم مستقل ليها فايلها الخاص جوه `widgets/` بتاعة نفس الـ feature (أو `core/widgets/` لو مشتركة بين أكتر من شاشة زي `AppErrorView` و`AppEmptyView`). |
| 7 | **ولا Widget/عنصر بلا معنى في مكانه** | كل عنصر على الشاشة له سبب ومكان منطقي متسق مع الـ Layout والـ RTL — مفيش Padding عشوائي، ولا Widget متسيّب من تجربة سابقة، ولا نص Debug أو Placeholder فاضل في نسخة التسليم. |
| 8 | **تسمية واضحة تفهم من غير تعليق** | أسماء الـ Widgets/الدوال/المتغيرات بوصف الغرض مباشرة (`LessonLockedMessage` مش `Widget1`، `calculateCourseProgress()` مش `calc()`)، عشان أي حد يفتح الكود يفهمه من غير ما يحتاج يسأل. |

**مثال قبل/بعد لتوضيح القاعدة (رقم 1 و2 و4):**

```dart
// ❌ ممنوع: String + Color + منطق جوه الـ Widget
Text(
  lesson.isLocked ? 'أكمل الدرس السابق أولاً' : lesson.title,
  style: TextStyle(color: lesson.isLocked ? Colors.grey : Colors.black, fontSize: 16),
)

// ✅ صح: الـ Widget بس بيعرض حالة جاهزة، والألوان/النصوص من الملفات المركزية
Text(
  lesson.isLocked ? AppStrings.lessonLockedMessage : lesson.title,
  style: lesson.isLocked ? AppTextStyles.bodyLocked(context) : AppTextStyles.bodyPrimary(context),
)
```

> `lesson.isLocked` نفسها بتيجي جاهزة من الـ Controller اللي أصلًا نادى على `UnlockPolicy` في الـ domain — الـ Widget مبيحسبش حاجة، بس بيقرأ نتيجة.

---

## 4) شكل الداتا (courses.json)

هستخدم نفس الشكل المقترح في التاسك مع إضافة بسيطة لدعم شاشة "الكورسات" (progress %, lessonsCount) بدون ما نحسبهم runtime لو مش لازم:

```json
{
  "courses": [
    {
      "id": "anatomy-101",
      "title": "مقدمة في التشريح",
      "instructor": "د. سارة",
      "thumbnail": "assets/images/anatomy.png",
      "sections": [
        {
          "id": "s1",
          "title": "الجهاز الهيكلي",
          "lessons": [
            { "id": "l1", "title": "العظام", "durationSec": 95, "video": "assets/videos/lesson1.mp4" },
            { "id": "l2", "title": "المفاصل", "durationSec": 120, "video": "assets/videos/lesson2.mp4" }
          ]
        },
        {
          "id": "s2",
          "title": "الجهاز العضلي",
          "lessons": [
            { "id": "l3", "title": "أنواع العضلات", "durationSec": 110, "video": "assets/videos/lesson3.mp4" }
          ]
        }
      ]
    },
    {
      "id": "biostatistics-101",
      "title": "الإحصاء الحيوي",
      "instructor": "أ. رنا",
      "thumbnail": "assets/images/biostatistics.png",
      "sections": [
        { "id": "s1", "title": "مقدمة", "lessons": [ ... ] },
        { "id": "s2", "title": "التوزيعات الاحتمالية", "lessons": [ ... ] }
      ]
    }
  ]
}
```

- `id` لكل حاجة (كورس/سكشن/درس) هو المفتاح اللي هنستخدمه في Hive (`courseId_lessonId` كـ key للـ progress).
- الـ progress % وعدد الدروس بيتحسبوا في الـ domain layer وقت العرض، مش مخزّنين في الـ JSON، عشان الداتا الوصفية (JSON) تفضل منفصلة عن حالة المستخدم (Hive).

---

## 5) الشاشات والتدفق (بناءً على الفلو المطلوب في التاسك)

> السكرين شوتس اللي بعتيها من موقع ذهين هي مرجع "هوية بصرية" بس (الألوان/الكروت/الخط)، مش شاشات لوجن/هوم بيدج مطلوبة فعليًا في التاسك — التاسك محدد فيه 3 شاشات فقط، ومفيش تسجيل دخول ولا سلة شراء لأن التطبيق أوفلاين بالكامل بدون باكند.

### شاشة 1 – الكورسات (Courses Screen)
- Card "متابعة المشاهدة" أعلى الصفحة (لو فيه درس غير مكتمل) — بتصميم شبيه بكروت الهيرو عندهم (تدرّج أزرق + زر متابعة).
- List بكروت الكورسات بنفس روح كروت "أحدث الدورات": صورة مصغّرة، عنوان، اسم المحاضر، عدد الدروس، وشريط/نسبة تقدّم بدل السعر.
- حالات: Loading (Shimmer/Skeleton بسيط)، Empty (لو الـ JSON فاضي)، Error (لو فشل تحميل الملف).

### شاشة 2 – تفاصيل الكورس (Course Details)
- قائمة Sections قابلة للطي (Expandable)، كل Section فيه دروسه.
- كل درس بيبيّن: المدة، وحالة (لسه ماتبدأش / قيد التقدم / مكتمل) بأيقونة ولون واضح (استخدام `success` للمكتمل، `locked` للمقفول).
- الدرس المقفول: عليه Overlay خفيف + Icon قفل، وعند الضغط عليه Bottom Sheet/SnackBar بسيطة "أكمل الدرس السابق الأول 😊" بدل ما يفتح.

### شاشة 3 – مشغّل الدرس (Lesson Player)
- `chewie` مكستمايز بألوان ذهين (progress bar بلون primary، الأزرار بيضاء على خلفية شبه شفافة).
- قايمة سرعة التشغيل (1x/1.25x/1.5x/2x) كـ Bottom Sheet أو PopupMenu.
- Resume تلقائي من آخر نقطة متابعة عند دخول الدرس تاني.
- عند وصول نسبة المشاهدة 90% → تعليم الدرس "مكتمل" أوتوماتيك (من غير قطع الفيديو).
- زر "الدرس التالي" في الأسفل، يفعل بس لو الدرس الحالي مكتمل أو التالي متاح أصلاً حسب الـ unlock policy.
- Landscape/Fullscreen support، والـ seek bar بتتصرف صح في RTL (يعني لو حبينا نخلي التقديم/الترجيع متسق بصريًا مع اتجاه الشاشة).

---

## 6) نطاق الفيتشرز (Scope) — زي ما اتفقنا: بدون زيادة

**هنعمل بالظبط المطلوب في التاسك (Required Features 1→7) ولا حاجة زيادة**، ما عدا تحسينات بسيطة **تخص تجربة مشاهدة الدرس نفسها** بس (مش فيتشرز جديدة كبيرة):

- ✅ تذكّر آخر سرعة تشغيل اختارها الطالب (أصلًا موجودة كـ Bonus في التاسك، وبتحسّن التجربة فعليًا وسهلة التنفيذ لأنها Hive key واحد إضافي).
- ✅ Double-tap يمين/شمال على الفيديو لتقديم/ترجيع 10 ثواني (تحسين شائع في أي فيديو بلاير ومش بيضيف تعقيد معماري).
- ✅ اختفاء تلقائي لعناصر التحكم بعد ثواني من عدم اللمس (سلوك قياسي في أي Video Player، بيحسّن مشاهدة الفيديو تحديدًا).

**مش هعمل** (عشان نلتزم بالـ scope): Dark mode كامل عبر التطبيق (هجهّز ملف الألوان بس، تفعيله الكامل بونص لو فضل وقت)، بحث عن كورسات، ملاحظات لكل درس، widget tests إضافية — دول هيتسجّلوا في README تحت "لو كان عندي وقت أكتر" زي ما التاسك طالب صراحة.

---

## 7) خطة التوقيت (داخل 4–6 ساعات)

| المرحلة | الوقت التقريبي |
|---|---|
| إعداد المشروع + الباكيجات + هيكلة المجلدات + ملف الألوان/الثيم | 30 دقيقة |
| Models + قراءة courses.json + Hive setup | 30 دقيقة |
| Domain logic (unlock policy, progress calculator, 90% rule) + **Unit tests** لهم فورًا | 45 دقيقة |
| شاشة الكورسات (List + Continue watching + Loading/Empty/Error) | 45 دقيقة |
| شاشة تفاصيل الكورس (Sections/Lessons + حالة القفل) | 45 دقيقة |
| شاشة المشغّل (chewie + speed + resume + auto-complete 90% + next lesson) | 90 دقيقة |
| RTL polish + خط عربي + تجربة على جهاز حقيقي | 30 دقيقة |
| README + تسجيل الفيديو/APK | 30 دقيقة |
| **الإجمالي** | **~5.5 ساعة** (مرن حسب الاحتكاك مع chewie/fullscreen) |

---

## 8) خطة الاختبارات (Unit Tests)

هنكتب 3 unit tests على الأقل، كلهم على الـ `domain` layer (منطق بحت، بدون Widgets ولا Hive حقيقي):

1. **قاعدة الإكمال عند 90%**: `isCompleted(watchedSeconds: 86, totalSeconds: 95) == true` و `isCompleted(watchedSeconds: 50, totalSeconds: 95) == false`.
2. **قاعدة الفتح التسلسلي (Unlock)**: أول درس دايمًا مفتوح، الدرس التاني مقفول لو الأول مش مكتمل، ويتفتح لو الأول مكتمل.
3. **حساب نسبة تقدّم الكورس %**: كورس فيه 4 دروس، 2 مكتملين → النسبة 50%. كورس بدون دروس (Empty) → 0% من غير Division by zero.

---

## 9) هيكل الـ README النهائي

1. طريقة تشغيل المشروع (`flutter pub get` → `flutter run`).
2. شرح الـ Architecture واختيار Riverpod/Hive/chewie ولماذا (نفس أسباب القسم 2 هنا بس مختصرة).
3. Trade-offs والمعروف من القيود (مثلًا: الفيديوهات صغيرة الحجم بس عشان الريبو، مفيش Dark mode كامل مفعّل، إلخ).
4. لو كان فيه وقت أكتر، هعمل كذا (Dark mode كامل، بحث، ملاحظات لكل درس، widget tests).
5. الوقت الفعلي اللي اتصرف تقريبًا.

---

## 10) Checklist التسليم النهائي

- [ ] رابط GitHub (public أو صلاحية وصول).
- [ ] 2–3 فيديوهات MP4 قصيرة (أقل من 10MB) في `assets/videos/`.
- [ ] `assets/data/courses.json` بكورسين، كل كورس فيه سكشنين، كل سكشن 2-3 دروس.
- [ ] README كامل زي القسم اللي فوق.
- [ ] تسجيل شاشة 2-3 دقايق أو APK.
- [ ] تأكيد إن الـ progress بيفضل بعد قفل التطبيق وإعادة فتحه (Hot restart مش كافي، لازم إعادة تشغيل حقيقية للتطبيق).
- [ ] مراجعة نهائية (Self Code Review) على قواعد القسم 3.1: مفيش `Color(0xFF...)` ولا `TextStyle(...)` ولا String عربي/إنجليزي مكتوب مباشرة جوه أي Widget (ينفع نعمل بحث سريع بالـ regex عن `TextStyle(` و`Color(0x` و`"` جوه `lib/features` للتأكد).
- [ ] كل `*_page.dart` بصفحاته الثلاث لا يحتوي على منطق (`if` قرارات) ولا Widgets معقدة Inline — بس تجميع Widgets جاهزة.
- [ ] كل Widget مستقل فعلاً في فايله جوه `widgets/` ومفيش Widget متكرر أو مكتوب مرتين بأسماء مختلفة.

---

### خلاصة
الفكرة الأساسية إننا نبني تطبيق بسيط، منظم بوضوح (data/domain/features)، بهوية بصرية شبيهة بذهين (أزرق + تفاصيل ذهبية/خضراء)، وبنلتزم بالمطلوب بالظبط في التاسك مع 2-3 تحسينات صغيرة جدًا تخص تجربة مشاهدة الفيديو نفسها، وباقي الطموحات (Dark mode كامل، بحث، ملاحظات) بنسجّلها بأمانة في الـ README تحت "لو كان عندي وقت أكتر" زي ما طالبين بالظبط في التاسك.
