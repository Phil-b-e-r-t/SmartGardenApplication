import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_back_button.dart';
import '../widgets/company_footer.dart';

class AiGuideScreen extends StatefulWidget {
  final VoidCallback onBack;
  const AiGuideScreen({super.key, required this.onBack});

  @override
  State<AiGuideScreen> createState() => _AiGuideScreenState();
}

class _AiGuideScreenState extends State<AiGuideScreen> {
  final _controller = TextEditingController();
  final List<({String text, bool fromUser})> _messages = [
    (
      text: 'Hello! Ask me about herbicide rates, fertilizer schedules, '
          'irrigation timing or soil health.',
      fromUser: false
    ),
  ];

  static const _topics = [
    'Herbicide rates',
    'Fertilizer schedule',
    'Irrigation timing',
    'Soil health tips',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send(String text) {
    final t = text.trim();
    if (t.isEmpty) return;
    setState(() {
      _messages.add((text: t, fromUser: true));
      // TODO: call your AI backend here and add the real reply.
      _messages.add((
        text: 'Thanks! AI research for "$t" will appear here once your AI '
            'service is connected.',
        fromUser: false
      ));
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AppBackButton(onTap: widget.onBack, onImage: false),
            const SizedBox(height: 14),
            Text('AI Guide', style: AppText.display(30, color: AppColors.dark)),
            Text('Herbicide rates, crop schedules, soil tips',
                style: AppText.body(12, color: AppColors.muted)),
            const SizedBox(height: 12),
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _topics.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) => ActionChip(
                  label: Text(_topics[i],
                      style: AppText.body(12, color: AppColors.primary)),
                  backgroundColor: const Color.from(alpha: 1, red: 0.235, green: 0.494, blue: 0.259),
                  side: const BorderSide(color: AppColors.border),
                  onPressed: () => _send(_topics[i]),
                ),
              ),
            ),
          ]),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (final m in _messages)
                Align(
                  alignment:
                      m.fromUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.78),
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: m.fromUser ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(m.text,
                        style: AppText.body(13.5,
                            color: m.fromUser
                                ? const Color.fromARGB(255, 168, 241, 190)
                                : AppColors.dark)),
                  ),
                ),
              const SizedBox(height: 8),
              const CompanyFooter(),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 10),
          color: Colors.white,
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: _controller,
                onSubmitted: _send,
                decoration: InputDecoration(
                  hintText: 'Ask about your crops…',
                  hintStyle: AppText.body(14, color: AppColors.muted),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send_rounded, color: AppColors.primary),
              onPressed: () => _send(_controller.text),
            ),
          ]),
        ),
      ]),
    );
  }
}