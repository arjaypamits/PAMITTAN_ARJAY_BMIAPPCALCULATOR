import 'package:flutter/material.dart';
import 'constants.dart';
import 'input_page.dart';

void main() => runApp(const PamitsBMIApp());

class PamitsBMIApp extends StatelessWidget {
  const PamitsBMIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PAMITS BMI APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: kRedColor,
          foregroundColor: kWhiteColor,
          titleTextStyle: kAppBarTitleStyle,
          centerTitle: true,
          elevation: 0,
        ),
        sliderTheme: SliderThemeData(
          thumbColor: kSliderActiveColor,
          activeTrackColor: kSliderActiveColor,
          inactiveTrackColor: kSliderInactiveColor,
          overlayColor: kSliderActiveColor.withValues(alpha: 0.2),
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 22.0),
        ),
      ),
      home: const InputPage(),
    );
  }
}
