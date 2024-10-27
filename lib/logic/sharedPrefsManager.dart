import 'package:shared_preferences/shared_preferences.dart';
import 'package:tekupo_noti/logic/utils/convertJsonAndMap.dart';
import 'package:tekupo_noti/models/notifyActiveGrid.dart';
import 'package:tekupo_noti/models/selectedNotify.dart';

class SharedPrefsManager{
  void saveActiveGridToPrefs(NotifyActiveGrid nag) async {
    final prefs = await SharedPreferences.getInstance();
    final grid = nag.activeNotifyGrid;
    final json = grid.convertJsonFromMap();
    prefs.setString("NotifyActiveGrid", json);
  }

  Future<Map<String, bool>> readActiveGridFromPrefs(NotifyActiveGrid nag) async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString("NotifyActiveGrid");
    final grid = json?.convertMapFromJson();
    nag.initGrid(grid);
    return grid ?? NotifyActiveGrid.emptyGrid().activeNotifyGrid;
  }

  void saveSelectedTimeNotifyToPrefs(SelectedNotify selectedNotify) async {
    final prefs = await SharedPreferences.getInstance();
    final json = selectedNotify.map.convertJsonFromMap();
    prefs.setString("SelectedNotify", json);
  }

  Future<SelectedNotify> readSeletedTimeNotifyFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString("SelectedNotify");
    final map = json?.convertMapFromJson();
    final notify = SelectedNotify.getInsFromMap(map);
    return notify;
  }
}
