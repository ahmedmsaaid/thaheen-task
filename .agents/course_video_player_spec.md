# Course App Video Player — Implementation Spec

> **Audience:** coding agent implementing this in an existing Flutter courses app.
> **UI language:** Arabic (RTL) is primary, English is secondary.
> **Rule for the agent:** before writing any code, check the exact API names against the installed package version. Some names below come from the original `better_player` and may differ in the fork. When an item is marked **VERIFY**, confirm it in source or the IDE. Do not guess.

---

## 1. Package

| Item | Value |
|---|---|
| Package | `better_player_plus` |
| Version | pin an exact version, e.g. `better_player_plus: 1.3.2` (no `^`, because the package warns about breaking changes between versions) |
| Requirements (v1.2.0+) | Dart SDK `>=3.11.0`, Flutter SDK `>=3.41.0`, Android Media3 `1.10.0` |
| Import | `import 'package:better_player_plus/better_player_plus.dart';` |
| Docs | https://pub.dev/packages/better_player_plus · https://github.com/Segatti/better_player_plus (`doc/install.md`, `example/`) |
| Fallback if it blocks us | `awesome_video_player` (another fork with the same API family) |

**Built-in capabilities we rely on:** HLS and DASH with quality, audio and subtitle tracks; SRT and WebVTT subtitles; playback speed; alternate resolutions; caching; HTTP headers; Picture-in-Picture; notifications; DRM (token, Widevine, FairPlay); playlists; Material and Cupertino controls; `BetterPlayerTranslations`.

Follow `doc/install.md` for the Android (minSdk, Media3) and iOS (PiP / background modes in `Info.plist`) setup.

---

## 2. Architecture

```
lib/features/player/
├── data/
│   ├── models/          # Lesson, VideoSource, Chapter, Note, Bookmark, Progress
│   ├── player_repository.dart   # progress sync, notes, signed URLs
├── controller/
│   └── course_player_controller.dart  # wraps BetterPlayerController + business logic
├── ui/
│   ├── course_player_screen.dart
│   ├── widgets/
│   │   ├── player_view.dart            # BetterPlayer wrapped in LTR Directionality
│   │   ├── watermark_overlay.dart
│   │   ├── chapters_seekbar_markers.dart
│   │   ├── gesture_layer.dart          # double-tap seek, brightness/volume swipe
│   │   ├── next_lesson_countdown.dart
│   │   ├── in_video_quiz_overlay.dart
│   │   ├── notes_panel.dart
│   │   └── transcript_panel.dart
│   └── l10n/player_translations.dart
└── services/
    ├── screen_protection_service.dart
    ├── download_service.dart
    └── player_analytics_service.dart
```

- Use one `CoursePlayerController` that owns the `BetterPlayerController`. The UI must never touch `BetterPlayerController` directly, except through `BetterPlayer(controller: ...)`.
- Use the state management the app already has (Riverpod, Bloc, or other). Do not introduce a new one.
- Always dispose the controller: `controller.dispose()` in `dispose()`, after flushing progress.

---

## 3. Base configuration

