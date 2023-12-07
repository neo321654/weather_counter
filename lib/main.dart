import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:main_screen/l10n/main_screen_localizations.dart';
import 'package:routemaster/routemaster.dart';
import 'package:user_repository/user_repository.dart';
import 'package:weather_api/weather_api.dart';
import '/routing_table.dart';

void main() {
  runApp(
    const WeatherCounter(),
  );
}


class WeatherCounter extends StatefulWidget {
  const WeatherCounter({
    Key? key,
  }) : super(key: key);

  @override
  WeatherCounterState createState() => WeatherCounterState();
}

class WeatherCounterState extends State<WeatherCounter> {
  final _keyValueStorage = KeyValueStorage();

  late final WeatherApi _weatherApi = WeatherApi();

  late final _userRepository = UserRepository(
    noSqlStorage: _keyValueStorage,
    weatherApi: _weatherApi,
  );

  late final RoutemasterDelegate _routerDelegate = RoutemasterDelegate(
    routesBuilder: (context) {
      return RouteMap(
        routes: buildRoutingTable(
          userRepository: _userRepository,
        ),
      );
    },
  );

  final _lightTheme = LightThemeData();
  final _darkTheme = DarkThemeData();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DarkModePreference>(
      stream: _userRepository.getDarkModePreference(),
      builder: (context, snapshot) {
        final darkModePreference = snapshot.data;

        return MyTheme(
          lightTheme: _lightTheme,
          darkTheme: _darkTheme,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: _lightTheme.materialThemeData,
            darkTheme: _darkTheme.materialThemeData,
            themeMode: darkModePreference?.toThemeMode(),
            supportedLocales: const [
              Locale('en', ''),
            ],
            localizationsDelegates: const [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              MainScreenLocalizations.delegate,
            ],
            routerDelegate: _routerDelegate,
            routeInformationParser: const RoutemasterParser(),
          ),
        );
      },
    );
  }
}

extension on DarkModePreference {
  ThemeMode toThemeMode() {
    switch (this) {
      case DarkModePreference.useSystemSettings:
        return ThemeMode.system;
      case DarkModePreference.alwaysLight:
        return ThemeMode.light;
      case DarkModePreference.alwaysDark:
        return ThemeMode.dark;
    }
  }
}
