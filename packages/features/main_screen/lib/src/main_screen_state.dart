part of 'main_screen_bloc.dart';

abstract class MainScreenState extends Equatable {
  const MainScreenState();

  @override
  List<Object?> get props => [];
}

class MainScreenLoaded extends MainScreenState {
  const MainScreenLoaded({
    required this.number,
    this.theme = DarkModePreference.alwaysLight,
    this.weather = '',
  });

  final int number;
  final String weather;
  final DarkModePreference theme;

  MainScreenLoaded copyWith({
    required int number,
    required DarkModePreference theme,
    String weather = '',
  }) {
    return MainScreenLoaded(
      number: number,
      theme: theme,
      weather: weather,
    );
  }

  @override
  List<Object?> get props => [
        number,
        theme,
        weather,
      ];
}
