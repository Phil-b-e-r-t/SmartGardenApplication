import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// The ONLY place the company name appears after login.
class CompanyFooter extends StatelessWidget {
  const CompanyFooter({super.key});

  Widget _chip(String t) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white12),
        ),
        child: Text(t, style: AppText.body(10.5, color: AppColors.mint)),
      );

  Widget _contact(IconData i, String t) => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(children: [
          Icon(i, size: 15, color: AppColors.mint),
          const SizedBox(width: 10),
          Text(t, style: AppText.body(12, color: AppColors.mint)),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF12321F), Color(0xFF1E4A31)],
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.water_drop_outlined, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Philz Farm Tech', style: AppText.display(20)),
            Text('Precision Agriculture Solutions',
                style: AppText.body(11, color: AppColors.mint)),
          ]),
        ]),
        const SizedBox(height: 14),
        Text(
          'Empowering African farmers with smart sprinkler systems for water, '
          'herbicide & fertilizer delivery — reducing costs and maximising yield.',
          style: AppText.body(12.5, color: AppColors.mint),
        ),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: [
          _chip('Smart Irrigation'),
          _chip('Herbicide Delivery'),
          _chip('Fertirrigation'),
          _chip('Soil Monitoring'),
          _chip('AI-Powered'),
        ]),
        const SizedBox(height: 10),
        _contact(Icons.language, 'www.philzfarmtech.com'),
        _contact(Icons.mail_outline, 'hello@philzfarmtech.com'),
        _contact(Icons.phone_outlined, '+1 (800) PHILZ-FT'),
        const SizedBox(height: 14),
        Center(
          child: Text('© 2026 Philz Farm Tech. All rights reserved.',
              style: AppText.body(10, color: Colors.white38)),
        ),
      ]),
    );
  }
}