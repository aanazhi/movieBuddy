import 'package:moviebuddy/provider/state_notifier.dart';

abstract class SwitchRepository {
  void toggleFirstSwitch();
  void toggleSecondSwitch();
}

class SwitchRepositoryImpl implements SwitchRepository {
  final SwitchNotifier _switchNotifier;

  SwitchRepositoryImpl({required SwitchNotifier switchNotifier})
      : _switchNotifier = switchNotifier;
  @override
  void toggleFirstSwitch() {
    _switchNotifier.toggleFirstSwitch();
  }

  @override
  void toggleSecondSwitch() {
    _switchNotifier.toggleSeconfSwitch();
  }
}
