import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tekupo_noti/enums/dayOfWeek.dart';
import 'package:tekupo_noti/enums/scheduleTime.dart';
import 'package:tekupo_noti/models/notifyActiveGrid.dart';

final nagProvider = StateNotifierProvider<NotifyActiveGridRepositry, NotifyActiveGrid>((ref) {
  return NotifyActiveGridRepositry();
});

class NotifyActiveGridRepositry extends StateNotifier<NotifyActiveGrid>{
  NotifyActiveGridRepositry() : super(NotifyActiveGrid.emptyGrid());

  void initGrid([Map<String, bool>? grid]){
    if(grid == null){
      state = NotifyActiveGrid.emptyGrid();
    }
    else{
      state = NotifyActiveGrid.existGrid(grid);
    }
  }

  bool getActiveGrid({required DayOfWeek dayOfWeek, required ScheduleTime scheduleTime}){
    return state.getActiveGrid(dayOfWeek: dayOfWeek, scheduleTime: scheduleTime);
  }

  void toggleActiveGrid({required DayOfWeek dayOfWeek, required ScheduleTime scheduleTime}){
    state.toggleActiveGrid(dayOfWeek: dayOfWeek, scheduleTime: scheduleTime);
    initGrid(state.activeNotifyGrid);
  }
}
