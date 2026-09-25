import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainNavController extends Notifier<int> {
  @override
  int build() => 0;

  void setTab(int index) => state = index;
}

final mainNavControllerProvider =
    NotifierProvider<MainNavController, int>(MainNavController.new);
