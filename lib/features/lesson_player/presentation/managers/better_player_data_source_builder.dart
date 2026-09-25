import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/services.dart';

class BetterPlayerDataSourceBuilder {
  const BetterPlayerDataSourceBuilder._();

  static Future<BetterPlayerDataSource> build({
    required String assetPath,
    String? title,
    String? author,
  }) async {
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();
    final ext = assetPath.split('.').last;

    return BetterPlayerDataSource(
      BetterPlayerDataSourceType.memory,
      assetPath,
      bytes: bytes,
      videoExtension: ext,
      cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: false),
      notificationConfiguration: const BetterPlayerNotificationConfiguration(
        showNotification: false,
      ),
    );
  }
}
