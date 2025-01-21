import 'package:flutter/material.dart';
import 'package:flutter_datingapp_restapi/core/constants/colors.dart';
import 'package:flutter_datingapp_restapi/core/constants/text_styles.dart';
import 'package:flutter_datingapp_restapi/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 8));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
        // Make sure to maintain the Bloc context
        maintainState: true,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/dating_list.png',
              height: 280,
              width: 280,
            ),
            const SizedBox(height: 20),
            Text(
              'Dating List RestApis',
              style: AppTextStyles.headline1.copyWith(
                color: AppColors.primary,
                fontSize: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}