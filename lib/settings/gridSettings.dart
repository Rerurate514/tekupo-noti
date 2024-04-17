enum GridSettings{
  vertical,
  horizontal
}

extension GridSettingsEx on GridSettings{
  double get factor {
    switch(this){
      case GridSettings.vertical: return 0.11;
      case GridSettings.horizontal: return 0.124;
    }
  }
}