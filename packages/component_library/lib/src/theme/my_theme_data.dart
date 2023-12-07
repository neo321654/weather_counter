import 'package:component_library/component_library.dart';
import 'package:component_library/src/theme/spacing.dart';
import 'package:flutter/material.dart';


abstract class MyThemeData {
  ThemeData get materialThemeData;

  double screenMargin = Spacing.mediumLarge;

  double gridSpacing = Spacing.mediumLarge;

  Color get roundedChoiceChipBackgroundColor;

  Color get roundedChoiceChipSelectedBackgroundColor;

  Color get roundedChoiceChipLabelColor;

  Color get roundedChoiceChipSelectedLabelColor;

  Color get roundedChoiceChipAvatarColor;

  Color get roundedChoiceChipSelectedAvatarColor;

  Color get quoteSvgColor;

  Color get unvotedButtonColor;

  Color get votedButtonColor;

  TextStyle quoteTextStyle = const TextStyle(
    fontFamily: 'Fondamento',
    package: 'component_library',
  );
}

class LightThemeData extends MyThemeData {
  @override
  ThemeData get materialThemeData => ThemeData(
        brightness: Brightness.light,
      );

  @override
  Color get roundedChoiceChipBackgroundColor => Colors.white;

  @override
  Color get roundedChoiceChipLabelColor => Colors.black;

  @override
  Color get roundedChoiceChipSelectedBackgroundColor => Colors.black;

  @override
  Color get roundedChoiceChipSelectedLabelColor => Colors.white;

  @override
  Color get quoteSvgColor => Colors.black;

  @override
  Color get roundedChoiceChipAvatarColor => Colors.black;

  @override
  Color get roundedChoiceChipSelectedAvatarColor => Colors.white;

  @override
  Color get unvotedButtonColor => Colors.black54;

  @override
  Color get votedButtonColor => Colors.black;
}

class DarkThemeData extends MyThemeData {
  @override
  ThemeData get materialThemeData => ThemeData(
        brightness: Brightness.dark,
      );

  @override
  Color get roundedChoiceChipBackgroundColor => Colors.black;

  @override
  Color get roundedChoiceChipLabelColor => Colors.white;

  @override
  Color get roundedChoiceChipSelectedBackgroundColor => Colors.white;

  @override
  Color get roundedChoiceChipSelectedLabelColor => Colors.black;

  @override
  Color get quoteSvgColor => Colors.white;

  @override
  Color get roundedChoiceChipAvatarColor => Colors.white;

  @override
  Color get roundedChoiceChipSelectedAvatarColor => Colors.black;

  @override
  Color get unvotedButtonColor => Colors.white54;

  @override
  Color get votedButtonColor => Colors.white;
}


