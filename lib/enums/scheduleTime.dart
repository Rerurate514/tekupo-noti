import 'package:tekupo_noti/models/time.dart';

enum ScheduleTime{
  ONE,
  TWO,
  THREE,
  FOUR,
  FIVE,
  SIX
}

const START_LESSON_TIME = "startLessonTime";
const END_LESSON_TIME = "endLessonTime";

extension ScheduleTimeEx on ScheduleTime{
  String get minuteStr{
    switch(this){
      case ScheduleTime.ONE: return " 8:50\n    ~ \n10:30";
      case ScheduleTime.TWO: return "10:40\n    ~ \n12:20";
      case ScheduleTime.THREE: return "13:10\n    ~ \n14:50";
      case ScheduleTime.FOUR: return "15:00\n    ~ \n16:40";
      case ScheduleTime.FIVE: return "16:50\n    ~ \n18:30";
      case ScheduleTime.SIX: return "18:40\n    ~ \n20:20";
    }
  }

  int get num{
    switch(this){
      case ScheduleTime.ONE: return 1;
      case ScheduleTime.TWO: return 2;
      case ScheduleTime.THREE: return 3;
      case ScheduleTime.FOUR: return 4;
      case ScheduleTime.FIVE: return 5;
      case ScheduleTime.SIX: return 6;
    }
  }

  Map<String, Time> get getTime{
    switch(this){
      case ScheduleTime.ONE: return { START_LESSON_TIME : Time(8, 50), END_LESSON_TIME: Time(10, 30) };
      case ScheduleTime.TWO: return { START_LESSON_TIME : Time(10, 40), END_LESSON_TIME: Time(12, 20) };
      case ScheduleTime.THREE: return { START_LESSON_TIME : Time(13, 10), END_LESSON_TIME: Time(14, 50) };
      case ScheduleTime.FOUR: return { START_LESSON_TIME : Time(15, 0), END_LESSON_TIME: Time(16, 40) };
      case ScheduleTime.FIVE: return { START_LESSON_TIME : Time(16, 50), END_LESSON_TIME: Time(18, 30) };
      case ScheduleTime.SIX: return { START_LESSON_TIME : Time(18, 40), END_LESSON_TIME: Time(20, 20) };
    }
  }
}