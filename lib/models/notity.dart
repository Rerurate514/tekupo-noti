import 'package:tekupo_noti/models/time.dart';

abstract class Notity{
  String get notifyText;
  Time get StartTime;
  Time get EndTime;
}

class Before10minNotifier extends Notity{
  @override
  Time get EndTime => throw UnimplementedError();

  @override
  Time get StartTime => throw UnimplementedError();

  @override
  String get notifyText => "授業開始10分前の通知";
}

class StartLessonNotifier extends Notity{
  @override
  Time get EndTime => throw UnimplementedError();

  @override
  Time get StartTime => throw UnimplementedError();

  @override
  String get notifyText => throw "授業開始時の通知";
}

class After5minNotifier extends Notity{
  @override
  Time get EndTime => throw UnimplementedError();

  @override
  Time get StartTime => throw UnimplementedError();

  @override
  String get notifyText => "授業開始5分後の通知";
}