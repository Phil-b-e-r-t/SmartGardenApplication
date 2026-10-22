import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'ai_guide_screen.dart';
import 'home_screen.dart';
import 'sensors_screen.dart';
import 'welcome_screen.dart';

/// Holds the three main tabs shown after login: Home, Sensors, AI Guide.
class MainShell extends StatefulWidget {
  final String farmerName;
  const MainShell({super.key, this.farmerName = 'Jane'});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  Future<void> _confirmLogout() async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text('You will return to the welcome page.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Stay')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Log out')),
        ],
      ),
    );
    if (leave == true && mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
        (route) => false,
      );
    }
  }

  /// Back arrow / system back: other tabs go to Home, Home asks to log out.
  void _goBack() {
    if (_index != 0) {
      setState(() => _index = 0);
    } else {
      _confirmLogout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goBack();
      },
      child: Scaffold(
        backgroundColor: AppColors.bg,
        body: IndexedStack(index: _index, children: [
          HomeScreen(
            farmerName: widget.farmerName,
            onBack: _goBack,
            onOpenAi: () => setState(() => _index = 2),
            onOpenSensors: () => setState(() => _index = 1),
          ),
          SensorsScreen(onBack: _goBack),
          AiGuideScreen(onBack: _goBack),
        ]),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: SafeArea(
            child: Row(children: [
              _navItem(0, Icons.home_outlined, Icons.home, 'Home'),
              _navItem(1, Icons.sensors_outlined, Icons.sensors, 'Sensors'),
              _navItem(2, Icons.chat_bubble_outline, Icons.chat_bubble,
                  'AI Guide'),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _navItem(int i, IconData off, IconData on, String label) {
    final sel = _index == i;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _index = i),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(sel ? on : off,
                color: sel ? AppColors.primary : AppColors.muted),
            const SizedBox(height: 3),
            Text(label,
                style: AppText.body(11,
                    color: sel ? AppColors.primary : AppColors.muted,
                    weight: sel ? FontWeight.w700 : FontWeight.w500)),
          ]),
        ),
      ),
    );
  }
}