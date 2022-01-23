import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor primary = const MaterialColor(
    0xff133eea, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff1138d3), //10%
      100: const Color(0xff0f32bb), //20%
      200: const Color(0xff0d2ba4), //30%
      300: const Color(0xff0b258c), //40%
      400: const Color(0xff0a1f75), //50%
      500: const Color(0xff08195e), //60%
      600: const Color(0xff061346), //70%
      700: const Color(0xff040c2f), //80%
      800: const Color(0xff020617), //90%
      900: const Color(0xff000000), //100%
    },
  );
  static const MaterialColor secondary = const MaterialColor(
    0xffffe5d9, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffe6cec3), //10%
      100: const Color(0xffccb7ae), //20%
      200: const Color(0xffb3a098), //30%
      300: const Color(0xff998982), //40%
      400: const Color(0xff80736d), //50%
      500: const Color(0xff665c57), //60%
      600: const Color(0xff4c4541), //70%
      700: const Color(0xff332e2b), //80%
      800: const Color(0xff191716), //90%
      900: const Color(0xff000000), //100%
    },
  );
  static const MaterialColor tertiary = const MaterialColor(
    0xfff3f5f9, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffdbdde0), //10%
      100: const Color(0xffc2c4c7), //20%
      200: const Color(0xffaaacae), //30%
      300: const Color(0xff929395), //40%
      400: const Color(0xff7a7b7d), //50%
      500: const Color(0xff616264), //60%
      600: const Color(0xff49494b), //70%
      700: const Color(0xff313132), //80%
      800: const Color(0xff181819), //90%
      900: const Color(0xff000000), //100%
    },
  );
}
