import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_screen/src/main_screen_bloc.dart';
import 'package:user_repository/user_repository.dart';
import '../l10n/main_screen_localizations.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    required this.userRepository,
    Key? key,
  }) : super(key: key);

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    final DarkModePreference themeToEvent =
        (Theme.of(context).brightness == Brightness.light)
            ? DarkModePreference.alwaysLight
            : DarkModePreference.alwaysDark;

    return BlocProvider<MainScreenBloc>(
      create: (_) => MainScreenBloc(
        userRepository: userRepository,
        theme: themeToEvent,
      ),
      child: MainScreenView(),
    );
  }
}

class MainScreenView extends StatelessWidget {
  const MainScreenView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MainScreenBloc>();
    final l10n = MainScreenLocalizations.of(context);
    final DarkModePreference themeToEvent =
        (Theme.of(context).brightness == Brightness.light)
            ? DarkModePreference.alwaysLight
            : DarkModePreference.alwaysDark;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(l10n.title),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: SizedBox.expand(),
            ),
            Expanded(
              child: Column(
                children: [
                  BlocBuilder<MainScreenBloc, MainScreenState>(
                    buildWhen: (previousState, state) {
                      state = state as MainScreenLoaded;
                      previousState = previousState as MainScreenLoaded;
                      return (previousState.weather != state.weather);
                    },
                    builder: (context, state) {
                      state = state as MainScreenLoaded;

                      return Column(
                        children: [
                          Text((state.weather == '')
                              ? l10n.description_location
                              : l10n.temperature),
                          Text(
                            state.weather.toString() ?? '',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(l10n.description_count),
                  const SizedBox(
                    height: 2,
                  ),
                  BlocBuilder<MainScreenBloc, MainScreenState>(
                    buildWhen: (previousState, state) {
                      state = state as MainScreenLoaded;
                      previousState = previousState as MainScreenLoaded;
                      return (previousState.number != state.number);
                    },
                    builder: (context, state) {
                      state = state as MainScreenLoaded;
                      return Text(
                        //todo походу везде шрифт не тот
                        state.number.toString(),
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                      onPressed: () {
                        bloc.add(
                          const MainScreenGetWeather(),
                        );
                      },
                      child: const Icon(Icons.cloud)),
                  MyButton(
                    bloc: bloc,
                    onPressed: () {
                      bloc.add(
                        MainScreenIncrement(themeToEvent),
                      );
                    },
                    child: const Icon(Icons.add),
                    isIncrementer: true,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                      onPressed: () {
                        bloc.add(
                          MainScreenDarkModePreferenceChanged(themeToEvent),
                        );
                      },
                      child: const Icon(Icons.color_lens)),
                  MyButton(
                    bloc: bloc,
                    onPressed: () {
                      bloc.add(
                        MainScreenDecrement(themeToEvent),
                      );
                    },
                    child: const Icon(Icons.remove),
                    isIncrementer: false,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
