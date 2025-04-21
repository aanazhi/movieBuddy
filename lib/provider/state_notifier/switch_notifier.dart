import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/domain/switch_entity/switch_entity.dart';

class SwitchNotifier extends StateNotifier<SwitchEntity> {
  SwitchNotifier() : super(SwitchEntity());

  void toggleFirstSwitch() {
    state = state.copyWith(isFirstSwitched: !state.isFirstSwitched);
  }

  void toggleSeconfSwitch() {
    state = state.copyWith(isSecondSwitched: !state.isSecondSwitched);
  }
}
