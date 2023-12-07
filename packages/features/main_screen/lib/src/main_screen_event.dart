part of 'main_screen_bloc.dart';

abstract class MainScreenEvent extends Equatable {
  const MainScreenEvent();

  @override
  List<Object?> get props => [];
}

class MainScreenDarkModePreferenceChanged extends MainScreenEvent {
  MainScreenDarkModePreferenceChanged(this.theme);

  final DarkModePreference theme;

  @override
  List<Object?> get props => [
        theme,
      ];
}

class MainScreenIncrement extends MainScreenEvent {
  const MainScreenIncrement(this.theme);
  final DarkModePreference theme;

  @override
  List<Object?> get props => [
    theme,
  ];
}

class MainScreenDecrement extends MainScreenEvent {
  const MainScreenDecrement(this.theme);
  final DarkModePreference theme;

  @override
  List<Object?> get props => [
    theme,
  ];
}

class MainScreenGetWeather extends MainScreenEvent {
  const MainScreenGetWeather();
}
