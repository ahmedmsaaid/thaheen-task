# 📚 دليل الاختبارات الشامل وإجابات أسئلة المقابلات التقنية (Testing Guide & Interview Prep)

> **الهدف من هذا الدليل**: فهم عميق لكل سطر كود كُتب في طبقة الاختبارات (`test/`)، أسباب اختيار الأدوات والممارسات الهندسية، وكيفية الإجابة بثقة واحترافية على أسئلة الـ **Interviewer** في المقابلات التقنية (Technical Interviews).

---

## 📑 فهرس المحتويات
1. [استراتيجية الاختبار (Testing Strategy & Pyramid)](#1-استراتيجية-الاختبار-testing-strategy--pyramid)
2. [اختبارات منطق الأعمال (Domain Unit Tests)](#2-اختبارات-منطق-الأعمال-domain-unit-tests)
   - [قاعدة الـ 90% لاكتمال الفيديو (ProgressCalculator)](#أ-قاعدة-الـ-90-لاكتمال-الفيديو-progresscalculator)
   - [سياسة فتح الدروس المتتالية (UnlockPolicy)](#ب-سياسة-فتح-الدروس-المتتالية-unlockpolicy)
3. [اختبارات واجهة المستخدم (Widget Tests)](#3-اختبارات-واجهة-المستخدم-widget-tests)
   - [بيئة الاختبار الموحدة (Test Harness - `test_helper.dart`)](#أ-بيئة-الاختبار-الموحدة-test-harness---test_helperdart)
   - [تفاصيل فحص المكونات التفاعلية (Detailed Widget Tests)](#ب-تفاصيل-فحص-المكونات-التفاعلية-detailed-widget-tests)
4. [أبرز التحديات الهندسية والحلول (Engineering Challenges & Solutions)](#4-أبرز-التحديات-الهندسية-والحلول-engineering-challenges--solutions)
   - [عزل التخزين المحلي (Hive/Disk Isolation) عبر Provider Overrides](#أ-عزل-التخزين-المحلي-hivedisk-isolation-عبر-provider-overrides)
   - [إدارة دورة حياة الـ ChangeNotifier في Riverpod](#ب-إدارة-دورة-حياة-الـ-changenotifier-في-riverpod)
   - [التعامل مع ScreenUtil وقيود الريندر في بيئة الاختبارات](#ج-التعامل-مع-screenutil-وقيود-الريندر-في-بيئة-الاختبارات)
5. [بنك أسئلة المقابلات وإجاباتها النموذجية (Interview Q&A)](#5-بنك-أسئلة-المقابلات-وإجاباتها-النموذجية-interview-qa)

---

## 1. استراتيجية الاختبار (Testing Strategy & Pyramid)

في تطبيقات الـ LMS (Learning Management System) والفيديو، هناك ركيزتان أساسيتان:
1. **Core Business Logic (Unit Tests)**: منطق صارم لا يقبل الخطأ (مثل متى يُعتبر الفيديو مكتملاً، ومتى يفتح الدرس التالي).
2. **Interactive UI Components (Widget Tests)**: ويدجيتس تفاعلية تعتمد على الحالة (State)، الثيم، ودعم الشاشات المتجاوبة، واتجاه اليمين لليسار (RTL).

```
        / \
       /   \     E2E / Integration Tests (App Smoke Tests)
      / ----\
     / Widget\   Widget Tests (Cards, Bottom Sheets, Nav Bar, Theme)
    /  Tests  \
   /-----------\
  /    Unit     \ Unit Tests (ProgressCalculator, UnlockPolicy)
 /     Tests     \
-------------------
```

---

## 2. اختبارات منطق الأعمال (Domain Unit Tests)

### أ. قاعدة الـ 90% لاكتمال الفيديو (`ProgressCalculator`)
* **الملف**: [`test/domain/progress_calculator_test.dart`](file:///f:/StudioProjects/thaheen/test/domain/progress_calculator_test.dart)
* **المسؤولية (Single Responsibility)**: فحص الحسابات الرياضية المحددة في متطلبات المشروع (Screening Task):
  * **90% Completion Rule**: يعتبر الدرس مكتملاً إذا شاهد الطالب $\ge 90\%$ من مدة الفيديو.
* **الحالات التي تم فحصها (Edge Cases Tested)**:
  1. المشاهدة بالضبط عند الحد الحرج 90% $\rightarrow$ يعود بـ `true`.
  2. المشاهدة عند 89% (أقل من الحد بنسبة ضئيلة) $\rightarrow$ يعود بـ `false`.
  3. المشاهدة بنسبة 100% أو أكثر من إجمالي الفيديو $\rightarrow$ يعود بـ `true` مع الالتزام بـ `clamp`.
  4. حالات الصفر والأمان الرياضي (`totalSeconds == 0` أو `watchedSeconds == 0`) $\rightarrow$ تفادي القسمة على صفر (*Division by Zero Guard*).

### ب. سياسة فتح الدروس المتتالية (`UnlockPolicy`)
* **الملف**: [`test/domain/unlock_policy_test.dart`](file:///f:/StudioProjects/thaheen/test/domain/unlock_policy_test.dart)
* **المسؤولية**: التأكد من قواعد الـ Gamification والـ Linear Progression:
  * الدرس الأول في أي كورس يكون **مفتوحاً دائماً** تلقائياً.
  * الدرس الثاني لا يفتح إلا إذا كان الدرس الأول **مكتملاً** (`isCompleted == true`).
  * لو كان الدرس الثالث مطلوباً والدرس الأول مكتمل لكن الثاني غير مكتمل $\rightarrow$ يظل مقفولاً (Strict Sequential Locking).
  * خوارزمية تحديد الدرس التالي (`findNextLesson`) والدرس المستأنف (`findResumeLesson`).

---

## 3. اختبارات واجهة المستخدم (Widget Tests)

### أ. بيئة الاختبار الموحدة (Test Harness - `test_helper.dart`)
* **الملف**: [`test/test_helper.dart`](file:///f:/StudioProjects/thaheen/test/test_helper.dart)
* **لماذا أنشأنا هذا الملف؟ (DRY Principle)**:
  بدلاً من تكرار تغليف كل ويدجيت بـ `ProviderScope` و `ScreenUtilInit` و `MaterialApp` في كل ملف اختبار، قمنا بعمل دالة مساعدة مركزية `createTestWidget(Widget child, {List<Override> overrides})`:
  1. توفر `ProviderScope` لإدارة الحالة عبر Riverpod وإمكانية حقن الـ `overrides`.
  2. توفر `ScreenUtilInit` بمقاس التصميم الأساسي `(375 x 812)` لتعمل امتدادات `.h, .w, .r, .sp` بشكل سليم أثناء التيست.
  3. توفر `Directionality` باتجاه `TextDirection.rtl` لتطابق بيئة التطبيق العربية بدقة.

### ب. تفاصيل فحص المكونات التفاعلية (Detailed Widget Tests)

#### 1. كارت الكورس (`CourseListItem`)
* **الملف**: [`test/widgets/course_card_test.dart`](file:///f:/StudioProjects/thaheen/test/widgets/course_card_test.dart)
* **ما تم اختباره**:
  * عرض العنوان، اسم المحاضر، شارة عدد الدروس (Badge)، ونسبة التقدم المحسوبة.
  * اختبار الضغط على الكارت والتحقق من استدعاء دالة الـ `onTap`.

#### 2. كارت متابعة المشاهدة (`ContinueWatchingCard`)
* **الملف**: [`test/widgets/continue_watching_card_test.dart`](file:///f:/StudioProjects/thaheen/test/widgets/continue_watching_card_test.dart)
* **ما تم اختباره**:
  * عرض عنوان الدرس الحالي وزمن الفيديو المنسق (مثل `10:00 • 50% التقدم`).
  * فحص تكامل الـ ViewModel والـ Callbacks عند النقر.

#### 3. القائمة السفلية للدرس المقفول (`LockedLessonSheet`)
* **الملف**: [`test/widgets/locked_lesson_sheet_test.dart`](file:///f:/StudioProjects/thaheen/test/widgets/locked_lesson_sheet_test.dart)
* **ما تم اختباره**:
  * فتح الـ BottomSheet عند محاولة فتح درس مقفول وعرض نص التنبيه.
  * النقر على زر "حسناً" والتأكد من إغلاق الـ BottomSheet واختفائه من شجرة الـ Widgets (`findsNothing`).

#### 4. قائمة اقتراح الدرس التالي تلقائياً (`NextLessonPromptSheet`)
* **الملف**: [`test/widgets/next_lesson_prompt_sheet_test.dart`](file:///f:/StudioProjects/thaheen/test/widgets/next_lesson_prompt_sheet_test.dart)
* **ما تم اختباره**:
  * عرض اسم الدرس المكتمل والدرس التالي.
  * النقر على زر "تشغيل الآن" والتأكد من تفعيل حدث الانتقال للدرس التالي.
  * النقر على زر "لاحقاً" والتأكد من إغلاق الـ Prompt بنجاح.

#### 5. شريط التنقل السفلي (`MainBottomNavBar`)
* **الملف**: [`test/widgets/bottom_nav_bar_test.dart`](file:///f:/StudioProjects/thaheen/test/widgets/bottom_nav_bar_test.dart)
* **ما تم اختباره**:
  * تصيير التبويبات الثلاثة (الكورسات، شاهدتها، تقدمي).
  * اختبار التبديل التفاعلي عند النقر على الأيقونات وتحديث الـ index المحدد.

#### 6. زر تبديل المظهر (`ThemeToggleButton`)
* **الملف**: [`test/widgets/theme_toggle_button_test.dart`](file:///f:/StudioProjects/thaheen/test/widgets/theme_toggle_button_test.dart)
* **ما تم اختباره**:
  * فحص تحديث حالة الـ ThemeMode داخل الـ `ProviderContainer` من `light` إلى `dark` عند الضغط على الزر.

---

## 4. أبرز التحديات الهندسية والحلول (Engineering Challenges & Solutions)

### أ. عزل التخزين المحلي (Hive/Disk Isolation) عبر Provider Overrides
* **المشكلة**: عند فحص `ThemeToggleButton` في بيئة التيست، كان `ThemeController` يحاول قراءة الإعدادات من `Hive.box('app_settings')`، وهو ما يسبب `HiveError` لأن الـ Database لم تُفتح على الديسك الحقيقي.
* **الحل الهندسي**: تطبيق مبدأ **Inversion of Control (IoC)** عبر استبدال الـ Provider في بيئة الاختبار بـ `_FakeThemeController` باستخدام:
  ```dart
  overrides: [
    themeControllerProvider.overrideWith(_FakeThemeController.new),
  ]
  ```
  هذا يحافظ على الاختبارات نقية وخفيفة، وتعمل في الذاكرة (In-Memory) في أجزاء من الثانية.

### ب. إدارة دورة حياة الـ ChangeNotifier في Riverpod
* **المشكلة**: كان هناك استدعاء مزدوج لـ `dispose()` على `BetterPlayerService` يسبب خطأ `ChangeNotifier used after being disposed`.
* **السبب**: الـ `ChangeNotifierProvider` في Riverpod يقوم تلقائياً باستدعاء `dispose()` على الـ `ChangeNotifier` عند تدمير الحاوية (Container Dispose)، وكان هناك استدعاء إضافي في `ref.onDispose`.
* **الحل**: تنظيف تعريف الـ Provider ليعتمد على دورة الحياة القياسية لإطار العمل دون تكرار.

### ج. التعامل مع ScreenUtil وقيود الريندر في بيئة الاختبارات
* **المشكلة**: في الـ Headless Testing Environment، يكون مقاس الشاشة الافتراضي `800x600`. عند عرض `ModalBottomSheet` بمقاسات حقيقية، قد يحدث `RenderFlex overflow`.
* **الحل**:
  1. ضبط أبعاد الشاشة الافتراضية للتيستر باستخدام:
     ```dart
     tester.view.physicalSize = const Size(1125, 2436);
     tester.view.devicePixelRatio = 3.0;
     ```
  2. إضافة خاصية `isScrollControlled: true` للـ BottomSheet لضمان التجاوب الكامل على كافة أحجام الشاشات.

---

## 5. بنك أسئلة المقابلات وإجاباتها النموذجية (Interview Q&A)

### س1: ما الفرق بين `tester.pump()` و `tester.pumpAndSettle()`؟
> **الإجابة النموذجية**:
> * `tester.pump(Duration duration)` يقوم برسم إطار واحد (Frame) فقط بعد فترة زمنية محددة.
> * `tester.pumpAndSettle()` يستمر في رسم الإطارات ومعالجة الـ Microtasks وتكرار الـ Animation حتى تستقر الشجرة تماماً ولا يتبقى أي Animation أو Async Timer قيد التنفيذ (No pending frames). نستخدمه عند التعامل مع التنقلات، الـ Bottom Sheets، والـ Animations.

---

### س2: لماذا قمت بفصل الـ Unit Tests عن الـ Widget Tests؟
> **الإجابة النموذجية**:
> * اتباعاً لمبادئ **Clean Architecture** و **Test Pyramid**:
>   * الـ **Unit Tests** سريعة جداً وتفحص الـ Pure Business Logic (مثل `ProgressCalculator` و `UnlockPolicy`) بدون أي اعتماد على الـ Flutter UI Framework أو المحاكيات.
>   * الـ **Widget Tests** تركز على التحقق من تجربة المستخدم، الـ State Reflection، دقة الـ Layout، والتفاعل السليم مع أحداث النقر.

---

### س3: كيف تعاملت مع `flutter_screenutil` داخل الـ Widget Tests بدون حدوث Crash؟
> **الإجابة النموذجية**:
> * قمت ببناء **Custom Test Harness** في ملف [`test/test_helper.dart`](file:///f:/StudioProjects/thaheen/test/test_helper.dart) يغلف الويدجيت المختبرة بـ `ScreenUtilInit` مع تحديد `designSize: const Size(375, 812)` وهو نفس الـ Artboard المستخدم في التصميم.
> * هذا يضمن تهيئة كافة دوال الامتداد (`.h`, `.w`, `.r`, `.sp`) بشكل صحيح أثناء الحسابات داخل شجرة التيست.

---

### س4: كيف تختبر مكوناً يعتمد على Local Storage (مثل Hive أو SharedPreferences) دون كتابة ملفات حقيقية على القرص؟
> **الإجابة النموذجية**:
> * باستخدام **Dependency Injection** و **Provider Overrides** في Riverpod.
> * بدلاً من تهيئة قرص التخزين ومسحه بعد كل فحص، نقوم بحقن `FakeRepository` أو عمل `overrideWith` للـ Controller لتخزين البيانات داخل الذاكرة (In-Memory State). هذا يجعل الاختبارات:
>   1. سريعة جداً (Deterministic & Fast).
>   2. معزولة ولا تعتمد على أي حالة خارجية (Stateless & Isolated).

---

### س5: كيف تم اختبار الـ 90% Rule لفتح الدروس؟
> **الإجابة النموذجية**:
> * قمت بإنشاء حالات فحص شملت القيم الحدية (Boundary Value Analysis / Equivalence Partitioning):
>   1. فحص النسبة الدقيقة $90\%$ (مثال: $85.5$ ثانية من $95$ ثانية $\rightarrow$ يعود بـ `true`).
>   2. فحص ما قبل النسبة مباشرة $89\%$ $\rightarrow$ يعود بـ `false`.
>   3. فحص القسمة على صفر عندما تكون مدة الفيديو $0$ لتفادي `NaN` أو `Infinity`.
>   4. التأكد من فتح الدرس التالي فور تحقق شرط الاكتمال للدرس السابق.

---

## 📊 أوامر التشغيل والتحقق السريع (Quick Commands)

```bash
# تشغيل جميع الاختبارات (Unit + Widget)
flutter test

# التحقق من خلو المشروع تماماً من أي تحذيرات أو أخطاء
dart analyze lib test
```

> 🎯 **النتيجة الحالية**:
> * **34 / 34** اختبار ناجح بنسبة 100%.
> * **0** مشاكل في التحليل الساكن (`dart analyze`).
> * مطابقة كاملة لمعايير النظافة المعمارية والـ Clean Code.