```dart
final config = BetterPlayerConfiguration(
  aspectRatio: 16 / 9,
  fit: BoxFit.contain,
  autoPlay: true,
  startAt: resumePosition,                 // Duration from saved progress
  handleLifecycle: true,
  autoDispose: false,                      // we dispose manually after saving progress
  translations: PlayerTranslations.all,    // see section 5
  subtitlesConfiguration: const BetterPlayerSubtitlesConfiguration(
    fontFamily: 'Cairo',                   // must be declared in pubspec
    fontSize: 18,
    fontColor: Colors.white,
    backgroundColor: Color(0x99000000),
    outlineEnabled: true,
  ),
  controlsConfiguration: const BetterPlayerControlsConfiguration(
    enablePlaybackSpeed: true,
    enableSubtitles: true,
    enableQualities: true,
    enableAudioTracks: true,
    enablePip: true,
    enableSkips: true,
    forwardSkipTimeInMilliseconds: 10000,
    backwardSkipTimeInMilliseconds: 10000,
    enableProgressBarDrag: true,
    enableFullscreen: true,
  ),
);

final dataSource = BetterPlayerDataSource(
  BetterPlayerDataSourceType.network,
  signedHlsUrl,                            // .m3u8 from backend
  headers: {'Authorization': 'Bearer $token'},
  subtitles: [
    BetterPlayerSubtitlesSource(
      type: BetterPlayerSubtitlesSourceType.network,
      name: 'العربية',
      urls: [arabicVttUrl],
      selectedByDefault: true,
    ),
    BetterPlayerSubtitlesSource(
      type: BetterPlayerSubtitlesSourceType.network,
      name: 'English',
      urls: [englishVttUrl],
    ),
  ],
  cacheConfiguration: const BetterPlayerCacheConfiguration(
    useCache: true,
    maxCacheSize: 500 * 1024 * 1024,
    maxCacheFileSize: 100 * 1024 * 1024,
  ),
  notificationConfiguration: BetterPlayerNotificationConfiguration(
    showNotification: true,
    title: lesson.title,
    author: course.title,
  ),
);
```

**VERIFY:** parameter names in `BetterPlayerControlsConfiguration`, `BetterPlayerSubtitlesConfiguration` and `BetterPlayerNotificationConfiguration` against the installed version.

Speed options: `0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0`.

---

## 4. Features

Priority: **P0** is needed for launch, **P1** comes right after launch, **P2** is nice to have.

### 4.1 Core playback

| # | Feature | Pri | Acceptance criteria |
|---|---|---|---|
| 1 | Resume playback | P0 | Save the position every 10s, on pause, on background, and on dispose. Save locally first, then sync to the server. On open, start at the saved position (skip this if the saved position is under 5s from the end). Sync must work across devices. |
| 2 | Playback speed | P0 | Speeds 0.5x to 2x. The chosen speed persists per user, not per lesson. |
| 3 | Quality switching | P0 | Auto (HLS ABR) plus manual 1080/720/480/360. Keep the position when switching. |
| 4 | Subtitles | P0 | Arabic and English as VTT or SRT in UTF-8. Remember the last chosen language. Include an "Off" option. |
| 5 | Double-tap seek | P0 | Double-tap on the left third seeks −10s, on the right third +10s, with a ripple showing "10 ثوانٍ". Tapping more times adds more seconds. |
| 6 | Gestures | P1 | Vertical swipe on the right half changes volume, on the left half changes brightness, with an on-screen indicator. Enable only in fullscreen. Brightness: e.g. `screen_brightness` (**VERIFY**). |
| 7 | Fullscreen and orientation | P0 | Fullscreen forces landscape. Exiting restores portrait. Tapping the back button while in fullscreen exits fullscreen first. |
| 8 | Keep screen awake | P0 | The screen must not sleep during playback. The package handles wakelock, but verify this on both platforms. |

### 4.2 Learning features

| # | Feature | Pri | Acceptance criteria |
|---|---|---|---|
| 9 | Chapters and timestamps | P1 | Show markers on the seekbar from `lesson.chapters`. Include a chapters list, and tapping a chapter seeks to it. Show the current chapter title in the controls. Needs a custom seekbar overlay or custom controls through `customControlsBuilder` (**VERIFY**). |
| 10 | Notes | P1 | A "Add note" button captures the current timestamp, and the note is saved with `{lessonId, positionMs, text}`. The notes panel lists notes sorted by time, and tapping a note seeks to it. Sync notes to the server. |
| 11 | Bookmarks | P1 | Same as notes but with no text. Bookmarks also appear as markers on the seekbar. |
| 12 | Auto-next lesson | P0 | When the video finishes, show a 5s countdown card ("الدرس التالي خلال 5") with Cancel and Play-now buttons. Use the `finished` event. Do not advance if the next lesson is locked. |
| 13 | Completion tracking | P0 | Mark a lesson complete when watched ≥ 90%, counted as the union of watched segments, not the max position (to prevent seek-to-end cheating). Send this to the server once. |
| 14 | In-video quizzes | P2 | At `quiz.positionMs`, pause and show an overlay question. Resume on answer. Optionally block seeking past an unanswered required quiz. |
| 15 | Transcript | P2 | Show a synced transcript panel from the VTT that highlights the current cue. Tapping a line seeks to it. Include search. |
| 16 | AI summary / Q&A | P2 | Add a button that calls the backend endpoint with `lessonId`. The UI only; the backend provides the logic. |

