
import 'package:clothing_store/utils/colors.dart';
import 'package:clothing_store/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../onboarding/onboarding_screen.dart';
import '../tabbox/tabbox.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _checkOnboardingStatus(context);

    return Scaffold(
      backgroundColor: AppColors.baseDark,
      body: Center(
        child: Lottie.asset(AppImages.welcome),
      ),
    );
  }

  void _checkOnboardingStatus(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    await Future.delayed(const Duration(seconds: 2));

    if (hasSeenOnboarding) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const TabBox()));
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            prefs.setBool('hasSeenOnboarding', true);
            return const OnBoardingScreen();
          },
        ),
      );
    }
  }
}
