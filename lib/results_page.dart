import 'package:flutter/material.dart';
import 'constants.dart';

class ResultsPage extends StatelessWidget {
  final String bmiResult;
  final String resultText;
  final String interpretation;

  const ResultsPage({
    super.key,
    required this.bmiResult,
    required this.resultText,
    required this.interpretation,
  });

  Color _resultColor() {
    switch (resultText) {
      case 'NORMAL':
        return kGreenColor;
      case 'OVERWEIGHT':
        return kRedColor;
      default:
        return kGreenAccentColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PAMITS BMI APP'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kScreenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text('Your Result', style: kTitleTextStyle),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(kCardRadius),
                    border: Border.all(color: kGreenLightColor, width: 2.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: _resultColor().withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          resultText,
                          style: kResultTextStyle.copyWith(
                            color: _resultColor(),
                          ),
                        ),
                      ),
                      Text(bmiResult, style: kBMITextStyle),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: kGreenAccentColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          interpretation,
                          textAlign: TextAlign.center,
                          style: kBodyTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  height: kBottomBarHeight,
                  decoration: BoxDecoration(
                    color: kBottomBarColor,
                    borderRadius: BorderRadius.circular(kCardRadius),
                    boxShadow: [
                      BoxShadow(
                        color: kRedDarkColor.withValues(alpha: 0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text('RE-CALCULATE', style: kButtonTextStyle),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
