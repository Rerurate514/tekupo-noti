import 'package:tekupo_noti/enums/scheduleTime.dart';
import 'package:tekupo_noti/widgets/weekLabel.dart';

class NotifyActiveGrid{
  NotifyActiveGrid._();

  static NotifyActiveGrid? _instance;

  factory NotifyActiveGrid(){
    _instance ??= NotifyActiveGrid._();
    return _instance!;
  }

  Map<String, bool> _activeNotifyGrid = {};

  bool _isInit = false;

  void _checkInitializedObj(){
    if(!_isInit){
      throw Exception("Failed to execute NotifyLogic in NotifyActiveGridController. still not init Instance. do [ initGrid ] method.");
    }
  }

  void initGrid() async {
    _isInit = true;

    for(var scheduleTime in ScheduleTime.values){
      for(var dayOfWeek in DayOfWeek.values){
        _activeNotifyGrid.addAll({"$dayOfWeek$scheduleTime": false});
      }
    }
    print(_activeNotifyGrid);
  }

  bool getActiveGrid({required DayOfWeek dayOfWeek, required ScheduleTime scheduleTime}){
    _checkInitializedObj();
    return _activeNotifyGrid["$dayOfWeek$scheduleTime"]!;
  }

  void toggleActiveGrid({required DayOfWeek dayOfWeek, required ScheduleTime scheduleTime}){
    _checkInitializedObj();
    _activeNotifyGrid["$dayOfWeek$scheduleTime"] = !_activeNotifyGrid["$dayOfWeek$scheduleTime"]!;
  }
}