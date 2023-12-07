import 'package:component_library/src/theme/my_theme_data.dart';
import 'package:flutter/material.dart';

class MyTheme extends InheritedWidget {
  const MyTheme({
    required Widget child,
    required this.lightTheme,
    required this.darkTheme,
    Key? key,
  }) : super(
          key: key,
          child: child,
        );

  final MyThemeData lightTheme;
  final MyThemeData darkTheme;

  @override
  bool updateShouldNotify(
    MyTheme oldWidget,
  ) =>
      oldWidget.lightTheme != lightTheme || oldWidget.darkTheme != darkTheme;

  static MyThemeData of(BuildContext context) {
    final MyTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<MyTheme>();
    assert(inheritedTheme != null, 'No MyTheme found in context');
    final currentBrightness = Theme.of(context).brightness;
    return currentBrightness == Brightness.dark
        ? inheritedTheme!.darkTheme
        : inheritedTheme!.lightTheme;
  }
}
