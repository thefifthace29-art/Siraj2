
import 'package:flutter/material.dart';

const Color cream = Color(0xFFFDFBF7);
const Color royalGreen = Color(0xFF0A4D2E);
const Color gold = Color(0xFFD4AF37);
const Color textColor = Color(0xFF26372D);

void main() {
  runApp(const SirajApp());
}

class SirajApp extends StatelessWidget {
  const SirajApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سِراج',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: royalGreen,
          primary: royalGreen,
          secondary: gold,
        ),
        fontFamily: 'Arial',
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void openSection(BuildContext context, String section) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'قسم $section جاهز للتطوير في المرحلة القادمة',
          textAlign: TextAlign.center,
        ),
        backgroundColor: royalGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 22),
                  decoration: BoxDecoration(
                    color: royalGreen,
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(color: gold, width: 1.4),
                    boxShadow: [
                      BoxShadow(
                        color: royalGreen.withOpacity(0.13),
                        blurRadius: 16,
                        offset: const Offset(0, 7),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          color: gold.withOpacity(0.13),
                          shape: BoxShape.circle,
                          border: Border.all(color: gold, width: 1.5),
                        ),
                        child: const Icon(
                          Icons.auto_stories_rounded,
                          color: gold,
                          size: 36,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'سِراج',
                        style: TextStyle(
                          color: gold,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '﴿ وَقُل رَّبِّ زِدْنِي عِلْمًا ﴾',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          height: 1.8,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 58,
                        height: 2,
                        color: gold,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'سِراج .. رفيقك في التعلم',
                        style: TextStyle(
                          color: Color(0xFFFDFBF7),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'أهلًا بك في سِراج',
                      style: TextStyle(
                        color: royalGreen,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      'مساحتك التعليمية لتنظيم التعلم ومتابعة التقدم',
                      style: TextStyle(
                        color: textColor.withOpacity(0.72),
                        fontSize: 14,
                        height: 1.7,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'أقسام التطبيق',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              sliver: SliverGrid(
                delegate: SliverChildListDelegate([
                  SectionCard(
                    title: 'العربية لغتي',
                    subtitle: 'الكتاب والأنشطة والاختبارات',
                    icon: Icons.menu_book_rounded,
                    color: royalGreen,
                    number: '١',
                    onTap: () => openSection(context, 'العربية لغتي'),
                  ),
                  SectionCard(
                    title: 'الرياضيات',
                    subtitle: 'المفاهيم والتدريبات',
                    icon: Icons.calculate_rounded,
                    color: const Color(0xFF426B55),
                    number: '٢',
                    onTap: () => openSection(context, 'الرياضيات'),
                  ),
                  SectionCard(
                    title: 'متابعة الطلاب',
                    subtitle: 'الحضور والمستوى والتقدم',
                    icon: Icons.groups_rounded,
                    color: const Color(0xFF8A6A22),
                    number: '٣',
                    onTap: () => openSection(context, 'متابعة الطلاب'),
                  ),
                  SectionCard(
                    title: 'تحضير الدروس',
                    subtitle: 'خطط تعليمية منظمة',
                    icon: Icons.edit_note_rounded,
                    color: const Color(0xFF526C83),
                    number: '٤',
                    onTap: () => openSection(context, 'تحضير الدروس'),
                  ),
                ]),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.88,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 26, 20, 22),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(color: gold, thickness: 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(
                            Icons.auto_awesome_rounded,
                            color: gold,
                            size: 22,
                          ),
                        ),
                        const Expanded(
                          child: Divider(color: gold, thickness: 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'إعداد وتصميم',
                      style: TextStyle(
                        color: royalGreen,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'مُعتز محمد الأحمد',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'مدرسةُ الأندلس الثالثة',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String number;
  final VoidCallback onTap;

  const SectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.number,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: gold.withOpacity(0.75),
              width: 1.1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(icon, color: color, size: 29),
                  ),
                  Text(
                    number,
                    style: TextStyle(
                      color: gold.withOpacity(0.95),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF6B746D),
                  fontSize: 12,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'استكشاف القسم',
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_back_rounded,
                    color: color,
                    size: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
