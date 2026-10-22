import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..forward();
    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        // Background picture
        Image.asset(AppAssets.farmBg, fit: BoxFit.cover),
        // Overlay keeps the text readable
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0x66102A1C), Color(0xB3102A1C)],
            ),
          ),
        ),
        SafeArea(
          child: Column(children: [
            const Spacer(flex: 3),
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(Icons.water_drop_outlined,
                  color: Colors.white, size: 38),
            ),
            const SizedBox(height: 22),
            Text('Philz Farm Tech',
                textAlign: TextAlign.center, style: AppText.display(38)),
            const SizedBox(height: 10),
            Text('SMART IRRIGATION SYSTEM',
                style: AppText.body(12,
                    color: AppColors.mint, weight: FontWeight.w700)),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Precision sprinkler control for irrigation, herbicide & '
                'fertilizer — all in one platform.',
                textAlign: TextAlign.center,
                style: AppText.body(13.5, color: Colors.white),
              ),
            ),
            const SizedBox(height: 26),
            SizedBox(
              width: 140,
              child: AnimatedBuilder(
                animation: _c,
                builder: (_, __) => ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _c.value,
                    minHeight: 4,
                    backgroundColor: Colors.white24,
                    valueColor:
                        const AlwaysStoppedAnimation(AppColors.mint),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 4),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                '© 2026 Philz Farm Tech · Precision Agriculture Solutions',
                style: AppText.body(11, color: Colors.white70),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}