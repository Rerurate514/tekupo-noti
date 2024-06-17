import 'dart:convert' as convert;

extension ConvertJsonFromMap on Map<String, bool>{
  String convertJsonFromMap(){
    final json = convert.json.encode(this);

    return json;
  }
}

extension ConvertMapFromJson on String?{
  Map<String, bool> convertMapFromJson(){
    final map = convert.json.decode(this ?? "");

    Map<String, bool> convertedMap = {};
    map.forEach((key, value) {
      if (value is bool) {
        convertedMap[key] = value;
      }
    });

    return convertedMap;
  }
}