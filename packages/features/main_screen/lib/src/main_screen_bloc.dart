import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'main_screen_event.dart';

part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final UserRepository userRepository;
  DarkModePreference theme;

  MainScreenBloc({
    required this.userRepository,
    required this.theme,
  }) : super(
          MainScreenLoaded(number: 0, theme: theme),
        ) {
    on<MainScreenDarkModePreferenceChanged>((event, emit) async {
      await userRepository.toggleDarkModePreference();
      final currentState = state as MainScreenLoaded;
      final newState = currentState.copyWith(
        number: currentState.number,
        theme: theme,
        weather: currentState.weather,
      );
      emit(newState);
    });
    //todo убрать повторяющийся код

    on<MainScreenIncrement>((event, emit) async {
      final currentState = state as MainScreenLoaded;
      int incrementer = (event.theme == DarkModePreference.alwaysDark) ? 2 : 1;
      int newCount = currentState.number + incrementer;
      newCount = limitCount(newCount);
      final newState = currentState.copyWith(
          number: newCount,
          theme: currentState.theme,
          weather: currentState.weather);
      emit(newState);
    });

    on<MainScreenDecrement>((event, emit) async {
      final currentState = state as MainScreenLoaded;
      int incrementer = (event.theme == DarkModePreference.alwaysDark) ? 2 : 1;
      int newCount = currentState.number - incrementer;
      newCount = limitCount(newCount);
      final newState = currentState.copyWith(
          number: newCount,
          theme: currentState.theme,
          weather: currentState.weather);
      emit(newState);
    });

    on<MainScreenGetWeather>((event, emit) async {
      final currentState = state as MainScreenLoaded;
      String weather = await userRepository.getWeather();
      final newState = currentState.copyWith(
        theme: currentState.theme,
        number: currentState.number,
        weather: weather,
      );
      emit(newState);
    });
  }

  //todo убрать отсюда
  int limitCount(int newCount) {
    if (newCount > 10) {
      newCount = 10;
    }
    if (newCount < 0) {
      newCount = 0;
    }
    return newCount;
  }
}
