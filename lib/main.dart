
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

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
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child!,
      ),
      home: const HomePage(),
    );
  }
}

// ==================== الصفحة الرئيسية ====================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime now;
  Timer? clockTimer;

  final List<String> wisdoms = [
    'التعليم رسالة تبني العقول وتصنع المستقبل.',
    'المعلم الناجح يزرع حب التعلم قبل أن يزرع المعرفة.',
    'كل طفل قادر على التعلم إذا وجد من يؤمن بقدراته.',
    'الكلمة الطيبة من المعلم قد تبقى في ذاكرة الطالب عمرًا.',
    'التشجيع يفتح أبوابًا قد يعجز التوبيخ عن فتحها.',
    'ليس النجاح أن يتقدم طالب وحده، بل أن يجد كل طالب طريقه.',
    'الصبر في التعليم استثمار تظهر ثماره مع الأيام.',
    'السؤال الجيد بداية معرفة جديدة.',
    'الخطأ فرصة للتعلم، وليس سببًا للخجل.',
    'ازرع في طلابك الثقة، ثم علّمهم كيف يحققون أهدافهم.',
    'القراءة نافذة يطل منها العقل على العالم.',
    'التعلم الحقيقي أن يعرف الطالب كيف يفكر، لا ماذا يحفظ فقط.',
    'وراء كل إنجاز صغير جهد يستحق التقدير.',
    'العدل بين الطلاب أساس الثقة داخل الصف.',
    'الاستماع إلى الطالب أول خطوة لفهمه.',
    'المعلم قدوة بأفعاله قبل أقواله.',
    'البيئة الآمنة تجعل الطفل أكثر استعدادًا للتعلم.',
    'التكرار الهادف يرسخ المهارة ويزيد الثقة.',
    'لا تقارن طفلًا بآخر؛ قارن تقدمه بما كان عليه.',
    'النجاح في التعليم يبدأ بهدف واضح وخطوة صغيرة.',
    'كل حصة فرصة لاكتشاف قدرة جديدة لدى أحد الطلاب.',
    'التعلم باللعب يجعل المعرفة أقرب إلى قلب الطفل.',
    'الانضباط الناجح يقوم على الاحترام والوضوح.',
    'الطفل الذي يُمنح فرصة للمحاولة يتعلم الشجاعة.',
    'الأساس المتين أهم من السرعة في إنهاء الدروس.',
    'الإنصات الجيد يعلم الطالب أن صوته مهم.',
    'التحفيز الصادق أقوى من المكافأة وحدها.',
    'من حق كل طالب أن يتعلم وفق حاجته وقدرته.',
    'التعليم الجيد ينمي الفضول ولا يطفئه.',
    'خطوة متقنة اليوم تمهد لخطوات أكبر غدًا.',
    'حين يشعر الطالب بالأمان يصبح الخطأ بداية لا نهاية.',
    'التعاون بين الطلاب يحول الصف إلى مجتمع متعلم.',
    'المعلم المبدع يجد أكثر من طريق للوصول إلى الفهم.',
    'لا تستهن بسؤال صغير؛ فقد يقود إلى اكتشاف كبير.',
    'النجاح المدرسي ثمرة تعاون المعلم والطالب والأسرة.',
    'الطفل يحتاج إلى من يوجهه، لا إلى من يذكّره بعجزه.',
    'تنويع أساليب التدريس يمنح فرصًا أوسع للفهم.',
    'التعليم ليس ملء الذاكرة، بل إيقاظ العقل.',
    'احترم اختلاف الطلاب؛ فلكل عقل إيقاعه الخاص.',
    'الثناء على الجهد يعلم الطفل قيمة المثابرة.',
    'الهدف من الواجب أن يعزز التعلم لا أن يرهق الطفل.',
    'الصف الجميل هو الذي يشعر فيه كل طالب بأنه مهم.',
    'المعرفة تزداد قيمة عندما تتحول إلى سلوك نافع.',
    'ازرع عادة السؤال، تنمُ لدى الطالب رغبة الاكتشاف.',
    'أجمل أثر للمعلم أن يصبح الطالب قادرًا على التعلم بنفسه.',
    'الرفق في التعليم ليس ضعفًا، بل حكمة في بناء الإنسان.',
    'التقدم البطيء مع الفهم أفضل من السرعة بلا إتقان.',
    'من علّم طفلًا احترام المعرفة فتح له بابًا للمستقبل.',
    'الاستمرار في المحاولة جزء أساسي من طريق النجاح.',
    'وراء كل طالب متعثر قدرة تنتظر الطريقة المناسبة.',
    'التعليم الناجح يجمع بين المعرفة والأخلاق والرحمة.',
    'علّم طلابك أن اختلاف الإجابات قد يكون بداية للحوار.',
    'كل يوم دراسي جديد فرصة لبداية أفضل.',
    'المعلم الذي يتعلم باستمرار يمنح طلابه مثالًا حيًا.',
    'بناء الشخصية لا يقل أهمية عن تحصيل المعلومات.',
    'اجعل من الصف مكانًا يجرؤ فيه الطالب على التفكير.',
    'الاهتمام بالتفاصيل الصغيرة يصنع فرقًا كبيرًا في التعلم.',
    'لا يوجد جهد صادق في التعليم يضيع بلا أثر.',
  ];

  @override
  void initState() {
    super.initState();
    now = DateTime.now();

    clockTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) {
        if (mounted) {
          setState(() => now = DateTime.now());
        }
      },
    );
  }

  @override
  void dispose() {
    clockTimer?.cancel();
    super.dispose();
  }

  String arabicDigits(String value) {
    const western = '0123456789';
    const eastern = '٠١٢٣٤٥٦٧٨٩';

    for (int i = 0; i < western.length; i++) {
      value = value.replaceAll(western[i], eastern[i]);
    }

    return value;
  }

  String get formattedTime {
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return arabicDigits('$hour:$minute');
  }

  String get formattedDate {
    const weekdays = [
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];

    const months = [
      'كانون الثاني',
      'شباط',
      'آذار',
      'نيسان',
      'أيار',
      'حزيران',
      'تموز',
      'آب',
      'أيلول',
      'تشرين الأول',
      'تشرين الثاني',
      'كانون الأول',
    ];

    return '${weekdays[now.weekday - 1]}، '
        '${arabicDigits(now.day.toString())} '
        '${months[now.month - 1]} '
        '${arabicDigits(now.year.toString())}';
  }

  int get dailyWisdomIndex {
    final today = DateTime(now.year, now.month, now.day);
    final firstDay = DateTime(2026, 1, 1);
    return today.difference(firstDay).inDays % wisdoms.length;
  }

  void openSection(String section) {
    if (section == 'العربية لغتي') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ArabicPage(),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'سيتم تطوير قسم $section في المرحلة القادمة',
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
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: royalGreen,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: gold, width: 1.3),
                    boxShadow: [
                      BoxShadow(
                        color: royalGreen.withOpacity(0.12),
                        blurRadius: 14,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: gold.withOpacity(0.13),
                          border: Border.all(color: gold, width: 1.4),
                        ),
                        child: const Icon(
                          Icons.auto_stories_rounded,
                          color: gold,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'سِراج',
                        style: TextStyle(
                          color: gold,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '﴿ وَقُل رَّبِّ زِدْنِي عِلْمًا ﴾',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          height: 1.8,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Container(width: 50, height: 2, color: gold),
                      const SizedBox(height: 9),
                      const Text(
                        'سِراج .. رفيقك في التعلم',
                        style: TextStyle(color: cream, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // بطاقة المعلم والمدرسة
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: gold.withOpacity(0.8)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: royalGreen.withOpacity(0.09),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          color: royalGreen,
                          size: 29,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'المُعَلِّم',
                              style: TextStyle(
                                color: Color(0xFF7B806F),
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'مُعتز محمد الأحمد',
                              style: TextStyle(
                                color: royalGreen,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: gold,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    'مدرسةُ الأندلس الثالثة',
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // الوقت والتاريخ
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 13, 16, 0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: royalGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: gold.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.access_time_rounded,
                          color: gold,
                          size: 27,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'الوقت والتاريخ',
                              style: TextStyle(
                                color: Color(0xFFE7D9A5),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        formattedTime,
                        style: const TextStyle(
                          color: gold,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // حكمة اليوم
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(19),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9E8),
                    borderRadius: BorderRadius.circular(23),
                    border: Border.all(
                      color: gold.withOpacity(0.85),
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 43,
                            height: 43,
                            decoration: BoxDecoration(
                              color: gold.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.lightbulb_rounded,
                              color: royalGreen,
                              size: 27,
                            ),
                          ),
                          const SizedBox(width: 11),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'حكمة اليوم',
                                  style: TextStyle(
                                    color: royalGreen,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  'فكرة تربوية ترافق يومك',
                                  style: TextStyle(
                                    color: Color(0xFF77715F),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.format_quote_rounded,
                            color: gold,
                            size: 32,
                          ),
                        ],
                      ),
                      const SizedBox(height: 17),
                      Text(
                        wisdoms[dailyWisdomIndex],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 17,
                          height: 1.9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 13),
                      Center(
                        child: Text(
                          'الحكمة ${arabicDigits((dailyWisdomIndex + 1).toString())} '
                          'من ${arabicDigits(wisdoms.length.toString())}',
                          style: const TextStyle(
                            color: royalGreen,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // الأقسام الرئيسية
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'أقسام سِراج',
                      style: TextStyle(
                        color: royalGreen,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'اختر القسم الذي تريد العمل فيه',
                      style: TextStyle(
                        color: textColor.withOpacity(0.72),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                delegate: SliverChildListDelegate([
                  SectionCard(
                    title: 'العربية لغتي',
                    subtitle: 'الكتاب والأنشطة والاختبارات',
                    icon: Icons.menu_book_rounded,
                    color: royalGreen,
                    onTap: () => openSection('العربية لغتي'),
                  ),
                  SectionCard(
                    title: 'الرياضيات',
                    subtitle: 'المفاهيم والتدريبات',
                    icon: Icons.calculate_rounded,
                    color: const Color(0xFF426B55),
                    onTap: () => openSection('الرياضيات'),
                  ),
                  SectionCard(
                    title: 'متابعة الطلاب',
                    subtitle: 'الحضور والمستوى والتقدم',
                    icon: Icons.groups_rounded,
                    color: const Color(0xFF8A6A22),
                    onTap: () => openSection('متابعة الطلاب'),
                  ),
                  SectionCard(
                    title: 'تحضير الدروس',
                    subtitle: 'خطط تعليمية منظمة',
                    icon: Icons.edit_note_rounded,
                    color: const Color(0xFF526C83),
                    onTap: () => openSection('تحضير الدروس'),
                  ),
                ]),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 13,
                  crossAxisSpacing: 13,
                  childAspectRatio: 0.88,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 24),
                child: Column(
                  children: [
                    const Divider(color: gold, thickness: 1),
                    const SizedBox(height: 10),
                    const Text(
                      'سِراج .. رفيقك في التعلم',
                      style: TextStyle(
                        color: royalGreen,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'نسأل الله علمًا نافعًا وعملًا صالحًا',
                      style: TextStyle(
                        color: textColor.withOpacity(0.7),
                        fontSize: 12,
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

// ==================== قسم العربية لغتي ====================

class ArabicPage extends StatelessWidget {
  const ArabicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: royalGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'العربية لغتي',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: royalGreen,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: gold, width: 1.2),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.menu_book_rounded,
                  color: gold,
                  size: 48,
                ),
                SizedBox(height: 10),
                Text(
                  'العربية لغتي',
                  style: TextStyle(
                    color: gold,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'الصف الثاني الابتدائي',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'الكتاب هو مرجع التحضير والأنشطة والتقويم',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ArabicFeatureCard(
            icon: Icons.book_rounded,
            title: 'الكتاب المدرسي',
            subtitle: 'الكتاب الكامل داخل التطبيق، دون إنترنت',
            color: royalGreen,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TextbookPage(),
                ),
              );
            },
          ),
          ArabicFeatureCard(
            icon: Icons.list_alt_rounded,
            title: 'فهرس الكتاب',
            subtitle: 'الوحدات والدروس والانتقال المباشر إلى الصفحة',
            color: const Color(0xFF8A6A22),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BookIndexPage(),
                ),
              );
            },
          ),
          ArabicFeatureCard(
            icon: Icons.edit_note_rounded,
            title: 'تحضير الدروس',
            subtitle: 'تحضير منظم مرتبط بالدروس وأهدافها',
            color: const Color(0xFF526C83),
            onTap: () => showComingSoon(context, 'تحضير الدروس'),
          ),
          ArabicFeatureCard(
            icon: Icons.extension_rounded,
            title: 'الأنشطة الشفهية والكتابية',
            subtitle: 'الاستماع والتعبير والإملاء والتدريبات',
            color: const Color(0xFF8A6A22),
            onTap: () => showComingSoon(context, 'الأنشطة الشفهية والكتابية'),
          ),
          ArabicFeatureCard(
            icon: Icons.assignment_rounded,
            title: 'أوراق العمل والامتحانات',
            subtitle: 'تدريبات وتقويمات مرتبطة بمحتوى الكتاب',
            color: const Color(0xFF426B55),
            onTap: () => showComingSoon(context, 'أوراق العمل والامتحانات'),
          ),
          const SizedBox(height: 12),
          const Text(
            'سنطوّر بقية الأدوات تدريجيًا، مع اعتماد الكتاب المدرسي مرجعًا أساسيًا.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              height: 1.8,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== بطاقة ميزة العربية ====================

class ArabicFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const ArabicFeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 13),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: gold.withOpacity(0.65)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color, size: 30),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: color,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF6B746D),
                        fontSize: 12,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: gold,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== فهرس الكتاب التفاعلي ====================

class BookIndexPage extends StatelessWidget {
  const BookIndexPage({super.key});

  static const List<Map<String, dynamic>> units = [
    {
      'title': 'الوحدة الأولى: المواطنة والانتماء',
      'icon': Icons.flag_rounded,
      'color': Color(0xFF0A4D2E),
      'lessons': [
        {'title': 'اليوم الأول في المدرسة', 'page': 4},
        {'title': 'من حقي أن أتعلم', 'page': 12},
        {'title': 'وطني', 'page': 20},
        {'title': 'الزيتونة والريح', 'page': 27},
      ],
    },
    {
      'title': 'الوحدة الثانية: الرياضة والفنون',
      'icon': Icons.palette_rounded,
      'color': Color(0xFF8A6A22),
      'lessons': [
        {'title': 'هيا نسبح', 'page': 36},
        {'title': 'تحدي الأذكياء', 'page': 44},
        {'title': 'عشاق الأغاني', 'page': 51},
        {'title': 'العالم الطبيب', 'page': 57},
      ],
    },
    {
      'title': 'الوحدة الثالثة: دنيا العلوم',
      'icon': Icons.science_rounded,
      'color': Color(0xFF526C83),
      'lessons': [
        {'title': 'جرة الفخار وجرة الحديد', 'page': 68},
        {'title': 'رحلة الفضاء', 'page': 71},
        {'title': 'متحف دمشق التربوي', 'page': 78},
        {'title': 'هل تعلم؟', 'page': 85},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: royalGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'فهرس الكتاب',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: royalGreen,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: gold, width: 1.2),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.menu_book_rounded,
                  color: gold,
                  size: 42,
                ),
                SizedBox(height: 10),
                Text(
                  'العربية لغتي',
                  style: TextStyle(
                    color: gold,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'الصف الثاني الأساسي • الفصل الأول',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'اختر الوحدة، ثم اضغط على الدرس لفتحه مباشرةً.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          for (final unit in units)
            Card(
              color: Colors.white,
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: (unit['color'] as Color).withOpacity(0.35),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: ExpansionTile(
                initiallyExpanded: true,
                leading: Icon(
                  unit['icon'] as IconData,
                  color: unit['color'] as Color,
                  size: 29,
                ),
                iconColor: gold,
                collapsedIconColor: royalGreen,
                title: Text(
                  unit['title'] as String,
                  style: TextStyle(
                    color: unit['color'] as Color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  for (final lesson
                      in unit['lessons'] as List<Map<String, dynamic>>)
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            (unit['color'] as Color).withOpacity(0.10),
                        child: Icon(
                          Icons.menu_book_rounded,
                          color: unit['color'] as Color,
                          size: 21,
                        ),
                      ),
                      title: Text(
                        lesson['title'] as String,
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        'الصفحة ${lesson['page']}',
                        style: const TextStyle(
                          color: Color(0xFF77715F),
                          fontSize: 12,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: gold,
                        size: 17,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TextbookPage(
                              initialPage: lesson['page'] as int,
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'سِراج .. رفيقك في التعلم',
              style: TextStyle(
                color: royalGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

void showComingSoon(BuildContext context, String feature) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      title: const Text(
        'قيد التطوير',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: royalGreen,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'سنطوّر $feature في المرحلة القادمة، مع ربطها بمحتوى الكتاب المدرسي.',
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: royalGreen,
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text('حسنًا'),
        ),
      ],
    ),
  );
}

// ==================== عارض الكتاب المدرسي ====================

class TextbookPage extends StatefulWidget {
  final int initialPage;

  const TextbookPage({
    super.key,
    this.initialPage = 1,
  });

  @override
  State<TextbookPage> createState() => _TextbookPageState();
}

class _TextbookPageState extends State<TextbookPage> {
  late final PdfControllerPinch pdfController;
  late int currentPage;
  int totalPages = 0;
  Object? loadingError;

  @override
  void initState() {
    super.initState();

    currentPage = widget.initialPage;

    pdfController = PdfControllerPinch(
      document: PdfDocument.openAsset('arabic_grade2_term1.pdf'),
      initialPage: widget.initialPage,
    );

    pdfController.document.then((document) {
      if (mounted) {
        setState(() {
          totalPages = document.pagesCount;
        });
      }
    }).catchError((error) {
      if (mounted) {
        setState(() {
          loadingError = error;
        });
      }
    });
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  void goToPreviousPage() {
    if (currentPage > 1) {
      pdfController.previousPage(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 250),
      );
    }
  }

  void goToNextPage() {
    if (totalPages > 0 && currentPage < totalPages) {
      pdfController.nextPage(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 250),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: royalGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'الكتاب المدرسي',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            color: const Color(0xFFECE6D8),
            child: Row(
              children: [
                IconButton(
                  tooltip: 'الصفحة السابقة',
                  onPressed: goToPreviousPage,
                  icon: const Icon(
                    Icons.arrow_forward_rounded,
                    color: royalGreen,
                  ),
                ),
                Expanded(
                  child: Text(
                    totalPages == 0
                        ? 'كتاب العربية لغتي'
                        : 'الصفحة ${currentPage.toString()} من ${totalPages.toString()}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: royalGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'الصفحة التالية',
                  onPressed: goToNextPage,
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: royalGreen,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: loadingError != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.error_outline_rounded,
                            color: Colors.redAccent,
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'تعذّر فتح الكتاب.',
                            style: TextStyle(
                              color: royalGreen,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'تحقّق من اسم ملف PDF ومساره في المستودع، ثم أعد البناء.',
                            textAlign: TextAlign.center,
                            style: TextStyle(height: 1.7),
                          ),
                        ],
                      ),
                    ),
                  )
                : PdfViewPinch(
                    controller: pdfController,
                    onPageChanged: (page) {
                      if (mounted) {
                        setState(() => currentPage = page);
                      }
                    },
                    builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
                      options: const DefaultBuilderOptions(),
                      documentLoaderBuilder: (_) => const Center(
                        child: CircularProgressIndicator(
                          color: royalGreen,
                        ),
                      ),
                      pageLoaderBuilder: (_) => const Center(
                        child: CircularProgressIndicator(
                          color: royalGreen,
                        ),
                      ),
                      errorBuilder: (_, error) => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Text(
                            'حدث خطأ أثناء عرض صفحات الكتاب.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ==================== بطاقة القسم الرئيسية ====================

class SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const SectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
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
              Container(
                width: 47,
                height: 47,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: color, size: 28),
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
                  Flexible(
                    child: Text(
                      'استكشاف القسم',
                      style: TextStyle(
                        color: color,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
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
