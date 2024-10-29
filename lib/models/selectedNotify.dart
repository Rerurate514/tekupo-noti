const String IS_ACTIVE_BEFORE = "isActiveBefore";
const String IS_ACTIVE_START = "isActiveStart";
const String IS_ACTIVE_AFTER = "isActiveAfter";

class SelectedNotify {
  final bool isActiveBefore10min;
  final bool isActiveStartSub;
  final bool isActiveAfter5min;

  Map<String, bool> get map {
     return {
      IS_ACTIVE_BEFORE: isActiveBefore10min,
      IS_ACTIVE_START: isActiveStartSub,
      IS_ACTIVE_AFTER: isActiveAfter5min
    };
  }

  const SelectedNotify(
    this.isActiveBefore10min,
    this.isActiveStartSub,
    this.isActiveAfter5min,
  );

  factory SelectedNotify.getInitializeIns(){
    return const SelectedNotify(true, true, true);
  }

  factory SelectedNotify.getInsFromMap(Map<String, bool>? map){
    return SelectedNotify(
      map?[IS_ACTIVE_BEFORE] ?? true,
      map?[IS_ACTIVE_START] ?? true,
      map?[IS_ACTIVE_AFTER] ?? true
    );
  }
}
