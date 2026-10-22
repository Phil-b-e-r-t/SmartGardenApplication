import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/auth_header.dart';
import 'main_shell.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  String get _pw => _password.text;
  bool get _hasLen => _pw.length >= 8;
  bool get _hasUpper => RegExp(r'[A-Z]').hasMatch(_pw);
  bool get _hasNum => RegExp(r'[0-9]').hasMatch(_pw);
  bool get _hasSpecial => RegExp(r'[^A-Za-z0-9]').hasMatch(_pw);
  bool get _valid =>
      _name.text.trim().isNotEmpty &&
      _email.text.contains('@') &&
      _hasLen &&
      _hasUpper &&
      _hasNum &&
      _hasSpecial;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  InputDecoration _dec(String hint, {Widget? suffix}) => InputDecoration(
        hintText: hint,
        hintStyle: AppText.body(14, color: AppColors.muted),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: suffix,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      );

  Widget _label(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(t,
            style: AppText.body(11.5,
                color: AppColors.dark, weight: FontWeight.w700)),
      );

  Widget _req(String t, bool ok) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(children: [
          Icon(ok ? Icons.check_circle : Icons.circle_outlined,
              size: 16, color: ok ? AppColors.primary : AppColors.border),
          const SizedBox(width: 10),
          Text(t,
              style: AppText.body(12,
                  color: ok ? AppColors.dark : AppColors.muted)),
        ]),
      );

  void _create() {
    // TODO: replace with your real sign-up call.
    final first = _name.text.trim().split(' ').first;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => MainShell(farmerName: first)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(children: [
        const AuthHeader(
            title: 'Join the platform', subtitle: 'Create your farmer account'),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _label('FULL NAME'),
              TextField(
                controller: _name,
                textCapitalization: TextCapitalization.words,
                onChanged: (_) => setState(() {}),
                decoration: _dec('Jane Farmer'),
              ),
              const SizedBox(height: 16),
              _label('EMAIL ADDRESS'),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                onChanged: (_) => setState(() {}),
                decoration: _dec('farmer@philzfarmtech.com'),
              ),
              const SizedBox(height: 16),
              _label('PASSWORD'),
              TextField(
                controller: _password,
                obscureText: _obscure,
                onChanged: (_) => setState(() {}),
                decoration: _dec(
                  '••••••••',
                  suffix: IconButton(
                    icon: Icon(
                      _obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.primary,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Password requirements',
                      style: AppText.body(12,
                          color: AppColors.primary, weight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  _req('At least 8 characters', _hasLen),
                  _req('One uppercase letter (A–Z)', _hasUpper),
                  _req('One number (0–9)', _hasNum),
                  _req(r'One special character (!@#$...)', _hasSpecial),
                ]),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: const Color(0xFFD3E0D9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: _valid ? _create : null,
                  child: Text('Create Account',
                      style: AppText.body(16,
                          color: Colors.white, weight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 10),
            ]),
          ),
        ),
      ]),
    );
  }
}