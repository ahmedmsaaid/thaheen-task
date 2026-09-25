import 'package:flutter_test/flutter_test.dart';
import 'package:thaheen/core/utils/arabic_normalizer.dart';

void main() {
  group('ArabicNormalizer Tests', () {
    test('normalizes alef variations', () {
      expect(ArabicNormalizer.normalize('إبراهيم'), 'ابراهيم');
      expect(ArabicNormalizer.normalize('أحمد'), 'احمد');
      expect(ArabicNormalizer.normalize('آدم'), 'ادم');
    });

    test('normalizes taa marbouta to haa', () {
      expect(ArabicNormalizer.normalize('صيدلة'), 'صيدله');
      expect(ArabicNormalizer.normalize('مقدمة'), 'مقدمه');
    });

    test('normalizes yaa and alef maksoura', () {
      expect(ArabicNormalizer.normalize('مستشفى'), 'مستشفي');
      expect(ArabicNormalizer.normalize('علي'), 'علي');
    });

    test('removes diacritics / tashkeel', () {
      expect(ArabicNormalizer.normalize('فَارْمَاكُولُوجِي'), 'فارماكولوجي');
      expect(ArabicNormalizer.normalize('عِلْمُ الأَحْيَاء'), 'علم الاحياء');
    });

    test('containsQuery matches variations correctly', () {
      expect(
        ArabicNormalizer.containsQuery('علم الأحياء الدقيقة', 'احياء'),
        isTrue,
      );
      expect(
        ArabicNormalizer.containsQuery('مقدمة في الصيدلة', 'صيدله'),
        isTrue,
      );
      expect(
        ArabicNormalizer.containsQuery('د. سارة المنصوري', 'ساره'),
        isTrue,
      );
      expect(
        ArabicNormalizer.containsQuery('علم التشريح', 'طوارئ'),
        isFalse,
      );
    });
  });
}
