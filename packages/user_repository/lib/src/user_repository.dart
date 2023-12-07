import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/src/user_local_storage.dart';
import 'package:weather_api/weather_api.dart';

class UserRepository {
  UserRepository({
    required KeyValueStorage noSqlStorage,
    UserLocalStorage? localStorage, required this.weatherApi,
  }) : _localStorage = localStorage ??
            UserLocalStorage(
              noSqlStorage: noSqlStorage,
            );

  final UserLocalStorage _localStorage;
  final WeatherApi weatherApi;

  final BehaviorSubject<DarkModePreference> _darkModePreferenceSubject =
      BehaviorSubject();

  Future<void> toggleDarkModePreference() async {
    DarkModePreference latsTheme =
        _darkModePreferenceSubject.valueOrNull ?? DarkModePreference.alwaysDark;

    latsTheme = (latsTheme == DarkModePreference.alwaysLight)
        ? DarkModePreference.alwaysDark
        : DarkModePreference.alwaysLight;

    await _localStorage.upsertDarkModePreference(
      latsTheme,
    );
    _darkModePreferenceSubject.add(latsTheme);
  }


  Stream<DarkModePreference> getDarkModePreference() async* {
    if (!_darkModePreferenceSubject.hasValue) {
      final storedPreference = await _localStorage.getDarkModePreference();
      _darkModePreferenceSubject.add(storedPreference);
    }

    yield* _darkModePreferenceSubject.stream;
  }
  Future<String> getWeather(){
    return WeatherApi().getWeather();
  }
}
