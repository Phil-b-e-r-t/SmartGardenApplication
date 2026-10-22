import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Widget _card(String title, String sub, IconData icon, List<Color> colors) {
    return Container(
      width: 112,
      height: 92,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const Spacer(),
          Text(title,
              style: AppText.body(12.5,
                  color: Colors.white, weight: FontWeight.w700)),
          Text(sub, style: AppText.body(10.5, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _tag(String t) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white30),
        ),
        child: Text(t, style: AppText.body(11.5, color: AppColors.mint)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Image.asset(AppAssets.farmBg, fit: BoxFit.cover),
        // Much lighter overlay than before — only darkens the bottom a little
        // so the buttons and text stay readable.
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.45, 1.0],
              colors: [
                Color(0x00000000),
                Color(0x1A0F2A1C),
                Color(0xB30F2A1C),
              ],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Icon(Icons.water_drop_outlined,
                        color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Philz Farm Tech',
                          style: AppText.body(14,
                              color: const Color.fromARGB(255, 101, 196, 64), weight: FontWeight.w700)),
                      Text('SMART IRRIGATION',
                          style: AppText.body(9.5, color: const Color.fromARGB(255, 29, 63, 9))),
                    ],
                  ),
                ]),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Grow Smarter.',
                    textAlign: TextAlign.center,
                    style: AppText.display(40, color: const Color.fromARGB(255, 99, 221, 43),)
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Farm Better',
                    textAlign: TextAlign.center,
                    style: AppText.display(24, color: const Color.fromARGB(255, 65, 228, 15)),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Sprinkler-based irrigation, herbicide & fertilizer application '
                  'Automated from your phone.',
                  style: AppText.body(13.5, color: const Color.fromARGB(255, 255, 255, 255)),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 92,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _card('Irrigation', 'Sprinkler system',
                          Icons.water_drop_outlined,
                          const [Color(0xFF2E7D5B), Color(0xFF1B4D37)]),
                      _card('Herbicide', 'Weed control', Icons.grass,
                          const [Color(0xFF8A6D3B), Color(0xFF4F3E1F)]),
                      _card('Fertilizer', 'Fertirrigation', Icons.eco_outlined,
                          const [Color(0xFF4C8C3F), Color(0xFF2B5324)]),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(spacing: 8, runSpacing: 8, children: [
                  _tag('Sprinkler delivery'),
                  _tag('Live soil monitoring'),
                  _tag('AI crop guidance'),
                  _tag('Schedule automation'),
                ]),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    child: Text('Log In',
                        style: AppText.body(16,
                            color: Colors.white, weight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white54),
                      backgroundColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SignupScreen()),
                    ),
                    child: Text('Create Account',
                        style: AppText.body(16,
                            color: Colors.white, weight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}