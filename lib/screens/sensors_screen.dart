import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_back_button.dart';
import '../widgets/company_footer.dart';

class SensorsScreen extends StatelessWidget {
  final VoidCallback onBack;
  const SensorsScreen({super.key, required this.onBack});

  Widget _reading(String label, String value, String unit, String note,
      IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label,
                style: AppText.body(11,
                    color: AppColors.primary, weight: FontWeight.w700)),
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(value,
                  style: AppText.body(28,
                      color: AppColors.dark, weight: FontWeight.w700)),
              Padding(
                padding: const EdgeInsets.only(bottom: 5, left: 3),
                child:
                    Text(unit, style: AppText.body(13, color: AppColors.muted)),
              ),
            ]),
            Text(note, style: AppText.body(11.5, color: AppColors.muted)),
          ]),
        ),
      ]),
    );
  }

  Widget _bar(String label, int pct, Color c) => Expanded(
        flex: pct,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(height: 6, color: c),
          const SizedBox(height: 4),
          Text('$label $pct%',
              style: AppText.body(10.5, color: AppColors.muted)),
        ]),
      );

  Widget _log(String title, String sub, IconData icon, Color c, String status,
      Color statusBg) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Icon(icon, color: c),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                style: AppText.body(13.5,
                    color: AppColors.dark, weight: FontWeight.w700)),
            Text(sub, style: AppText.body(11.5, color: AppColors.muted)),
          ]),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: statusBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(status,
              style: AppText.body(10.5,
                  color: AppColors.dark, weight: FontWeight.w600)),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    const weekly = [0.55, 0.8, 0.45, 0.95, 0.6, 0.75, 0.5];
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AppBackButton(onTap: onBack, onImage: false),
          const SizedBox(height: 14),
          Text('LIVE READINGS',
              style: AppText.body(11,
                  color: AppColors.primary, weight: FontWeight.w700)),
          Text('System Details',
              style: AppText.display(30, color: AppColors.dark)),
          Text('Updated 2 minutes ago · Sprinkler network online',
              style: AppText.body(12, color: AppColors.muted)),
          const SizedBox(height: 16),
          _reading('AIR TEMPERATURE', '24', '°C',
              'Within crop range (18–28°C)', Icons.thermostat,
              const Color(0xFFE05555)),
          _reading('HUMIDITY', '68', '%', 'Good — target 60–75%',
              Icons.water_drop_outlined, const Color(0xFF3B82F6)),
          _reading('SOIL MOISTURE', '42', '%',
              'Slightly dry — irrigation advised', Icons.opacity,
              AppColors.primary),

          // Soil composition
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('SOIL COMPOSITION',
                  style: AppText.body(11,
                      color: AppColors.primary, weight: FontWeight.w700)),
              const SizedBox(height: 12),
              Row(children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B6B4A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.landscape, color: Colors.white54),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Loamy Clay',
                        style: AppText.body(17,
                            color: AppColors.dark, weight: FontWeight.w700)),
                    Text('pH 6.8 · Slightly acidic',
                        style: AppText.body(12, color: AppColors.muted)),
                    Text('Excellent water & nutrient retention',
                        style: AppText.body(12, color: AppColors.primary)),
                  ]),
                ),
              ]),
              const SizedBox(height: 14),
              Row(children: [
                _bar('Clay', 35, const Color(0xFFE08A5A)),
                const SizedBox(width: 4),
                _bar('Silt', 40, const Color(0xFF6FBF9A)),
                const SizedBox(width: 4),
                _bar('Sand', 25, const Color(0xFFE8C95A)),
              ]),
            ]),
          ),

          // Spray log
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("TODAY'S SPRAY LOG",
                  style: AppText.body(11,
                      color: AppColors.primary, weight: FontWeight.w700)),
              _log('Irrigation · Zone A', '06:15 AM · 32 min via sprinkler',
                  Icons.water_drop_outlined, const Color(0xFF3B82F6), 'Done',
                  const Color(0xFFDCEBFF)),
              _log('Herbicide · Zone B', '09:40 AM · 14 min via sprinkler',
                  Icons.grass, const Color(0xFF4C8C3F), 'Done',
                  const Color(0xFFFFE8D2)),
              _log('Fertilizer · Zone C', '01:00 PM · 18 min via sprinkler',
                  Icons.eco_outlined, const Color(0xFFE0A030), 'Done',
                  const Color(0xFFDDF5E7)),
            ]),
          ),

          // Weekly output
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('WEEKLY SPRINKLER OUTPUT',
                  style: AppText.body(11,
                      color: AppColors.primary, weight: FontWeight.w700)),
              const SizedBox(height: 14),
              SizedBox(
                height: 90,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (int i = 0; i < weekly.length; i++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 64 * weekly[i],
                                decoration: BoxDecoration(
                                  color: i == weekly.length - 1
                                      ? const Color(0xFF2563EB)
                                      : const Color(0xFFCFEBDB),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(days[i],
                                  style: AppText.body(10.5,
                                      color: AppColors.muted)),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text('Total 1,240 L across all modes · 8% below avg',
                  style: AppText.body(11.5, color: AppColors.muted)),
            ]),
          ),

          const CompanyFooter(),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }
}