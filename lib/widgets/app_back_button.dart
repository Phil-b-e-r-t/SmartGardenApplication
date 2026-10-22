import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Back arrow shown at the top of every page.
/// Hides itself automatically when there is no previous page to go to
/// (unless a custom [onTap] is supplied).
class AppBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool onImage; // true when placed over a photo/dark header

  const AppBackButton({super.key, this.onTap, this.onImage = true});

  @override
  Widget build(BuildContext context) {
    if (onTap == null && !Navigator.of(context).canPop()) {
      return const SizedBox(height: 40);
    }
    return Material(
      color: onImage ? Colors.black38 : Colors.white,
      shape: const CircleBorder(),
      elevation: onImage ? 0 : 1,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap ?? () => Navigator.of(context).maybePop(),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: onImage ? Colors.white : AppColors.dark,
          ),
        ),
      ),
    );
  }
}