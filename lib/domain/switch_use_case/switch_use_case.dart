import 'package:moviebuddy/data/switch_repository/switch_repository.dart';

abstract class SwitchUseCase {
  void toggleFirstSwitch();
  void toggleSecondSwitch();
}

class SwitchUseCaseImpl implements SwitchUseCase {
  final SwitchRepository _switchRepository;

  SwitchUseCaseImpl({required SwitchRepository switchRepository})
      : _switchRepository = switchRepository;

  @override
  void toggleFirstSwitch() {
    _switchRepository.toggleFirstSwitch();
  }

  @override
  void toggleSecondSwitch() {
    _switchRepository.toggleSecondSwitch();
  }
}
