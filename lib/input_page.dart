import 'package:flutter/material.dart';
import 'constants.dart';
import 'calculator_brain.dart';
import 'results_page.dart';

class ReusableCard extends StatelessWidget {
  final Color colour;
  final Widget? cardChild;
  final VoidCallback? onPress;

  const ReusableCard({
    super.key,
    required this.colour,
    this.cardChild,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.all(kCardMargin),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(kCardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: cardChild,
      ),
    );
  }
}

class GenderCard extends StatelessWidget {
  final IconData genderIcon;
  final String genderLabel;
  final bool isSelected;

  const GenderCard({
    super.key,
    required this.genderIcon,
    required this.genderLabel,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          genderIcon,
          size: 56.0,
          color: isSelected ? kWhiteColor : kRedColor,
        ),
        const SizedBox(height: 8.0),
        Text(
          genderLabel,
          style: kLabelTextStyle.copyWith(
            color: isSelected ? kWhiteColor : const Color(0xFF757575),
          ),
        ),
      ],
    );
  }
}

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      fillColor: kRedColor,
      constraints: const BoxConstraints.tightFor(width: 44.0, height: 44.0),
      child: Icon(icon, color: kWhiteColor, size: 20.0),
    );
  }
}

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  int selectedGender = 0;
  int height = 170;
  int weight = 60;
  int age = 25;

  Color getGenderCardColor(int gender) {
    return selectedGender == gender ? kActiveCardColor : kInactiveCardColor;
  }

  void _onCalculate() {
    if (selectedGender == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select your gender'),
          backgroundColor: kGreenColor,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(kScreenPadding),
        ),
      );
      return;
    }

    final calc = CalculatorBrain(height: height, weight: weight);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsPage(
          bmiResult: calc.calculateBMI(),
          resultText: calc.getResult(),
          interpretation: calc.getInterpretation(),
        ),
      ),
    );
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
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: ReusableCard(
                        colour: getGenderCardColor(1),
                        onPress: () => setState(() => selectedGender = 1),
                        cardChild: GenderCard(
                          genderIcon: Icons.male,
                          genderLabel: 'MALE',
                          isSelected: selectedGender == 1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        colour: getGenderCardColor(2),
                        onPress: () => setState(() => selectedGender = 2),
                        cardChild: GenderCard(
                          genderIcon: Icons.female,
                          genderLabel: 'FEMALE',
                          isSelected: selectedGender == 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: ReusableCard(
                  colour: kCardColor,
                  cardChild: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('HEIGHT', style: kLabelTextStyle),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(height.toString(), style: kNumberTextStyle),
                            const Text(' cm', style: kLabelTextStyle),
                          ],
                        ),
                        Slider(
                          value: height.toDouble(),
                          min: 120.0,
                          max: 220.0,
                          onChanged: (double newValue) {
                            setState(() => height = newValue.round());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: ReusableCard(
                        colour: kCardColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('WEIGHT', style: kLabelTextStyle),
                            Text('$weight kg', style: kNumberTextStyle),
                            const SizedBox(height: 4.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIconButton(
                                  icon: Icons.remove,
                                  onPressed: () {
                                    if (weight > 1) {
                                      setState(() => weight--);
                                    }
                                  },
                                ),
                                const SizedBox(width: 8.0),
                                RoundIconButton(
                                  icon: Icons.add,
                                  onPressed: () {
                                    if (weight < 300) {
                                      setState(() => weight++);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        colour: kCardColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('AGE', style: kLabelTextStyle),
                            Text('$age yrs', style: kNumberTextStyle),
                            const SizedBox(height: 4.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIconButton(
                                  icon: Icons.remove,
                                  onPressed: () {
                                    if (age > 1) {
                                      setState(() => age--);
                                    }
                                  },
                                ),
                                const SizedBox(width: 8.0),
                                RoundIconButton(
                                  icon: Icons.add,
                                  onPressed: () {
                                    if (age < 120) {
                                      setState(() => age++);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _onCalculate,
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
                    child: Text('CALCULATE', style: kButtonTextStyle),
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
