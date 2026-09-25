class ArabicNormalizer {
  ArabicNormalizer._();

  /// Normalizes Arabic text by removing diacritics (tashkeel)
  /// and standardizing alef, taa marbouta, and yaa characters.
  static String normalize(String input) {
    if (input.isEmpty) return '';
    var text = input.trim().toLowerCase();

    // 1. Remove diacritics / tashkeel
    text = text.replaceAll(RegExp(r'[\u064B-\u065F\u0670]'), '');

    // 2. Normalize Alef variations (إ, أ, آ, ٱ -> ا)
    text = text.replaceAll(RegExp(r'[إأآٱ]'), 'ا');

    // 3. Normalize Taa Marbouta (ة -> ه)
    text = text.replaceAll('ة', 'ه');

    // 4. Normalize Yaa and Alef Maksoura (ى -> ي)
    text = text.replaceAll('ى', 'ي');

    return text;
  }

  /// Checks if [source] contains [query] using normalized matching.
  static bool containsQuery(String source, String query) {
    final cleanQuery = query.trim();
    if (cleanQuery.isEmpty) return true;
    final normSource = normalize(source);
    final normQuery = normalize(cleanQuery);
    return normSource.contains(normQuery);
  }
}
