import 'main_screen_localizations.dart';

/// The translations for English (`en`).
class MainScreenLocalizationsEn extends MainScreenLocalizations {
  MainScreenLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Weather Counter';

  @override
  String get description_location => 'Press the cloud icon to get your location';

  @override
  String get temperature => 'Temperature in Kelvin is : ';

  @override
  String get description_count => 'You have pushed the button this many times';
}
