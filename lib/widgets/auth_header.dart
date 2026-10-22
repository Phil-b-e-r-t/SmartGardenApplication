import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'app_back_button.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: double.infinity,
      child: Stack(fit: StackFit.expand, children: [
        Image.asset(AppAssets.farmBg, fit: BoxFit.cover),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0x33000000), Color(0xB30F2A1C)],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBackButton(),
                const Spacer(),
                Text('Philz Farm Tech',
                    style: AppText.body(12,
                        color: AppColors.mint, weight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(title, style: AppText.display(30)),
                const SizedBox(height: 4),
                Text(subtitle, style: AppText.body(13, color: AppColors.mint)),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}