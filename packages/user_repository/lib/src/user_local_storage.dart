import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';

class UserLocalStorage {
  UserLocalStorage({
    required this.noSqlStorage,
  });

  final KeyValueStorage noSqlStorage;

  Future<void> upsertDarkModePreference(DarkModePreference theme) async {
    switch (theme) {
      case DarkModePreference.alwaysDark:
        await noSqlStorage.setThemeValue('alwaysDark');
        return;
      case DarkModePreference.alwaysLight:
        await noSqlStorage.setThemeValue('alwaysLight');
        return;
      default:
        await noSqlStorage.setThemeValue('alwaysLight');
        return;
    }
  }

  Future<DarkModePreference> getDarkModePreference() async {
    String themeString = await noSqlStorage.getThemeValue();

    switch (themeString) {
      case 'alwaysLight':
        return DarkModePreference.alwaysLight;
      case 'alwaysDark':
        return DarkModePreference.alwaysDark;
      default:
        return DarkModePreference.alwaysDark;
    }
  }
}
