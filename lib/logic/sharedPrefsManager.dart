import 'package:shared_preferences/shared_preferences.dart';
import 'package:tekupo_noti/logic/utils/convertJsonAndMap.dart';
import 'package:tekupo_noti/models/notifyActiveGrid.dart';

class SharedPrefsManager{
  final _nag = NotifyActiveGrid();

  void saveActiveGridToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final grid = _nag.activeNotifyGrid;
    final json = grid.convertJsonFromMap();
    prefs.setString("NotifyActiveGrid", json);
  }

  Future<Map<String, bool>> readActiveGridFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString("NotifyActiveGrid");
    final grid = json?.convertMapFromJson();
    return grid!;
  }
}