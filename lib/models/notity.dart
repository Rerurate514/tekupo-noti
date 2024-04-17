import 'package:tekupo_noti/enums/scheduleTime.dart';
import 'package:tekupo_noti/models/time.dart';

abstract class Notity{
  String get title;
  String get bodyText;
  Time getStartLessonTime(ScheduleTime scheduleTime) => scheduleTime.getTime[START_LESSON_TIME]!;
  Time getEndLessonTime(ScheduleTime scheduleTime) => scheduleTime.getTime[END_LESSON_TIME]!;
  Time getNotifyTime(ScheduleTime scheduleTime);
}

class Before10minNotifier extends Notity{
  @override
  String get title => "授業開始10分前です!";

  @override
  String get bodyText => "授業開始10分前の通知";
  
  @override
  Time getNotifyTime(ScheduleTime scheduleTime) => scheduleTime.getTime[START_LESSON_TIME]!.before10minTime;
}

class StartLessonNotifier extends Notity{
  @override
  String get title => "授業が開始しました!";

  @override
  String get bodyText => throw "授業開始時の通知";  

  @override
  Time getNotifyTime(ScheduleTime scheduleTime) => scheduleTime.getTime[START_LESSON_TIME]!;
}

class After5minNotifier extends Notity{
  @override
  String get title => "授業開始5分後です!";

  @override
  String get bodyText => "授業開始5分後の通知";
  
  @override
  Time getNotifyTime(ScheduleTime scheduleTime) => scheduleTime.getTime[START_LESSON_TIME]!.after5minTime;
}