### 4.3 Security (paid content)

| # | Feature | Pri | Acceptance criteria |
|---|---|---|---|
| 17 | Dynamic watermark | P0 | Show the user's email or phone plus user ID at ~15% opacity. Move it to a random position every 20–30s. It must render above the video in fullscreen too, including inside the fullscreen route (**VERIFY** how to overlay in the package's fullscreen, since this may need `overlay` in the configuration or custom controls). |
| 18 | Screenshot / recording block | P0 | **Android:** apply `FLAG_SECURE` while the player screen is open, e.g. with `screen_protector` or `no_screenshot` (**VERIFY**). **iOS:** screenshots cannot be fully blocked. Detect screen recording or mirroring with `UIScreen.isCaptured` and pause plus blur the video while captured. Show a message: "لا يمكن تشغيل الفيديو أثناء تسجيل الشاشة". |
| 19 | Signed URLs | P0 | Get short-lived signed HLS URLs from the backend per lesson and refresh them on 403. Never hardcode media URLs. |
| 20 | Encrypted HLS / DRM | P1 | Use at least HLS AES-128 with the key served behind auth headers. Use Widevine/FairPlay later through `drmConfiguration` if the budget allows. |
| 21 | Offline downloads | P1 | Downloads stay in app-private storage, encrypted. They must not show in the gallery. Expire them after N days or on logout. Show download progress per lesson. Use the package's cache/preCache or a dedicated downloader (**decide after checking** whether the package cache is enough for full offline HLS). |

### 4.4 UX extras

| # | Feature | Pri | Acceptance criteria |
|---|---|---|---|
| 22 | Picture-in-Picture | P1 | Add a PiP button. Enter PiP automatically when the app goes to background during playback (Android). Configure iOS background modes. |
| 23 | Background audio | P2 | Add an "Audio only" toggle that keeps audio playing with the screen locked, with media notification controls. |
| 24 | Chromecast / AirPlay | P2 | Add a cast button (**VERIFY** package support; otherwise use a separate cast plugin). |
| 25 | Analytics | P1 | Send events: `play, pause, seek(from,to), speed_change, quality_change, complete, drop_off(positionMs)`. Batch them and send every 30s. These feed the drop-off heatmap per lesson. |

---

## 5. Arabic and RTL

### 5.1 Keep the player LTR

The app is RTL, but the seekbar and controls must stay LTR or seeking breaks visually:

```dart
Directionality(
  textDirection: TextDirection.ltr,
  child: BetterPlayer(controller: betterPlayerController),
)
```

Every custom overlay that shows time or position (chapters markers, countdown, quiz, watermark) must also sit inside this LTR wrapper. Arabic text inside those overlays should be wrapped back in `Directionality(textDirection: TextDirection.rtl)` at the text level.

### 5.2 Translations

The original `better_player` shipped Arabic translations. Try the built-in factory first:

```dart
translations: [BetterPlayerTranslations.arabic()],  // VERIFY name in the fork
```

If it doesn't exist, or the wording is weak, use the custom one below, which is preferred anyway for consistent wording:

