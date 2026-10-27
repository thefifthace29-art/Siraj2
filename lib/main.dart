import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'lesson_prep_page.dart';
import 'group_challenge_screen.dart';

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

    if (section == 'تحضير الدروس') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const LessonPrepPage(),
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
                Icon(Icons.menu_book_rounded, color: gold, size: 48),
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
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'الكتاب هو مرجع التحضير والأنشطة والتقويم',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, height: 1.7),
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

          // بطاقة ألعب وأتعلّم الجديدة، بدل بطاقة التحضير داخل هذا القسم.
          ArabicFeatureCard(
            icon: Icons.rocket_launch_rounded,
            title: 'ألعب وأتعلّم',
            subtitle: 'مغامرات وألغاز وتحديات لغوية ممتعة',
            color: const Color(0xFF8A4F91),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PlayAndLearnPage(),
                ),
              );
            },
          ),
          ArabicFeatureCard(
            icon: Icons.extension_rounded,
            title: 'الأنشطة الشفهية والكتابية',
            subtitle: 'الاستماع والتعبير والإملاء والتدريبات',
            color: const Color(0xFF8A6A22),
            onTap: () => showComingSoon(
              context,
              'الأنشطة الشفهية والكتابية',
            ),
          ),
          ArabicFeatureCard(
            icon: Icons.assignment_rounded,
            title: 'أوراق العمل والامتحانات',
            subtitle: 'تدريبات وتقويمات مرتبطة بمحتوى الكتاب',
            color: const Color(0xFF426B55),
            onTap: () => showComingSoon(
              context,
              'أوراق العمل والامتحانات',
            ),
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

// ==================== ألعب وأتعلّم ====================

class SirajQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const SirajQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class SirajActivity {
  final String title;
  final String subtitle;
  final String description;
  final String emoji;
  final Color color;
  final String skill;
  final List<SirajQuestion> questions;

  const SirajActivity({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.emoji,
    required this.color,
    required this.skill,
    required this.questions,
  });
}

const List<SirajQuestion> arabicChallengeQuestions = [
  SirajQuestion(
    question: 'أي كلمة تبدأ بحرف الباء؟',
    options: ['قَلَم', 'بَاب', 'شَمْس'],
    correctIndex: 1,
    explanation: 'أحسنت! كلمة «باب» تبدأ بحرف الباء.',
  ),
  SirajQuestion(
    question: 'ما جمع كلمة «كتاب»؟',
    options: ['كاتِب', 'مَكْتَب', 'كُتُب'],
    correctIndex: 2,
    explanation: 'صحيح! جمع كتاب هو كُتُب.',
  ),
  SirajQuestion(
    question: 'أي كلمة تنتهي بحرف التاء؟',
    options: ['بَيْت', 'باب', 'قَلَم'],
    correctIndex: 0,
    explanation: 'رائع! كلمة «بيت» تنتهي بحرف التاء.',
  ),
  SirajQuestion(
    question: 'اختر الكلمة التي تدل على حيوان.',
    options: ['مَدْرَسَة', 'أَسَد', 'نافِذَة'],
    correctIndex: 1,
    explanation: 'صحيح! الأسد حيوان.',
  ),
  SirajQuestion(
    question: 'أي جملة مكتوبة بطريقة صحيحة؟',
    options: ['ذَهَبَ الوَلَدُ', 'ذهب الولد', 'ذَهَبَ الولدُ إلى'],
    correctIndex: 0,
    explanation: 'أحسنت! الجملة الأولى مكتملة ومضبوطة.',
  ),
  SirajQuestion(
    question: 'أي كلمة تحتوي على حرف المد «ا»؟',
    options: ['باب', 'بِنْت', 'قِطّ'],
    correctIndex: 0,
    explanation: 'صحيح! في كلمة «باب» حرف مد بالألف.',
  ),
  SirajQuestion(
    question: 'ما ضد كلمة «كبير»؟',
    options: ['طويل', 'صغير', 'واسع'],
    correctIndex: 1,
    explanation: 'رائع! ضد كبير هو صغير.',
  ),
  SirajQuestion(
    question: 'أي كلمة تبدأ بحرف الشين؟',
    options: ['شَجَرَة', 'زَهْرَة', 'قَمَر'],
    correctIndex: 0,
    explanation: 'صحيح! شجرة تبدأ بحرف الشين.',
  ),
  SirajQuestion(
    question: 'ما الكلمة التي تدل على مكان نتعلم فيه؟',
    options: ['مَدْرَسَة', 'سَيّارَة', 'تُفّاحَة'],
    correctIndex: 0,
    explanation: 'أحسنت! المدرسة مكان للتعلم.',
  ),
  SirajQuestion(
    question: 'أي كلمة تبدأ بـ«الـ» التعريف؟',
    options: ['قَلَم', 'القَلَم', 'أَقْلام'],
    correctIndex: 1,
    explanation: 'صحيح! «القلم» تبدأ بأل التعريف.',
  ),
];

class PlayAndLearnPage extends StatelessWidget {
  const PlayAndLearnPage({super.key});

  static const List<SirajActivity> activities = [
    SirajActivity(
      title: 'جزيرة الأسرار',
      subtitle: 'رحلة للبحث عن الكنز',
      description:
          'انطلق في مغامرة بين الجزر، وافتح الطريق إلى الكنز بحل الألغاز اللغوية والإجابة عن الأسئلة.',
      emoji: '🏝️',
      color: Color(0xFF168C83),
      skill: 'الفهم والمفردات',
      questions: arabicChallengeQuestions,
    ),
    SirajActivity(
      title: 'مدينة سِراج العجيبة',
      subtitle: 'ابنِ مدينة بالكلمات الصحيحة',
      description:
          'ساعد سكان المدينة على إكمال الكلمات والجمل، واجمع النجوم لتفتح أماكن جديدة.',
      emoji: '🏰',
      color: Color(0xFF5576C5),
      skill: 'القراءة وبناء الجمل',
      questions: arabicChallengeQuestions,
    ),
    SirajActivity(
      title: 'وكالة المحققين الصغار',
      subtitle: 'حلّ اللغز واكتشف الدليل',
      description:
          'أنت محقق صغير! ابحث عن الكلمة الصحيحة، وقارن الأدلة، واكتشف الإجابة التي تحل اللغز.',
      emoji: '🔎',
      color: Color(0xFF8A6A22),
      skill: 'الملاحظة والاستنتاج',
      questions: arabicChallengeQuestions,
    ),
    SirajActivity(
      title: 'مهمة لا ينجح فيها أحد وحده',
      subtitle: 'التعاون سر النجاح',
      description:
          'تحتاج هذه المهمة إلى تبادل الأفكار ومساعدة الآخرين. ناقشوا الإجابات معًا قبل اختيارها.',
      emoji: '🤝',
      color: Color(0xFF39865D),
      skill: 'التعاون والتواصل',
      questions: arabicChallengeQuestions,
    ),
    SirajActivity(
      title: 'مسرح الحكايات الحية',
      subtitle: 'رتّب الأحداث واكتشف القصة',
      description:
          'تعرّف إلى شخصيات الحكاية، وفكّر في بداية القصة وأحداثها ونهايتها، ثم أجب عن التحديات.',
      emoji: '🎭',
      color: Color(0xFFAD5B7A),
      skill: 'التعبير وفهم النص',
      questions: arabicChallengeQuestions,
    ),
    SirajActivity(
      title: 'مخترعو المستحيل',
      subtitle: 'أفكار ذكية وأسئلة ممتعة',
      description:
          'استخدم خيالك، واختر الكلمات المناسبة، واكتشف كيف يمكن لفكرة صغيرة أن تتحول إلى اختراع.',
      emoji: '💡',
      color: Color(0xFFD18B27),
      skill: 'التفكير الإبداعي',
      questions: arabicChallengeQuestions,
    ),
    SirajActivity(
      title: 'كرنفال سِراج',
      subtitle: 'ألعاب لغوية متنوعة',
      description:
          'ادخل عالم الألعاب القصيرة، واختبر معرفتك بالحروف والكلمات والمعاني بطريقة مرحة.',
      emoji: '🎪',
      color: Color(0xFF9A5BC1),
      skill: 'المراجعة العامة',
      questions: arabicChallengeQuestions,
    ),
    SirajActivity(
      title: 'صندوق المفاجآت',
      subtitle: 'افتح الصندوق بالسؤال الصحيح',
      description:
          'كل إجابة صحيحة تقرّبك من فتح الصندوق. اقرأ السؤال بهدوء واختر إجابتك.',
      emoji: '🎁',
      color: Color(0xFFD15C49),
      skill: 'المفردات والتمييز',
      questions: arabicChallengeQuestions,
    ),
    SirajActivity(
      title: 'الرسائل السرية',
      subtitle: 'اكتشف الكلمة المخفية',
      description:
          'افكك الشفرات البسيطة، وانتبه إلى الحروف والكلمات لتصل إلى الرسالة المخفية.',
      emoji: '✉️',
      color: Color(0xFF467E9D),
      skill: 'تمييز الحروف والكلمات',
      questions: arabicChallengeQuestions,
    ),
    SirajActivity(
      title: 'بناء المدن',
      subtitle: 'كل إجابة تبني جزءًا جديدًا',
      description:
          'أجب عن الأسئلة لتضيف مباني جديدة إلى مدينتك، وتعلّم كيف تصنع الكلمات عالمًا متكاملًا.',
      emoji: '🏗️',
      color: Color(0xFF9B7942),
      skill: 'القراءة والمفردات',
      questions: arabicChallengeQuestions,
    ),
    SirajActivity(
      title: 'مصنع الحكايات المضحكة',
      subtitle: 'كلمات تصنع حكاية طريفة',
      description:
          'اختر الإجابات، وتخيّل كيف تتكوّن الحكايات من كلمات وشخصيات وأحداث غير متوقعة.',
      emoji: '🤹',
      color: Color(0xFFDB7B37),
      skill: 'اللغة والخيال',
      questions: arabicChallengeQuestions,
    ),
    SirajActivity(
      title: 'تحديات الفرق',
      subtitle: 'تحدّوا بعضكم بروح رياضية',
      description:
          'يمكن للمعلم تقسيم الطلاب إلى فرق، وقراءة السؤال للجميع، ثم مناقشة الإجابات والتعلّم من الأخطاء.',
      emoji: '🏆',
      color: Color(0xFF357C68),
      skill: 'التعاون والمراجعة',
      questions: arabicChallengeQuestions,
    ),
    SirajActivity(
      title: 'النهايات المتعددة',
      subtitle: 'اختر، وفكّر، واكتشف',
      description:
          'تخيّل أكثر من نهاية للقصة، ثم اختبر فهمك للكلمات والجمل من خلال مجموعة من الأسئلة.',
      emoji: '🌈',
      color: Color(0xFF7868B5),
      skill: 'الفهم والتفكير',
      questions: arabicChallengeQuestions,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: royalGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'ألعب وأتعلّم',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0A4D2E), Color(0xFF287B55)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: gold, width: 1.2),
            ),
            child: const Column(
              children: [
                Text('🎮', style: TextStyle(fontSize: 48)),
                SizedBox(height: 8),
                Text(
                  'مرحبًا بك في عالم سِراج!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: gold,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'تعلّم، واكتشف، وحلّ الألغاز، واجمع النجوم. كل محاولة فرصة جديدة للنجاح!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.9,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Icon(
                Icons.explore_rounded,
                color: royalGreen,
                size: 27,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'اختر مغامرتك',
                  style: TextStyle(
                    color: royalGreen,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF2CC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '١٣ نشاطًا',
                  style: TextStyle(
                    color: royalGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'اختر بطاقة لقراءة المهمة ثم ابدأ التحدي.',
            style: TextStyle(
              color: Color(0xFF6B746D),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          for (final activity in activities)
            ActivityCard(
              activity: activity,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GameIntroPage(activity: activity),
                  ),
                );
              },
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

// ==================== بطاقة النشاط ====================

class ActivityCard extends StatelessWidget {
  final SirajActivity activity;
  final VoidCallback onTap;

  const ActivityCard({
    super.key,
    required this.activity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: activity.color.withOpacity(0.35)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 62,
                height: 62,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: activity.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  activity.emoji,
                  style: const TextStyle(fontSize: 34),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.title,
                      style: TextStyle(
                        color: activity.color,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      activity.subtitle,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      'المهارة: ${activity.skill}',
                      style: const TextStyle(
                        color: Color(0xFF77715F),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Icon(
                Icons.arrow_back_ios_new_rounded,
                color: activity.color,
                size: 17,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== مقدمة المغامرة ====================

class GameIntroPage extends StatelessWidget {
  final SirajActivity activity;

  const GameIntroPage({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: activity.color,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          activity.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: activity.color.withOpacity(0.10),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: activity.color.withOpacity(0.35),
              ),
            ),
            child: Column(
              children: [
                Text(
                  activity.emoji,
                  style: const TextStyle(fontSize: 76),
                ),
                const SizedBox(height: 12),
                Text(
                  activity.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: activity.color,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  activity.subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 15,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'مهمتك',
            style: TextStyle(
              color: royalGreen,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            activity.description,
            style: const TextStyle(
              color: textColor,
              fontSize: 16,
              height: 1.9,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF9E8),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: gold.withOpacity(0.7)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.lightbulb_outline_rounded,
                  color: royalGreen,
                  size: 27,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    activity.title == 'جزيرة الأسرار'
                        ? 'ستعبر أربع محطات متتابعة: الشاطئ، وباب الكلمات، وجسر الأضداد، ثم كهف الكنز. افتح كل محطة بالإجابة الصحيحة واجمع الأدلة حتى تصل إلى الكنز.'
                        : 'ستجيب عن ${activity.questions.length} أسئلة لغوية. اقرأ كل سؤال جيدًا، واختر الإجابة، وتعلّم من التفسير الذي يظهر بعد اختيارك.',
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 14,
                      height: 1.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: activity.color,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => activity.title == 'جزيرة الأسرار'
                        ? const IslandAdventurePage()
                        : LearningQuizPage(activity: activity),
                  ),
                );
              },
              icon: const Icon(Icons.play_arrow_rounded, size: 28),
              label: const Text(
                'ابدأ التحدي',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: royalGreen,
              side: const BorderSide(color: royalGreen),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_forward_rounded),
            label: const Text('العودة إلى الأنشطة'),
          ),
        ],
      ),
    );
  }
}

// ==================== مغامرة جزيرة الأسرار ====================

class IslandAdventurePage extends StatefulWidget {
  const IslandAdventurePage({super.key});

  @override
  State<IslandAdventurePage> createState() => _IslandAdventurePageState();
}

class _IslandAdventurePageState extends State<IslandAdventurePage> {
  int stageIndex = 0;
  int? selectedIndex;
  bool answered = false;
  bool completed = false;
  int score = 0;

  static const List<SirajQuestion> islandQuestions = [
    SirajQuestion(
      question: 'وصلت إلى الشاطئ. أي كلمة تبدأ بحرف الباء لتفتح الطريق؟',
      options: ['قَمَر', 'بَحْر', 'شَجَر'],
      correctIndex: 1,
      explanation: 'أحسنت! «بَحْر» تبدأ بحرف الباء. حصلت على خريطة الجزيرة.',
    ),
    SirajQuestion(
      question: 'وجدت بابًا عليه لغز: ما جمع كلمة «كتاب»؟',
      options: ['كاتِب', 'مَكْتَب', 'كُتُب'],
      correctIndex: 2,
      explanation: 'صحيح! جمع «كتاب» هو «كُتُب». حصلت على المفتاح الأول.',
    ),
    SirajQuestion(
      question: 'يحرس الجسر لغزٌ عن الأضداد. ما ضد كلمة «كبير»؟',
      options: ['واسِع', 'صَغير', 'طَويل'],
      correctIndex: 1,
      explanation: 'رائع! ضد «كبير» هو «صغير». أصبح الجسر آمنًا للعبور.',
    ),
    SirajQuestion(
      question: 'أمام الكنز ثلاث كلمات. اختر الكلمة التي تدل على حيوان.',
      options: ['نافِذَة', 'مَدْرَسَة', 'أَسَد'],
      correctIndex: 2,
      explanation: 'أحسنت! الأسد حيوان، وقد جمعت الأدلة اللازمة لفتح الكنز.',
    ),
  ];

  SirajQuestion get currentQuestion => islandQuestions[stageIndex];

  void chooseAnswer(int index) {
    if (answered || completed) return;
    setState(() {
      selectedIndex = index;
      answered = true;
      if (index == currentQuestion.correctIndex) score++;
    });
  }

  void continueAdventure() {
    if (!answered) return;
    if (selectedIndex != currentQuestion.correctIndex) {
      setState(() {
        selectedIndex = null;
        answered = false;
      });
      return;
    }
    if (stageIndex == islandQuestions.length - 1) {
      setState(() => completed = true);
      return;
    }
    setState(() {
      stageIndex++;
      selectedIndex = null;
      answered = false;
    });
  }

  void restartAdventure() {
    setState(() {
      stageIndex = 0;
      selectedIndex = null;
      answered = false;
      completed = false;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = completed ? 1.0 : (stageIndex + (answered && selectedIndex == currentQuestion.correctIndex ? 1 : 0)) / islandQuestions.length;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF168C83),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('جزيرة الأسرار', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0A4D2E), Color(0xFF168C83)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: gold, width: 1.2),
              ),
              child: Column(
                children: [
                  Text(completed ? '🏆' : '🏝️', style: const TextStyle(fontSize: 58)),
                  const SizedBox(height: 8),
                  Text(
                    completed ? 'لقد عثرت على الكنز!' : 'مغامرة البحث عن الكنز',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: gold, fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    completed
                        ? 'أتممت مراحل الجزيرة وجمعت الأدلة الأربعة. نتيجتك $score من ${islandQuestions.length}.'
                        : 'حلّ لغز كل محطة لتفتح الطريق إلى المحطة التالية. لا يمكنك الوصول إلى الكنز قبل جمع الأدلة!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, height: 1.8, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFB7DCD4))),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(child: Text('خريطة الجزيرة', style: TextStyle(color: royalGreen, fontSize: 18, fontWeight: FontWeight.bold))),
                      Text('${completed ? islandQuestions.length : stageIndex + 1} / ${islandQuestions.length}', style: const TextStyle(color: Color(0xFF168C83), fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LinearProgressIndicator(value: progress, minHeight: 9, backgroundColor: const Color(0xFFE3EFEB), valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF168C83))),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(islandQuestions.length, (i) {
                      final unlocked = completed || i < stageIndex || (i == stageIndex && answered && selectedIndex == currentQuestion.correctIndex);
                      return Column(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: unlocked ? const Color(0xFFDDF3E8) : const Color(0xFFF0EEE8), shape: BoxShape.circle, border: Border.all(color: unlocked ? const Color(0xFF168C83) : const Color(0xFFD8D2C4), width: 1.5)),
                            child: Text(unlocked ? '🔑' : (i == islandQuestions.length - 1 ? '💎' : '🔒'), style: const TextStyle(fontSize: 22)),
                          ),
                          const SizedBox(height: 5),
                          Text(['الشاطئ', 'الباب', 'الجسر', 'الكنز'][i], style: const TextStyle(fontSize: 11, color: textColor, fontWeight: FontWeight.w600)),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
            if (!completed) ...[
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(19),
                decoration: BoxDecoration(color: const Color(0xFFFDFBF7), borderRadius: BorderRadius.circular(22), border: Border.all(color: const Color(0xFFB7DCD4), width: 1.4)),
                child: Column(
                  children: [
                    Text(['🌊', '🚪', '🌉', '💎'][stageIndex], style: const TextStyle(fontSize: 42)),
                    const SizedBox(height: 10),
                    Text('المحطة ${stageIndex + 1}: ${['شاطئ الحروف', 'باب الكلمات', 'جسر الأضداد', 'كهف الكنز'][stageIndex]}', textAlign: TextAlign.center, style: const TextStyle(color: royalGreen, fontSize: 19, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Text(currentQuestion.question, textAlign: TextAlign.center, style: const TextStyle(color: textColor, fontSize: 18, height: 1.8, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              for (int i = 0; i < currentQuestion.options.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Material(
                    color: answered && i == currentQuestion.correctIndex ? const Color(0xFFDDF3E8) : answered && i == selectedIndex ? const Color(0xFFFFE5DF) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      onTap: () => chooseAnswer(i),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: answered && i == currentQuestion.correctIndex ? const Color(0xFF168C83) : const Color(0xFFE0DACE))),
                        child: Row(
                          children: [
                            CircleAvatar(radius: 16, backgroundColor: const Color(0xFFE3F1ED), child: Text(['أ', 'ب', 'ج'][i], style: const TextStyle(color: royalGreen, fontWeight: FontWeight.bold))),
                            const SizedBox(width: 12),
                            Expanded(child: Text(currentQuestion.options[i], style: const TextStyle(color: textColor, fontSize: 17, fontWeight: FontWeight.w600))),
                            if (answered && i == currentQuestion.correctIndex) const Icon(Icons.check_circle, color: Color(0xFF168C83)),
                            if (answered && i == selectedIndex && i != currentQuestion.correctIndex) const Icon(Icons.cancel, color: Colors.redAccent),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (answered) ...[
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: selectedIndex == currentQuestion.correctIndex ? const Color(0xFFE5F5EB) : const Color(0xFFFFF0E8), borderRadius: BorderRadius.circular(15)),
                  child: Text(currentQuestion.explanation, style: const TextStyle(color: textColor, height: 1.8)),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: continueAdventure,
                    style: FilledButton.styleFrom(backgroundColor: const Color(0xFF168C83), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    icon: Icon(selectedIndex == currentQuestion.correctIndex && stageIndex == islandQuestions.length - 1 ? Icons.emoji_events : selectedIndex == currentQuestion.correctIndex ? Icons.arrow_back : Icons.refresh),
                    label: Text(selectedIndex == currentQuestion.correctIndex ? (stageIndex == islandQuestions.length - 1 ? 'افتح الكنز' : 'افتح الطريق إلى المحطة التالية') : 'حاول مرة أخرى', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                ),
              ],
            ] else ...[
              const SizedBox(height: 22),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(color: const Color(0xFFFFF6D9), borderRadius: BorderRadius.circular(22), border: Border.all(color: gold, width: 1.5)),
                child: const Column(
                  children: [
                    Text('🗝️ 💰 ⭐', style: TextStyle(fontSize: 42)),
                    SizedBox(height: 12),
                    Text('الكنز لك يا بطل سِراج!', textAlign: TextAlign.center, style: TextStyle(color: royalGreen, fontSize: 23, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('لقد استخدمت القراءة والتفكير لتجاوز المحطات الأربع. تذكّر: الخطأ فرصة للتعلّم، والمحاولة تقرّبك من النجاح.', textAlign: TextAlign.center, style: TextStyle(color: textColor, height: 1.9)),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: restartAdventure, style: FilledButton.styleFrom(backgroundColor: const Color(0xFF168C83), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 15)), icon: const Icon(Icons.replay_rounded), label: const Text('أعد المغامرة'))),
              const SizedBox(height: 8),
              OutlinedButton.icon(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_forward), label: const Text('العودة إلى الأنشطة')),
            ],
          ],
        ),
      ),
    );
  }
}

// ==================== التحدي التعليمي ====================

class LearningQuizPage extends StatefulWidget {
  final SirajActivity activity;

  const LearningQuizPage({
    super.key,
    required this.activity,
  });

  @override
  State<LearningQuizPage> createState() => _LearningQuizPageState();
}

class _LearningQuizPageState extends State<LearningQuizPage> {
  int questionIndex = 0;
  int score = 0;
  int? selectedIndex;
  bool answered = false;

  SirajQuestion get currentQuestion =>
      widget.activity.questions[questionIndex];

  bool get isLastQuestion =>
      questionIndex == widget.activity.questions.length - 1;

  void chooseAnswer(int index) {
    if (answered) return;

    setState(() {
      selectedIndex = index;
      answered = true;

      if (index == currentQuestion.correctIndex) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (!answered) return;

    if (isLastQuestion) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => QuizResultPage(
            activity: widget.activity,
            score: score,
          ),
        ),
      );
      return;
    }

    setState(() {
      questionIndex++;
      selectedIndex = null;
      answered = false;
    });
  }

  Color optionColor(int index) {
    if (!answered) return Colors.white;

    if (index == currentQuestion.correctIndex) {
      return const Color(0xFFE2F4E8);
    }

    if (index == selectedIndex) {
      return const Color(0xFFFFE8E5);
    }

    return Colors.white;
  }

  Color optionBorderColor(int index) {
    if (!answered) return const Color(0xFFE2DCCB);

    if (index == currentQuestion.correctIndex) {
      return const Color(0xFF39865D);
    }

    if (index == selectedIndex) {
      return Colors.redAccent;
    }

    return const Color(0xFFE2DCCB);
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        (questionIndex + 1) / widget.activity.questions.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.activity.color,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.activity.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      backgroundColor: const Color(0xFFE7E1D5),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.activity.color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${questionIndex + 1} / ${widget.activity.questions.length}',
                  style: TextStyle(
                    color: widget.activity.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.activity.color.withOpacity(0.09),
                borderRadius: BorderRadius.circular(23),
                border: Border.all(
                  color: widget.activity.color.withOpacity(0.25),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    widget.activity.emoji,
                    style: const TextStyle(fontSize: 45),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    currentQuestion.question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: royalGreen,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            for (int i = 0; i < currentQuestion.options.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Material(
                  color: optionColor(i),
                  borderRadius: BorderRadius.circular(17),
                  child: InkWell(
                    onTap: () => chooseAnswer(i),
                    borderRadius: BorderRadius.circular(17),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 17,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        border: Border.all(
                          color: optionBorderColor(i),
                          width: 1.4,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 17,
                            backgroundColor:
                                widget.activity.color.withOpacity(0.12),
                            child: Text(
                              ['أ', 'ب', 'ج'][i],
                              style: TextStyle(
                                color: widget.activity.color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              currentQuestion.options[i],
                              style: const TextStyle(
                                color: textColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (answered &&
                              i == currentQuestion.correctIndex)
                            const Icon(
                              Icons.check_circle_rounded,
                              color: Color(0xFF39865D),
                            ),
                          if (answered &&
                              i == selectedIndex &&
                              i != currentQuestion.correctIndex)
                            const Icon(
                              Icons.cancel_rounded,
                              color: Colors.redAccent,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            if (answered) ...[
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: selectedIndex == currentQuestion.correctIndex
                      ? const Color(0xFFE2F4E8)
                      : const Color(0xFFFFF0E7),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      selectedIndex == currentQuestion.correctIndex
                          ? Icons.celebration_rounded
                          : Icons.menu_book_rounded,
                      color: selectedIndex == currentQuestion.correctIndex
                          ? const Color(0xFF39865D)
                          : const Color(0xFFAD5B32),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        currentQuestion.explanation,
                        style: const TextStyle(
                          color: textColor,
                          height: 1.8,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: widget.activity.color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: nextQuestion,
                  icon: Icon(
                    isLastQuestion
                        ? Icons.emoji_events_rounded
                        : Icons.arrow_back_rounded,
                  ),
                  label: Text(
                    isLastQuestion ? 'عرض النتيجة' : 'السؤال التالي',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ==================== نتيجة التحدي ====================

class QuizResultPage extends StatelessWidget {
  final SirajActivity activity;
  final int score;

  const QuizResultPage({
    super.key,
    required this.activity,
    required this.score,
  });

  String get resultTitle {
    if (score == activity.questions.length) {
      return 'إنجاز رائع!';
    }
    if (score >= 3) {
      return 'أحسنت، واصل التقدم!';
    }
    return 'محاولة جيدة، لنجرّب مرة أخرى!';
  }

  String get resultMessage {
    if (score == activity.questions.length) {
      return 'أجبت عن جميع الأسئلة إجابة صحيحة. أنت نجم سِراج اليوم!';
    }
    if (score >= 3) {
      return 'حققت نتيجة جميلة. راجع الأسئلة التي أخطأت فيها وحاول تحسين نتيجتك.';
    }
    return 'كل محاولة تعلّم جديد. أعد التحدي، واقرأ التفسيرات بهدوء.';
  }

  @override
  Widget build(BuildContext context) {
    final total = activity.questions.length;
    final percentage = score / total;
    final stars = percentage >= 0.8
        ? '⭐⭐⭐'
        : percentage >= 0.5
            ? '⭐⭐'
            : '⭐';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: activity.color,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'نتيجتك',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Text(
                  activity.emoji,
                  style: const TextStyle(fontSize: 66),
                ),
                const SizedBox(height: 10),
                const Text(
                  'انتهى التحدي!',
                  style: TextStyle(
                    color: royalGreen,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  width: 175,
                  height: 175,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: activity.color.withOpacity(0.10),
                    border: Border.all(
                      color: activity.color,
                      width: 4,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$score / $total',
                        style: TextStyle(
                          color: activity.color,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'الإجابات الصحيحة',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  stars,
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(height: 12),
                Text(
                  resultTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: activity.color,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  resultMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 15,
                    height: 1.9,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: activity.color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              LearningQuizPage(activity: activity),
                        ),
                      );
                    },
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text(
                      'إعادة التحدي',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: royalGreen,
                      side: const BorderSide(color: royalGreen),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.popUntil(
                        context,
                        (route) =>
                            route.settings.name == '/' ||
                            route.isFirst,
                      );
                    },
                    icon: const Icon(Icons.home_rounded),
                    label: const Text('العودة إلى الصفحة الرئيسية'),
                  ),
                ),
              ],
            ),
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
                  'اختر اسم الدرس لفتح الكتاب، أو اضغط أيقونة التحضير لتحضير الدرس.',
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: 'تحضير هذا الدرس',
                            visualDensity: VisualDensity.compact,
                            constraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.edit_note_rounded,
                              color: royalGreen,
                              size: 27,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LessonPrepPage(
                                    initialLessonTitle:
                                        lesson['title'] as String,
                                    initialUnitTitle:
                                        unit['title'] as String,
                                    initialPage: lesson['page'] as int,
                                  ),
                                ),
                              );
                            },
                          ),
                          const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: gold,
                            size: 17,
                          ),
                        ],
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
