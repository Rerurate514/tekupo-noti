enum DayOfWeek{
  SUNDAY,
  MONDAY,
  TUESDAY,
  WEDNESDAY,
  TURSDAy,
  FRIDAY,
  SATURDAY
}

extension DayOfWeekJpEx on DayOfWeek{
  String get jpStr{
    switch(this){
      case DayOfWeek.SUNDAY: return "日";
      case DayOfWeek.MONDAY: return "月";
      case DayOfWeek.TUESDAY: return "火";
      case DayOfWeek.WEDNESDAY: return "水";
      case DayOfWeek.TURSDAy: return "木";
      case DayOfWeek.FRIDAY: return "金";
      case DayOfWeek.SATURDAY: return "土";
    }
  } 
}