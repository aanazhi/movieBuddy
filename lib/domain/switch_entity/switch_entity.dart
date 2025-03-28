class SwitchEntity {
  final bool isFirstSwitched;
  final bool isSecondSwitched;

  SwitchEntity({this.isFirstSwitched = false, this.isSecondSwitched = false});

  SwitchEntity copyWith({
    bool? isFirstSwitched,
    bool? isSecondSwitched,
  }) =>
      SwitchEntity(
        isFirstSwitched: isFirstSwitched ?? this.isFirstSwitched,
        isSecondSwitched: isSecondSwitched ?? this.isSecondSwitched,
      );
}
