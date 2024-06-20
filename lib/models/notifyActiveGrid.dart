import 'package:tekupo_noti/enums/dayOfWeek.dart';
import 'package:tekupo_noti/enums/scheduleTime.dart';

class NotifyActiveGrid{
  NotifyActiveGrid._();

  factory NotifyActiveGrid.emptyGrid(){
    var nag = NotifyActiveGrid._();
    nag.initGrid();
    return nag; 
  }

  factory NotifyActiveGrid.existGrid(Map<String, bool> grid){
    var nag = NotifyActiveGrid._();
    nag.initGrid(grid);
    return nag; 
  }

  Map<String, bool> _activeNotifyGrid = {};
  Map<String, bool> get activeNotifyGrid {
    return _activeNotifyGrid;
  }

  void initGrid([Map<String, bool>? grid]) async {
    if(grid != null){
      _activeNotifyGrid = grid;
      return;
    }

    _activeNotifyGrid = {};
    for(var scheduleTime in ScheduleTime.values){
      for(var dayOfWeek in DayOfWeek.values){
        _activeNotifyGrid.addAll({"$dayOfWeek$scheduleTime": false});
      }
    }
  }

  bool getActiveGrid({required DayOfWeek dayOfWeek, required ScheduleTime scheduleTime}){
    return _activeNotifyGrid["$dayOfWeek$scheduleTime"] ?? false;
  }

  void toggleActiveGrid({required DayOfWeek dayOfWeek, required ScheduleTime scheduleTime}){
    _activeNotifyGrid["$dayOfWeek$scheduleTime"] = !_activeNotifyGrid["$dayOfWeek$scheduleTime"]!;
  }
}