```dart
class PlayerTranslations {
  static final ar = BetterPlayerTranslations(
    languageCode: 'ar',
    generalDefaultError: 'تعذّر تشغيل الفيديو',
    generalNone: 'بدون',
    generalDefault: 'افتراضي',
    generalRetry: 'إعادة المحاولة',
    playlistLoadingNextVideo: 'جاري تحميل الدرس التالي',
    controlsLive: 'مباشر',
    controlsNextVideoIn: 'الدرس التالي خلال',
    overflowMenuPlaybackSpeed: 'سرعة التشغيل',
    overflowMenuSubtitles: 'الترجمة',
    overflowMenuQuality: 'الجودة',
    overflowMenuAudioTracks: 'الصوت',
    qualityAuto: 'تلقائي',
  );

  static final all = [ar, BetterPlayerTranslations()]; // English default
}
```

**VERIFY:** the full field list of `BetterPlayerTranslations` in the installed version, and translate any extra fields.

### 5.3 Subtitles and fonts

- Subtitle files must be UTF-8 (no BOM issues). Test with Arabic diacritics.
- Use the Arabic font `Cairo` or `Tajawal` from `pubspec.yaml` assets, not a network font.
- Use a semi-transparent background behind subtitles.

### 5.4 App strings

All custom UI strings (notes, chapters, countdown, quiz, download, errors) go through the app's existing l10n system (ARB), with `ar` and `en`.

---

## 6. Data models (suggested)

```dart
class Lesson {
  final String id, courseId, title;
  final Duration duration;
  final List<Chapter> chapters;
  final List<SubtitleTrack> subtitles;
  final List<InVideoQuiz> quizzes;
  final String? nextLessonId;
  final bool isLocked;
}

class Chapter   { final String title; final Duration start; }
class Note      { final String id, lessonId, text; final Duration position; final DateTime createdAt; }
class Bookmark  { final String id, lessonId; final Duration position; }
class Progress  { final String lessonId; final Duration lastPosition; final List<Range> watchedRanges; final bool completed; }
```

## 7. Backend endpoints (contract to confirm with the backend team)

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/lessons/{id}/playback` | Returns signed HLS URL, subtitles, chapters, quizzes, headers/token, expiry |
| PUT | `/lessons/{id}/progress` | `{positionMs, watchedRanges}` |
| POST | `/lessons/{id}/complete` | Marks the lesson complete (idempotent) |
| GET/POST/DELETE | `/lessons/{id}/notes` | CRUD for notes |
| GET/POST/DELETE | `/lessons/{id}/bookmarks` | CRUD for bookmarks |
| POST | `/analytics/player-events` | Batched events |

If these endpoints don't exist yet, create a repository interface plus a mock implementation so the UI can be built and tested.

---

## 8. Implementation phases

1. **Phase 1 (P0):** package setup (Android/iOS), base player, LTR wrapper plus Arabic translations, resume, speed, quality, subtitles, double-tap seek, fullscreen, auto-next, completion tracking, watermark, screen protection, signed URLs.
2. **Phase 2 (P1):** chapters, notes, bookmarks, gestures, PiP, analytics, offline downloads, AES-128.
3. **Phase 3 (P2):** quizzes, transcript, AI summary, background audio, casting.

Finish and test each phase before starting the next.

## 9. Test checklist

- [ ] Arabic device locale shows Arabic controls. English locale shows English controls.
- [ ] Seekbar drags in the correct direction in an RTL app.
- [ ] Arabic subtitles render correctly (connected letters, diacritics, no mojibake).
- [ ] Resume works after killing the app, and on a second device.
- [ ] Completion cannot be triggered by seeking to the end.
- [ ] Watermark is visible in fullscreen and in PiP.
- [ ] Android screenshot shows a black frame. iOS screen recording pauses and blurs.
- [ ] An expired signed URL refreshes without crashing.
- [ ] Quality switch and speed change keep the position.
- [ ] Controller is disposed with no memory leak when switching lessons quickly.
- [ ] Tested on low-end Android plus a recent iPhone, on Wi-Fi and 3G.
