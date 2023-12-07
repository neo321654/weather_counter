import 'package:flutter/material.dart';
import 'package:main_screen/main_screen.dart';
import 'package:routemaster/routemaster.dart';
import 'package:user_repository/user_repository.dart';

Map<String, PageBuilder> buildRoutingTable({
  required UserRepository userRepository,
}) {
  return {
    _PathConstants.mainPath: (_) {
      return MaterialPage(
        name: 'main-screen',
        child: MainScreen(
          userRepository: userRepository,
        ),
      );
    },
  };
}

class _PathConstants {
  const _PathConstants._();

  static String get mainPath => '/';
}
