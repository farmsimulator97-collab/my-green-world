import 'package:flutter/material.dart';
import '../widgets/feature_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final pages = const [
    _HomeContent(),
    _PlaceholderPage(
      icon: Icons.menu_book_rounded,
      title: 'موسوعة النباتات',
      subtitle: 'ابحث عن النباتات وتعرّف على خصائصها وطرق العناية بها.',
    ),
    _PlaceholderPage(
      icon: Icons.yard_rounded,
      title: 'حديقتي',
      subtitle: 'ستظهر هنا النباتات التي تضيفها إلى حديقتك الخاصة.',
    ),
    _PlaceholderPage(
      icon: Icons.settings_rounded,
      title: 'الإعدادات',
      subtitle: 'إعدادات اللغة والنسخ الاحتياطي والتطبيق.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('عالمي الأخضر', style: TextStyle(fontWeight: FontWeight.w800)),
            Text('اكتشف نباتاتك واعتنِ بها', style: TextStyle(fontSize: 11, color: Colors.black54)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'الإشعارات',
            onPressed: () => _message('ستُضاف التنبيهات في مرحلة العناية.'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) => setState(() => selectedIndex = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
          NavigationDestination(icon: Icon(Icons.local_florist_outlined), selectedIcon: Icon(Icons.local_florist), label: 'الموسوعة'),
          NavigationDestination(icon: Icon(Icons.yard_outlined), selectedIcon: Icon(Icons.yard), label: 'حديقتي'),
          NavigationDestination(icon: Icon(Icons.tune_rounded), selectedIcon: Icon(Icons.tune), label: 'الإعدادات'),
        ],
      ),
    );
  }

  void _message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: const LinearGradient(
              colors: [Color(0xFF174B38), Color(0xFF2F8B57)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.eco_rounded, color: Colors.white, size: 34),
              SizedBox(height: 14),
              Text('كل نبتة لها حكاية', style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold)),
              SizedBox(height: 7),
              Text('اكتشف النباتات من حولك وتعلّم الطريقة الأفضل للعناية بها.', style: TextStyle(color: Colors.white70, height: 1.5)),
              SizedBox(height: 16),
              _ComingSoonButton(),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text('ماذا تريد أن تفعل؟', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF193E30))),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.18,
          children: const [
            FeatureTile(icon: Icons.camera_alt_rounded, title: 'تعرّف على نبتة', subtitle: 'التقط صورة للنبتة', color: Color(0xFF2F8B57)),
            FeatureTile(icon: Icons.health_and_safety_outlined, title: 'افحص صحة النبتة', subtitle: 'تحليل الأوراق والأعراض', color: Color(0xFFB7791F)),
            FeatureTile(icon: Icons.yard_rounded, title: 'حديقتي', subtitle: 'نباتاتك في مكان واحد', color: Color(0xFF3977A8)),
            FeatureTile(icon: Icons.menu_book_rounded, title: 'موسوعة النباتات', subtitle: 'اكتشف أنواعاً جديدة', color: Color(0xFF8064A2)),
          ],
        ),
        const SizedBox(height: 22),
        const Text('كيف يعمل التطبيق؟', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF193E30))),
        const SizedBox(height: 10),
        const _StepRow(number: '١', title: 'صوّر النبتة', detail: 'التقط صورة واضحة للأوراق أو الزهرة.'),
        const _StepRow(number: '٢', title: 'احصل على التحليل', detail: 'تُرسل الصورة بأمان إلى خدمة التعرف.'),
        const _StepRow(number: '٣', title: 'احفظها في حديقتك', detail: 'احتفظ بمعلوماتها ومواعيد العناية على جهازك.'),
      ],
    );
  }
}

class _ComingSoonButton extends StatelessWidget {
  const _ComingSoonButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('سيتم تفعيل التصوير والتعرف في المرحلة التالية.')),
      ),
      style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF174B38)),
      icon: const Icon(Icons.center_focus_strong_rounded),
      label: const Text('ابدأ التعرف قريباً'),
    );
  }
}

class _StepRow extends StatelessWidget {
  final String number;
  final String title;
  final String detail;
  const _StepRow({required this.number, required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(radius: 17, backgroundColor: const Color(0xFFE1EFE5), child: Text(number, style: const TextStyle(color: Color(0xFF174B38), fontWeight: FontWeight.bold))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(detail, style: const TextStyle(color: Colors.black54, fontSize: 12)),
          ])),
        ],
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _PlaceholderPage({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 58, color: const Color(0xFF2F8B57)),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54, height: 1.5)),
          const SizedBox(height: 12),
          const Chip(label: Text('سيتم تفعيلها في مرحلة لاحقة')),
        ]),
      ),
    );
  }
}
