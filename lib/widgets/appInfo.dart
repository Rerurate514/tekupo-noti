import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppInfo extends StatelessWidget{
  bool _isNoticeBefore10min = true;
  bool _isNoticeStartSub = true;
  bool _isNoticeAfter5min = true;

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "通知の時間",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: size.width * 0.1),
        Column(
          children: [
            buildCard(context, "開始10分前", _isNoticeBefore10min),
            buildCard(context, "始まった時間", _isNoticeStartSub),
            buildCard(context, "開始5分後", _isNoticeAfter5min),
          ],
        )
      ],
    );
  }

  Widget buildCard(BuildContext context, String discription, bool isActive){
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.35,
      height: size.height * 0.053,
      child: isActive
        ? Card(
          color: Colors.white,
          elevation: 1,
          child: Row(
            children: [
              SizedBox(width: size.width * 0.01),
              const Icon(
                Icons.notifications,
                size: 25,
              ),
              SizedBox(width: size.width * 0.02),
              Text(
                discription,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
        : Card(
        color: Colors.redAccent,
        elevation: 1,
        child: Row(
          children: [
            SizedBox(width: size.width * 0.01),
            const Icon(
              Icons.notifications_off,
              size: 25,
            ),
            SizedBox(width: size.width * 0.02),
            Text(
              discription,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}