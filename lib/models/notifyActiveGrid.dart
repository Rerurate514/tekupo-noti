import 'package:tekupo_noti/enums/dayOfWeek.dart';
import 'package:tekupo_noti/enums/scheduleTime.dart';

class NotifyActiveGrid{
  NotifyActiveGrid([Map<String, bool>? grid]){
    initGrid(grid);
  }

  Map<String, bool> _activeNotifyGrid = {};
  Map<String, bool> get activeNotifyGrid {
    _checkInitializedObj("activeotufyGrid");
    return _activeNotifyGrid;
  }

  bool _isInit = false;

  void _checkInitializedObj(String method){
    if(!_isInit){
      throw Exception("Failed to execute NotifyLogic in NotifyActiveGridController. still not init Instance. do [ $method ] method.");
    }
  }

  void initGrid([Map<String, bool>? grid]) async {
    _isInit = true;

    if(grid != null){
      _activeNotifyGrid = grid;
      return;
    }

    for(var scheduleTime in ScheduleTime.values){
      for(var dayOfWeek in DayOfWeek.values){
        _activeNotifyGrid.addAll({"$dayOfWeek$scheduleTime": false});
      }
    }
  }

  bool getActiveGrid({required DayOfWeek dayOfWeek, required ScheduleTime scheduleTime}){
    _checkInitializedObj("getActiveGrid");
    return _activeNotifyGrid["$dayOfWeek$scheduleTime"]!;
  }

  void toggleActiveGrid({required DayOfWeek dayOfWeek, required ScheduleTime scheduleTime}){
    _checkInitializedObj("toggleActiveGrid");
    _activeNotifyGrid["$dayOfWeek$scheduleTime"] = !_activeNotifyGrid["$dayOfWeek$scheduleTime"]!;
  }
}