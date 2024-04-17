import 'package:flutter_test/flutter_test.dart';

class Time{
  final int hour;
  final int minutes;

  Time get before10minTime => _calcHourMin(Time(hour, minutes - 10));
  Time get after5minTime => _calcHourMin(Time(hour, minutes + 5));

  Time(
    this.hour,
    this.minutes
  );

  Time _calcHourMin(Time time){
    int calcedHour = time.hour;
    int calcedMinute = time.minutes;

    if(calcedMinute >= 60){
      calcedMinute = 0;
      calcedHour++;
    }

    if(calcedMinute < 0){
      calcedMinute = (60 + calcedMinute);
      calcedHour--;
    }

    return Time(calcedHour, calcedMinute);
  }
}

void main(){
  test("time-test", () {
    Time time11 = Time(10, 30);
    Time time12 = time11.before10minTime;
    Time time13 = time11.after5minTime;
    expect(time12.minutes, 20);
    expect(time13.minutes, 35);

    Time time21 = Time(10, 0);
    Time time22 = time21.before10minTime;
    Time time23 = time21.after5minTime;
    expect(time22.minutes,  50);
    expect(time23.minutes, 5);

    Time time31 = Time(10, 55);
    Time time32 = time31.before10minTime;
    Time time33 = time31.after5minTime;
    expect(time32.minutes, 45);
    expect(time33.minutes, 0);
  });
}