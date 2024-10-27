const String IS_ACTIVE_BEFORE = "isActiveBefore";
const String IS_ACTIVE_START = "isActiveStart";
const String IS_ACTIVE_AFTER = "isActiveAfter";

class SelectedNotify {
  final bool isActiveBefore;
  final bool isActiveStart;
  final bool isActiveAfter;

  Map<String, bool> get map {
     return {
      IS_ACTIVE_BEFORE: isActiveBefore,
      IS_ACTIVE_START: isActiveStart,
      IS_ACTIVE_AFTER: isActiveAfter
    };
  }

  const SelectedNotify(
    this.isActiveBefore,
    this.isActiveStart,
    this.isActiveAfter,
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
