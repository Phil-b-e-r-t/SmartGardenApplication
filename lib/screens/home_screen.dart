import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_back_button.dart';
import '../widgets/company_footer.dart';

class HomeScreen extends StatefulWidget {
  final String farmerName;
  final VoidCallback onBack;
  final VoidCallback onOpenAi;
  final VoidCallback onOpenSensors;

  const HomeScreen({
    super.key,
    required this.farmerName,
    required this.onBack,
    required this.onOpenAi,
    required this.onOpenSensors,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _running = false;
  int _mode = 0;

  static const _modes = [
    (
      'Irrigation',
      'Pure water — drip & sprinkler',
      Icons.water_drop_outlined,
      Color(0xFF3B82F6),
    ),
    (
      'Herbicide',
      'Weed control via sprinkler nozzles',
      Icons.grass,
      Color(0xFF4C8C3F),
    ),
    (
      'Fertilizer',
      'Nutrient delivery — fertirrigation',
      Icons.eco_outlined,
      Color(0xFFE0A030),
    ),
  ];

  Widget _statCard(
    String label,
    String value,
    String unit,
    String note,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppText.body(
                      10.5,
                      color: AppColors.primary,
                      weight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        value,
                        style: AppText.body(
                          24,
                          color: AppColors.dark,
                          weight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4, left: 2),
                        child: Text(
                          unit,
                          style: AppText.body(12, color: AppColors.muted),
                        ),
                      ),
                    ],
                  ),
                  Text(note, style: AppText.body(10.5, color: AppColors.muted)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _zoneCard(String title, String zone, List<Color> colors) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppText.body(
              13,
              color: Colors.white,
              weight: FontWeight.w700,
            ),
          ),
          Text(zone, style: AppText.body(10.5, color: Colors.white70)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ── Header (farm name only — no company name here) ──
          Container(
            width: double.infinity,
            height: 210,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.farmBg),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x330F2A1C), Color(0xCC0F2A1C)],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppBackButton(onTap: widget.onBack),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: _running
                                      ? AppColors.mint
                                      : Colors.white54,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _running ? 'Running' : 'Standby',
                                  style: AppText.body(
                                    11.5,
                                    color: Colors.white,
                                    weight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        "${widget.farmerName}'s Farm — Zone A",
                        style: AppText.display(26),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Last cycle: Today, 6:15 AM · Sprinkler method',
                        style: AppText.body(12, color: AppColors.mint),
                      ),
                      Text(
                        'Soil moisture: 42% · Temperature: 24°C',
                        style: AppText.body(
                          12,
                          color: AppColors.mint,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Sprinkler system toggle ──
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SPRINKLER SYSTEM',
                              style: AppText.body(
                                10.5,
                                color: AppColors.primary,
                                weight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _running ? 'System running' : 'System ready',
                              style: AppText.body(
                                20,
                                color: AppColors.dark,
                                weight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _modes[_mode].$2,
                              style: AppText.body(12, color: AppColors.muted),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _running,
                        activeColor: AppColors.primary,
                        onChanged: (v) => setState(() => _running = v),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // ── Delivery mode ──
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'SPRINKLER DELIVERY MODE',
                            style: AppText.body(
                              10.5,
                              color: AppColors.muted,
                              weight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDDF5E7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Recommended',
                              style: AppText.body(10, color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      for (int i = 0; i < _modes.length; i++)
                        GestureDetector(
                          onTap: () => setState(() => _mode = i),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _mode == i
                                  ? const Color(0xFFE8F1FF)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: _mode == i
                                    ? _modes[i].$4
                                    : AppColors.border,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(_modes[i].$3, color: _modes[i].$4),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _modes[i].$1,
                                        style: AppText.body(
                                          14,
                                          color: AppColors.dark,
                                          weight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        _modes[i].$2,
                                        style: AppText.body(
                                          11.5,
                                          color: AppColors.muted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  _mode == i
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off,
                                  color: _mode == i
                                      ? _modes[i].$4
                                      : AppColors.border,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // ── Temperature & humidity ──
                Row(
                  children: [
                    _statCard(
                      'TEMPERATURE',
                      '24',
                      '°C',
                      'Optimal range',
                      Icons.thermostat,
                      const Color(0xFFE05555),
                    ),
                    const SizedBox(width: 12),
                    _statCard(
                      'HUMIDITY',
                      '68',
                      '%',
                      'Good for crops',
                      Icons.water_drop_outlined,
                      const Color(0xFF3B82F6),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // ── Field conditions ──
                Row(
                  children: [
                    Text(
                      'Field Conditions',
                      style: AppText.body(
                        15,
                        color: AppColors.dark,
                        weight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: widget.onOpenSensors,
                      child: Text(
                        'View sensors →',
                        style: AppText.body(
                          12.5,
                          color: AppColors.primary,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 96,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _zoneCard('Sprinkler Active', 'Zone A — Water', const [
                        Color(0xFF2E7D5B),
                        Color(0xFF1B4D37),
                      ]),
                      _zoneCard('Herbicide Run', 'Zone B — Scheduled', const [
                        Color(0xFF8A6D3B),
                        Color(0xFF4F3E1F),
                      ]),
                      _zoneCard('Fertilizer Zone', 'Zone C — Done', const [
                        Color(0xFF4C8C3F),
                        Color(0xFF2B5324),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ── AI research card ──
                GestureDetector(
                  onTap: widget.onOpenAi,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.dark,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.chat_bubble_outline,
                            color: AppColors.mint,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AI Farming Research',
                                style: AppText.body(
                                  14,
                                  color: Colors.white,
                                  weight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Herbicide rates, crop schedules, soil tips',
                                style: AppText.body(
                                  11.5,
                                  color: AppColors.mint,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward, color: AppColors.mint),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ── Company name lives ONLY here ──
                const CompanyFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
