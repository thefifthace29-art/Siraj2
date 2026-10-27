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
            onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const OralWrittenActivitiesPage(),
              ),
            );
          },
          ),
          ArabicFeatureCard(
            icon: Icons.assignment_rounded,
            title: 'أوراق العمل والمذاكرات والامتحانات',
            subtitle: 'نماذج جاهزة مرتبطة بدروس الكتاب وتعمل دون إنترنت',
            color: const Color(0xFF426B55),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const WorksheetsExamsPage(),
              ),
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

// ==================== الأنشطة الشفهية والكتابية ====================

class TextbookLessonActivities {
  final String title;
  final String unit;
  final int page;
  final String theme;
  final List<String> oral;
  final List<String> written;

  const TextbookLessonActivities({
    required this.title,
    required this.unit,
    required this.page,
    required this.theme,
    required this.oral,
    required this.written,
  });
}

const List<TextbookLessonActivities> textbookActivities = [
  TextbookLessonActivities(
    title: 'اليوم الأول في المدرسة', unit: 'الوحدة الأولى: المواطنة والانتماء', page: 4,
    theme: 'الاستعداد للمدرسة، وصف الصورة، احترام المدرسة والانتماء إلى الوطن',
    oral: [
      'أتأمّل صورة الدرس وأصف المكان والأشخاص والأشياء التي أراها، مستخدمًا جملًا واضحة.',
      'أحكي لزملائي كيف أستعدّ للمدرسة، وأذكر ثلاثة أشياء أضعها في حقيبتي ولماذا أحتاج إليها.',
      'أروي أحداث صباح آلاء بترتيبها: الاستيقاظ، تجهيز الحقيبة، ثم الذهاب إلى المدرسة.',
      'أكمل شفويًا: اسم مدرستي هو…، اسم معلّمي هو…، وأكثر شيء أحبّه في مدرستي هو…',
    ],
    written: [
      'أكتب جملتين تصفان استعدادي للمدرسة في الصباح.',
      'أرتّب أحداث ذهاب آلاء إلى المدرسة وفق تسلسلها في النص، ثم أكتب رقم كل حدث.',
      'أكتب ثلاث كلمات من الدرس، ثم أذكر مفرد كل كلمة أو جمعها بحسب ما يناسب.',
      'أكتب جملة تعبّر عن حبّي لمدرستي أو لوطني، مع وضع نقطة في نهايتها.',
    ],
  ),
  TextbookLessonActivities(
    title: 'من حقي أن أتعلّم', unit: 'الوحدة الأولى: المواطنة والانتماء', page: 12,
    theme: 'حق الطفل في التعليم، الحقوق والواجبات، الحلم والمستقبل',
    oral: [
      'أصف الصورة في بداية الدرس، وأذكر ما الذي يتعلّمه الأطفال وكيف يساعدهم التعلّم.',
      'أتحدّث مع زميلي عن حقّ من حقوق الطفل، ثم أذكر واجبًا يقابله في الأسرة أو المدرسة.',
      'أكمل شفويًا: من حقّي أن…، ومن واجبي تجاه أسرتي أن…، وتجاه وطني أن…',
      'أختار مهنة أحلم بها وأشرح كيف يساعدني التعلّم على تحقيق هذا الحلم.',
    ],
    written: [
      'أكتب حقّين من حقوق الطفل وواجبين ألتزم بهما في المدرسة.',
      'أكمل جملة: أتعلم اليوم لكي…، وأكتب بعدها جملة توضّح حلمي للمستقبل.',
      'أستخرج من الدرس كلمة تدلّ على العلم، وأكتب كلمة قريبة من معناها.',
      'أكتب فقرة قصيرة من ثلاث جمل عن أهمية التعلّم في حياتي.',
    ],
  ),
  TextbookLessonActivities(
    title: 'وطني', unit: 'الوحدة الأولى: المواطنة والانتماء', page: 20,
    theme: 'حبّ الوطن، وصف المشاهد، النشيد والتعبير عن الانتماء',
    oral: [
      'أصف الصورة المجاورة للدرس، ثم أختار مشهدًا أعجبني وأتحدّث عنه أمام زملائي.',
      'أذكر ثلاث علامات تدلّ على حبّ الوطن، وأشرح كيف أعبّر عن هذا الحبّ في المدرسة.',
      'أختار مقطعًا من النشيد أعجبني وألقيه بإلقاء واضح، مع مراعاة نبرة الصوت.',
      'أتخيّل أنني أعرّف زائرًا بوطني سورية؛ أذكر مكانًا أو عادة أو صفة أعتزّ بها.',
    ],
    written: [
      'أكتب ثلاث كلمات من الدرس تعبّر عن الوطن أو الانتماء.',
      'أكتب جملتين عن عمل أستطيع القيام به للمحافظة على مدرستي ووطني.',
      'أرتّب كلمات معطاة لتكوين جملة مفيدة عن الوطن، ثم أقرأها بصوت مسموع.',
      'أكتب عبارة جميلة أوجّهها إلى وطني، وأزيّنها في دفتري.',
    ],
  ),
  TextbookLessonActivities(
    title: 'الزيتونة والريح', unit: 'الوحدة الأولى: المواطنة والانتماء', page: 27,
    theme: 'فهم الحكاية، صفات الشخصيات، الحوار واستخلاص العبرة',
    oral: [
      'أروي ما فهمته من حكاية الزيتونة والريح، وأحدّد الشخصيتين الرئيسيتين.',
      'أقارن شفويًا بين صفات الزيتونة والريح، وأذكر موقفًا من الحكاية يدعم رأيي.',
      'أمثّل مع زميلي حوارًا قصيرًا بين الزيتونة والريح، مع تغيير نبرة الصوت بحسب الشخصية.',
      'أذكر العبرة التي تعلّمتها من الحكاية، وأعطي مثالًا من حياتي يشبهها.',
    ],
    written: [
      'أكتب اسمَي الشخصيتين، ثم أذكر صفة مناسبة لكل شخصية.',
      'أكتب بداية الحكاية وحدثًا مهمًا ونهايتها في ثلاث جمل مرتّبة.',
      'أختار كلمة من الدرس وأكتب ضدّها أو مرادفها إن كنت أعرفه.',
      'أكتب نصيحة قصيرة تعلّمتها من الحكاية.',
    ],
  ),
  TextbookLessonActivities(
    title: 'هيا نسبح', unit: 'الوحدة الثانية: الرياضة والفنون', page: 36,
    theme: 'الرياضة، السلامة، الحركة والإيقاع',
    oral: [
      'أذكر فوائد السباحة أو الرياضة للجسم، وأشرح لماذا نمارسها بأمان.',
      'أصف خطوات الاستعداد للسباحة، وأذكر قاعدة سلامة لا يجوز أن أنساها.',
      'أنشد مقطعًا من النص مع زملائي، وأحافظ على الإيقاع ووضوح الكلمات.',
      'أجري حوارًا مع زميل يسألني عن رياضتي المفضّلة وفوائدها.',
    ],
    written: [
      'أكتب ثلاث كلمات مرتبطة بالرياضة أو الماء وردت في الدرس أو تناسب موضوعه.',
      'أرتّب خطوات الاستعداد لنشاط رياضي ترتيبًا منطقيًا.',
      'أكتب جملتين عن رياضتي المفضّلة، مستخدمًا فعلًا مناسبًا في كل جملة.',
      'أكتب نصيحة قصيرة لصديق عن ممارسة الرياضة بأمان.',
    ],
  ),
  TextbookLessonActivities(
    title: 'تحدّي الأذكياء', unit: 'الوحدة الثانية: الرياضة والفنون', page: 44,
    theme: 'التفكير، حلّ المشكلات، التعاون واحترام المحاولة',
    oral: [
      'أشرح لزملائي كيف أبدأ حلّ لغز: أقرأ المطلوب، وألاحظ المعطيات، ثم أجرّب حلًا.',
      'أشارك في تحدٍّ شفهي مع مجموعتي، وأذكر سبب اختياري للإجابة لا الإجابة وحدها.',
      'أصوغ لغزًا بسيطًا من عندي عن شيء في الصف، وأدع زملائي يحاولون حلّه.',
      'أصف موقفًا احتجت فيه إلى التفكير أو التعاون للوصول إلى حلّ.',
    ],
    written: [
      'أحلّ لغزًا يقدّمه المعلّم، وأكتب خطوات تفكيري بكلمات قصيرة.',
      'أرتّب ثلاث تعليمات مبعثرة لتصبح طريقة واضحة لحلّ مشكلة.',
      'أكتب سؤالًا ذكيًا من إنشائي مع إجابته، ثم أتبادل السؤال مع زميل.',
      'أكمل جملة: عندما لا أعرف الحلّ فإنني…، وأذكر طريقة مفيدة للمحاولة.',
    ],
  ),
  TextbookLessonActivities(
    title: 'عشّاق الأغاني', unit: 'الوحدة الثانية: الرياضة والفنون', page: 51,
    theme: 'الإنشاد، الإيقاع، الاستماع، التعبير الفني والعمل الجماعي',
    oral: [
      'أستمع إلى النشيد بانتباه، ثم أذكر الفكرة أو الشعور الذي وصل إليّ.',
      'أختار مقطعًا أعجبني وأنشده مع مجموعتي بصوت واضح ومنظّم.',
      'أصف الفرق بين إلقاء الكلمات بسرعة كبيرة وإلقائها بإيقاع مناسب.',
      'أتعاون مع زملائي لاختيار قائد للإنشاد وتوزيع الأدوار بين أفراد المجموعة.',
    ],
    written: [
      'أكتب عنوان النشيد، ثم أكتب كلمة أو عبارة لفتت انتباهي.',
      'أرتّب كلمات مبعثرة من اختيار المعلّم لتكوين جملة مفيدة.',
      'أكتب جملتين عن الفنّ أو الإنشاد، مع مراعاة المسافة بين الكلمات.',
      'أرسم بطاقة صغيرة لنشاط إنشادي وأكتب عليها عبارة مناسبة.',
    ],
  ),
  TextbookLessonActivities(
    title: 'العالِم الطبيب', unit: 'الوحدة الثانية: الرياضة والفنون', page: 57,
    theme: 'العلم والطب، السيرة، خدمة الناس وأهمية المعرفة',
    oral: [
      'أذكر ما تعلّمته من النص عن العالم الطبيب، وأوضّح كيف أفاد الناس بعلمه.',
      'أشرح لماذا يحتاج الطبيب إلى التعلّم والملاحظة والدقّة في عمله.',
      'أمثّل حوارًا قصيرًا بين طفل وطبيب عن المحافظة على الصحة.',
      'أذكر عالمًا أو صاحب مهنة نافعة أعرفه، وأتحدّث عن عمله باحترام.',
    ],
    written: [
      'أكتب ثلاث صفات أراها مهمّة في العالم أو الطبيب.',
      'أكتب جملتين تلخّصان فائدة العلم في خدمة المجتمع.',
      'أرتّب أحداثًا أو معلومات يختارها المعلّم من النص بحسب ورودها.',
      'أكتب سؤالًا أودّ أن أطرحه على طبيب، ثم أكتب إجابة متوقّعة مناسبة.',
    ],
  ),
  TextbookLessonActivities(
    title: 'جرة الفخّار وجرة الحديد', unit: 'الوحدة الثالثة: دنيا العلوم', page: 68,
    theme: 'الاستماع والفهم، المقارنة، خصائص المواد واستخلاص الفكرة',
    oral: [
      'أستمع إلى النص كاملًا دون مقاطعة، ثم أذكر الشخصيات أو الأشياء التي وردت فيه.',
      'أقارن بين الفخّار والحديد من حيث الصلابة أو قابلية الكسر، بحسب ما تعلّمته.',
      'أتوقّع ما قد يحدث عند اصطدام الجرتين، ثم أذكر سبب توقّعي.',
      'أعيد سرد أهم أحداث النص بترتيبها، مستخدمًا: أولًا، ثم، أخيرًا.',
    ],
    written: [
      'أملأ جدول مقارنة بسيطًا بين الفخّار والحديد من حيث صفة لكل منهما.',
      'أكتب جملة توضّح الفكرة التي فهمتها من النص المسموع.',
      'أختار عنوانًا آخر مناسبًا للنص وأكتب سبب اختياري.',
      'أكتب نصيحة مستفادة من القصة في جملة واحدة.',
    ],
  ),
  TextbookLessonActivities(
    title: 'رحلة الفضاء', unit: 'الوحدة الثالثة: دنيا العلوم', page: 71,
    theme: 'الفضاء والكواكب، الخيال العلمي، الوصف وتسلسل الأحداث',
    oral: [
      'أتخيّل أنني في رحلة إلى الفضاء، وأصف ما أتوقّع رؤيته من نافذة المركبة.',
      'أذكر سؤالين عن الفضاء أودّ معرفة إجابتهما، ثم أستمع إلى أسئلة زملائي.',
      'أعيد سرد مشاهد الرحلة بترتيبها مستخدمًا عبارات تدلّ على الزمن.',
      'أصف كوكبًا أو جرمًا فضائيًا أعرفه، وأميّزه عن الأرض بصفة واحدة.',
    ],
    written: [
      'أكتب قائمة من أربع كلمات ترتبط بالفضاء والرحلات الفضائية.',
      'أكتب ثلاث جمل تصف رحلة خيالية إلى الفضاء مع بداية وحدث ونهاية.',
      'أرتّب صورًا أو جملًا عن رحلة فضائية بحسب تسلسلها.',
      'أكتب سؤالًا علميًا عن الفضاء، ثم أبحث عن إجابته بمساعدة المعلّم أو الكتاب.',
    ],
  ),
  TextbookLessonActivities(
    title: 'متحف دمشق التربوي', unit: 'الوحدة الثالثة: دنيا العلوم', page: 78,
    theme: 'المتاحف، التعلّم بالمشاهدة، وصف المعروضات والمحافظة على التراث',
    oral: [
      'أصف ما أتوقّع مشاهدته في متحف تربوي، وأذكر كيف نتصرّف داخله.',
      'أختار معروضًا أتخيّل وجوده في المتحف وأشرح ماذا يمكن أن نتعلّم منه.',
      'أقدّم نفسي دليلًا للمتحف وأشرح لزملائي عن معروض واحد في جملتين.',
      'أتحدّث عن أهمية المحافظة على الآثار والأشياء القديمة وعدم العبث بها.',
    ],
    written: [
      'أكتب ثلاث قواعد يجب الالتزام بها عند زيارة المتحف.',
      'أكتب بطاقة تعريف قصيرة لمعروض خيالي: اسمه، ووصفه، وفائدته.',
      'أكتب فقرة قصيرة عن زيارة تعليمية أتمنى القيام بها.',
      'أختار كلمة من موضوع المتحف وأضعها في جملة مفيدة من إنشائي.',
    ],
  ),
  TextbookLessonActivities(
    title: 'هل تعلم؟', unit: 'الوحدة الثالثة: دنيا العلوم', page: 85,
    theme: 'المعلومات العامة، القراءة الاستكشافية، السؤال والجواب',
    oral: [
      'أشارك معلومة مفيدة أعرفها، وأشرح كيف أو متى تعلّمتها.',
      'أستمع إلى معلومة يقدّمها زميلي، ثم أعيد صياغتها بكلماتي.',
      'أطرح سؤالًا يبدأ بـ «هل تعلم لماذا…؟» وأدع زملائي يتوقّعون الإجابة.',
      'أميّز بين معلومة أعرفها ومعلومة أحتاج إلى التحقّق منها في الكتاب أو بمساعدة المعلّم.',
    ],
    written: [
      'أكتب معلومتين قصيرتين بصيغة «هل تعلم أن…؟» بعد التحقّق من صحتهما مع المعلّم.',
      'أكتب سؤالًا عن الطبيعة أو العلوم، وأترك سطرًا للإجابة بعد البحث.',
      'أرتّب معلومة قصيرة إلى جملتين مترابطتين مستخدمًا أداة ربط مناسبة.',
      'أصمّم بطاقة «هل تعلم؟» بعنوان ومعلومة واضحة ورسم صغير.',
    ],
  ),
];

class OralWrittenActivitiesPage extends StatelessWidget {
  const OralWrittenActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: royalGreen,
        foregroundColor: Colors.white,
        title: const Text('الأنشطة الشفهية والكتابية',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
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
                Icon(Icons.record_voice_over_rounded, color: gold, size: 42),
                SizedBox(height: 10),
                Text('نتحدّث، نفكّر، ثم نكتب',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: gold, fontSize: 22,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                  'أنشطة مرتبطة بدروس كتاب العربية لغتي للصف الثاني. اختر الدرس، ثم انتقل بين الأنشطة الشفهية والكتابية.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, height: 1.8),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Icon(Icons.menu_book_rounded, color: royalGreen),
              SizedBox(width: 8),
              Text('اختر درسًا من الكتاب', style: TextStyle(
                  color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          ...textbookActivities.map((lesson) => Card(
                color: Colors.white,
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide(color: gold.withOpacity(0.55)),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  leading: Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: royalGreen.withOpacity(0.09),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.auto_stories_rounded,
                        color: royalGreen),
                  ),
                  title: Text(lesson.title, style: const TextStyle(
                      color: royalGreen, fontWeight: FontWeight.bold)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text('${lesson.unit}\nصفحة ${lesson.page} · ${lesson.theme}',
                        style: const TextStyle(height: 1.5, fontSize: 12)),
                  ),
                  isThreeLine: true,
                  trailing: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: gold, size: 18),
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (_) => LessonActivitiesDetailPage(lesson: lesson),
                  )),
                ),
              )),
          const SizedBox(height: 8),
          const Text(
            'ملاحظة: الأنشطة مصاغة للتدريب انطلاقًا من موضوعات الدروس ومهاراتها في الكتاب، ويمكن تنفيذها شفهيًا في الصف أو كتابيًا في الدفتر.',
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor, fontSize: 12, height: 1.7),
          ),
        ],
      ),
    );
  }
}

class LessonActivitiesDetailPage extends StatefulWidget {
  final TextbookLessonActivities lesson;
  const LessonActivitiesDetailPage({super.key, required this.lesson});

  @override
  State<LessonActivitiesDetailPage> createState() =>
      _LessonActivitiesDetailPageState();
}

class _LessonActivitiesDetailPageState extends State<LessonActivitiesDetailPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final Set<String> _completed = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: royalGreen,
        foregroundColor: Colors.white,
        title: Text(lesson.title, style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: gold,
          labelColor: gold,
          unselectedLabelColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.record_voice_over_rounded), text: 'أنشطة شفهية'),
            Tab(icon: Icon(Icons.edit_note_rounded), text: 'أنشطة كتابية'),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            color: gold.withOpacity(0.13),
            child: Text(
              'الصفحة ${lesson.page} · ${lesson.theme}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: textColor, height: 1.6),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildActivities(lesson.oral, 'شفهي'),
                _buildActivities(lesson.written, 'كتابي'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivities(List<String> activities, String type) {
    final doneCount = activities
        .where((activity) => _completed.contains('$type:$activity'))
        .length;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(child: Text('أنجزت $doneCount من ${activities.length}',
                style: const TextStyle(color: royalGreen,
                    fontWeight: FontWeight.bold))),
            Text('${(doneCount / activities.length * 100).round()}%',
                style: const TextStyle(color: royalGreen,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: doneCount / activities.length,
            minHeight: 7,
            backgroundColor: gold.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(royalGreen),
          ),
        ),
        const SizedBox(height: 14),
        ...List.generate(activities.length, (index) {
          final activity = activities[index];
          final key = '$type:$activity';
          final isDone = _completed.contains(key);
          return Card(
            color: Colors.white,
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                color: isDone ? royalGreen.withOpacity(0.6) : gold.withOpacity(0.5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isDone ? royalGreen : gold.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('${index + 1}', style: TextStyle(
                        color: isDone ? Colors.white : royalGreen,
                        fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(activity, style: const TextStyle(
                            color: textColor, height: 1.7, fontSize: 14)),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: () => setState(() {
                              if (isDone) {
                                _completed.remove(key);
                              } else {
                                _completed.add(key);
                              }
                            }),
                            icon: Icon(isDone ? Icons.check_circle : Icons.circle_outlined,
                                size: 18),
                            label: Text(isDone ? 'تمّ الإنجاز' : 'وضع علامة: أُنجز'),
                            style: TextButton.styleFrom(
                              foregroundColor: royalGreen,
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
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


// تُنشأ لكل مغامرة أسئلة مستقلة مرتبطة بموضوعها، مع تنويع اللغة والرياضيات
// والعلوم والتفكير القصصي والتعاون، بدل إعادة مجموعة الأسئلة نفسها.
List<SirajQuestion> questionsForActivity(String title) {
  final List<List<String>> rows;
  switch (title) {
    case 'جزيرة الأسرار':
      rows = [
        ['وصلت إلى الشاطئ ومعك خريطة. ما الاتجاه المقابل للشرق؟','الغرب','الشمال','الجنوب','الغرب هو الاتجاه المقابل للشرق.'],
        ['تحتاج إلى عبور جدول صغير. أي شيء يساعدك على معرفة الطريق؟','الخريطة','الوسادة','الملعقة','الخريطة تساعد المسافر على معرفة الطريق.'],
        ['وجدت آثار أقدام تقود إلى كهف. ماذا تفعل أولًا؟','أتبع الآثار بحذر','أرمي الخريطة','أغلق عينيّ','المستكشف الجيد يلاحظ الدليل ويتصرف بحذر.'],
        ['على الشاطئ 6 أصداف، ثم وجدت 4 أخرى. كم صدفة لديك؟','10','8','12','6 + 4 = 10 أصداف.'],
        ['أي هذه الأشياء ينتمي إلى البحر؟','صدفة','ممحاة','مفتاح سيارة','الصدفة من الأشياء التي نجدها على الشاطئ.'],
        ['قرأت على الصخرة: «لا تدخل قبل أن تضيء المصباح». ماذا تحتاج؟','مصباح','مظلة','كرة','المصباح يساعدك على الرؤية في المكان المظلم.'],
        ['أي حيوان يعيش غالبًا في الماء؟','سمكة','قطة','حصان','السمكة تعيش في الماء.'],
        ['رأيت غيومًا داكنة ورياحًا قوية. ما التصرف الأنسب؟','أبحث عن مكان آمن','أبتعد في البحر','أترك أدواتي مبعثرة','الاستعداد للطقس يحافظ على السلامة.'],
        ['وجدت زجاجة فيها رسالة، ما أفضل طريقة لمعرفة محتواها؟','أفتحها وأقرأ الرسالة','أكسرها فورًا','أدفنها دون قراءة','قراءة الرسالة قد تكشف دليلًا جديدًا.'],
        ['أي أداة تساعدك على رؤية الأشياء البعيدة؟','منظار','فرشاة أسنان','كوب','المنظار يساعد على رؤية الأشياء البعيدة.'],
        ['في الكهف 3 ممرات، اخترت الأول ثم عدت واخترت الثاني. كم ممرًا جرّبت؟','2','1','3','جرّبت ممرين.'],
        ['وجدت لوحة تقول: «اتبع السهم الأحمر». ماذا تتبع؟','السهم الأحمر','أول صوت تسمعه','أي حجر','اتباع العلامة الصحيحة يساعد على الوصول.'],
        ['ما الشيء الذي يجب أن تأخذه معك في رحلة طويلة؟','ماء','ثلج مكشوف فقط','لعبة مكسورة','الماء ضروري للشرب أثناء الرحلات.'],
        ['رأيت طائرًا يبني عشًا على شجرة. ماذا يفعل؟','يصنع مكانًا لصغاره','يبحث عن كتاب','يبني قاربًا','الطيور تبني الأعشاش لتضع البيض وتعتني بصغارها.'],
        ['معك 12 قطعة ذهبية، دفنت 5 في صندوق صغير. كم بقي معك؟','7','6','8','12 - 5 = 7 قطع.'],
        ['أي كلمة تصف طريقًا مليئًا بالحجارة؟','وعر','ناعم جدًا','مبلل دائمًا','الطريق الوعر غير مستوٍ وسهل التعثر.'],
        ['سمعت صوتًا غريبًا قرب الأشجار. ماذا يفعل المستكشف الذكي؟','يتوقف ويتحقق بأمان','يركض مغمض العينين','يترك رفاقه','الهدوء والتحقق الآمن أفضل من التسرع.'],
        ['ما الذي يجعل النبات ينمو؟','الماء وضوء الشمس','الملح وحده','الورق البلاستيكي','تحتاج النباتات إلى الماء والضوء لتنمو.'],
        ['وجدت مفتاحًا بجانب صندوق. ما الخطوة المنطقية التالية؟','أجرّب المفتاح في القفل','أرمي المفتاح بعيدًا','أبحث عن سمكة','قد يكون المفتاح هو ما يفتح الصندوق.'],
        ['وصلت إلى الكنز ومعك 4 مفاتيح، واستخدمت مفتاحًا واحدًا. كم بقي؟','3','4','5','4 - 1 = 3 مفاتيح.'],
      ];
      break;
    case 'مدينة سِراج العجيبة':
      rows = [
        ['تعطّل جسر المدينة، أي عامل يساعد على إصلاحه؟','البنّاء','الخبّاز','الرسّام فقط','البنّاء يشارك في بناء الجسور وإصلاحها.'],
        ['تحتاج المدينة إلى مكان لعلاج المرضى. ماذا تبني؟','مستشفى','ملعبًا فقط','مخبزًا','المستشفى مكان لعلاج المرضى.'],
        ['في الحديقة 8 أشجار، زرعنا 5 أخرى. كم أصبحت؟','13','12','3','8 + 5 = 13 شجرة.'],
        ['أي إشارة تعني التوقف عند الطريق؟','إشارة قف','إشارة مطعم','إشارة حديقة','إشارة قف تنبّه السائق إلى التوقف.'],
        ['تريد إرسال رسالة إلى سكان المدينة. ما المكان المناسب؟','مكتب البريد','محطة الوقود','المسبح','مكتب البريد يساعد على إرسال الرسائل.'],
        ['انقطعت المياه عن البيوت. أي مرفق يساعد على توفيرها؟','شبكة المياه','المكتبة','المسرح','شبكة المياه تنقل الماء إلى البيوت.'],
        ['أي مبنى نذهب إليه لاستعارة الكتب؟','المكتبة','المخبز','المطار','المكتبة مكان للقراءة واستعارة الكتب.'],
        ['في الساحة 15 مقعدًا، أصلح العمال 6. كم مقعدًا أصلحوا؟','6','9','15','السؤال يطلب عدد المقاعد التي أصلحها العمال: 6.'],
        ['أي وسيلة نقل تسير على سكة حديدية؟','القطار','الدراجة','القارب','القطار يسير على السكك الحديدية.'],
        ['كيف نحافظ على نظافة شوارع المدينة؟','نضع النفايات في الحاوية','نرميها في النهر','نتركها على الرصيف','وضع النفايات في الحاوية يحافظ على النظافة.'],
        ['تريد شراء الخبز. إلى أين تذهب؟','المخبز','المكتبة','المستشفى','الخبز يُصنع ويباع في المخبز.'],
        ['أي مكان مناسب للعب كرة القدم؟','الملعب','المختبر','المطبخ','الملعب مكان مناسب للرياضة.'],
        ['إذا كان في الحافلة 10 ركاب ونزل 3، كم بقي؟','7','13','3','10 - 3 = 7 ركاب.'],
        ['ماذا تفعل عند عبور شارع مزدحم؟','أعبر من ممر المشاة بعد التأكد','أركض بين السيارات','ألعب في الطريق','ممر المشاة ومراقبة الطريق يساعدان على السلامة.'],
        ['أي شخص يطفئ الحرائق ويساعد الناس في الخطر؟','رجل الإطفاء','الخبّاز','البستاني','رجل الإطفاء يتعامل مع الحرائق.'],
        ['تحتاج المدينة إلى مكان لعرض المسرحيات. ماذا تبني؟','مسرحًا','مستودعًا','محطة قطار','المسرح مكان للعروض والتمثيل.'],
        ['ما فائدة الأشجار في المدينة؟','تمنح الظل وتنقّي الهواء','تزيد الضوضاء','تمنع المطر دائمًا','الأشجار توفر الظل وتساعد على تحسين الهواء.'],
        ['أي شكل يشبه نافذة مربعة؟','مربع','دائرة','مثلث','النافذة المربعة لها أربعة أضلاع متساوية.'],
        ['أضاءت 4 مصابيح ثم أضيفت 4. كم مصباحًا؟','8','4','12','4 + 4 = 8 مصابيح.'],
        ['كيف تصبح المدينة أجمل للجميع؟','نتعاون ونحافظ على مرافقها','نكسر المقاعد','نكتب على الجدران','التعاون والمحافظة على المرافق يفيدان جميع السكان.'],
      ];
      break;
    case 'وكالة المحققين الصغار':
      rows = [
        ['اختفت تفاحة من السلة. رأى شاهد قشرًا قرب الطاولة. ما الذي نفعله؟','نفحص الدليل قبل الحكم','نتهم أول شخص','نتجاهل الجميع','المحقق يجمع الأدلة ولا يتسرع في اتهام أحد.'],
        ['أثر حذاء صغير يقود إلى الحديقة. ماذا يخبرنا الأثر؟','أن شخصًا مرّ من المكان','أن المطر توقف','أن الباب مغلق','الأثر دليل على مرور شخص لكنه لا يكفي وحده لتحديده.'],
        ['وجدت بطاقة عليها رقم 2 ثم رقم 4 ثم رقم 6. ما الرقم التالي؟','8','7','9','النمط يزيد بمقدار 2 كل مرة.'],
        ['ثلاثة أطفال: ليلى أطول من سامر، وسامر أطول من فادي. من الأقصر؟','فادي','ليلى','سامر','بما أن فادي أقصر من سامر وليلى فهو الأقصر.'],
        ['وجد المحقق رسالة ممزقة. ما أفضل خطوة؟','يجمع القطع ويرتبها','يمزقها أكثر','يخفيها','ترتيب القطع قد يساعد على قراءة الرسالة.'],
        ['أي دليل يمكن أن يثبت وقت دخول شخص إلى المكتبة؟','سجل الدخول','لون الحقيبة فقط','حجم الكتاب','سجل الدخول يحتوي على معلومات عن وقت الدخول.'],
        ['سمعت روايتين مختلفتين عن الحادثة. ماذا تفعل؟','أتحقق من الأدلة وأسأل بهدوء','أختار الرواية الأعلى صوتًا','أخترع رواية ثالثة','التحقق والمقارنة يساعدان على معرفة ما حدث.'],
        ['كان المفتاح في الدرج، والدرج مغلق. ما الشيء الذي نبحث عنه؟','مفتاح الدرج','قلم تلوين','كرة','نبحث عن الشيء الذي يفتح الدرج.'],
        ['أي شيء لا ينتمي إلى مجموعة أدوات الكتابة؟','ملعقة','قلم','ممحاة','الملعقة ليست أداة كتابة.'],
        ['إذا حدثت الواقعة بعد الفسحة وقبل الانصراف، متى حدثت؟','بعد الفسحة وقبل الانصراف','قبل بداية اليوم','في منتصف الليل','المعلومة تحدد زمن الواقعة بين الفسحة والانصراف.'],
        ['وجدت آثار ماء من النافذة إلى النبتة. ما الاحتمال الأقرب؟','سُقيت النبتة أو انسكب الماء قربها','طار كرسي','احترق كتاب','آثار الماء قد تشير إلى سقي النبتة أو انسكاب الماء.'],
        ['ما السؤال الذي يساعد على جمع المعلومات؟','ماذا حدث بعد ذلك؟','هل أنت غاضب؟ فقط','لماذا لا تتكلم؟','السؤال المفتوح يشجع الشاهد على شرح الأحداث.'],
        ['أي ترتيب منطقي للتحقيق؟','ملاحظة ثم جمع أدلة ثم استنتاج','استنتاج ثم تخمين ثم اتهام','اتهام ثم إخفاء الدليل','يجب جمع الأدلة قبل الوصول إلى الاستنتاج.'],
        ['في صندوق 3 كرات حمراء و2 زرقاء. كم كرة فيه؟','5','6','4','3 + 2 = 5 كرات.'],
        ['وجدت بصمة قرب الباب، ماذا تعني وحدها؟','أن شخصًا لمس المكان غالبًا','أن الشخص سرق بالتأكيد','أن الباب جديد','البصمة دليل يحتاج إلى فحص ولا تثبت الجريمة وحدها.'],
        ['أي صفة يحتاجها المحقق؟','الدقة والانتباه','التسرع','إخفاء المعلومات','الدقة والانتباه يساعدان على ملاحظة التفاصيل.'],
        ['إذا كان الدليل لا يوافق تخمينك، ماذا تفعل؟','أراجع تخميني','أغيّر الدليل','أتجاهل الحقيقة','يجب أن تتبع الأدلة لا التخمينات.'],
        ['ما الذي يأتي بعد الصباح وقبل المساء؟','الظهر','منتصف الليل','الفجر','الظهر يأتي بعد الصباح وقبل المساء.'],
        ['لاحظت أن النافذة مغلقة والباب مفتوح. ما الذي يمكنك قوله؟','الباب مفتوح والنافذة مغلقة','اللص دخل من النافذة بالتأكيد','لا توجد أي معلومة','نذكر ما نراه فعلًا دون إضافة تخمين.'],
        ['حللت اللغز مع فريقك. كيف تكتب النتيجة؟','أذكر الدليل وكيف قادني إلى النتيجة','أكتب اسم شخص بلا دليل','أخفي الخطوات','شرح الدليل يجعل الاستنتاج واضحًا.'],
      ];
      break;
    default:
      rows = _questionsForTheme(title);
      break;
  }
  return List<SirajQuestion>.generate(rows.length, (i) {
    final row = rows[i];
    final correct = row[1];
    final wrongA = row[2];
    final wrongB = row[3];
    final options = i % 3 == 0
        ? [correct, wrongA, wrongB]
        : i % 3 == 1
            ? [wrongA, correct, wrongB]
            : [wrongA, wrongB, correct];
    return SirajQuestion(
      question: row[0],
      options: options,
      correctIndex: options.indexOf(correct),
      explanation: row[4],
    );
  });
}

List<List<String>> _questionsForTheme(String title) {
  // مجموعات موضوعية للأنشطة الأخرى؛ تُصاغ الأسئلة داخل سياق كل لعبة.
  final Map<String, List<List<String>>> banks = {
    'مهمة لا ينجح فيها أحد وحده': [
      ['لدى فريقك 12 قطعة بناء، وزّعوها بالتساوي على 3 أطفال. كم قطعة لكل طفل؟','4','3','6','12 ÷ 3 = 4 قطع لكل طفل.'],
      ['اختلف صديقان في اختيار الحل. ما أفضل تصرف؟','يستمع كل منهما للآخر','يصرخ أحدهما','يتوقف الفريق عن العمل','الاستماع وتبادل الآراء يساعدان على حل الخلاف.'],
      ['ما معنى أن نتقاسم الأدوات؟','يستخدمها الجميع بالتناوب','يحتفظ بها طفل واحد','نخفيها','التقاسم يتيح للجميع المشاركة.'],
      ['نسي أحد أعضاء الفريق دوره. ماذا تفعلون؟','نذكّره بلطف ونساعده','نسخر منه','نستبعده فورًا','التذكير اللطيف يحافظ على روح الفريق.'],
      ['ما الذي يجعل خطة الفريق أوضح؟','تحديد الأدوار','أن يعمل الجميع بلا اتفاق','تغيير الخطة كل دقيقة','تحديد الأدوار يساعد على تنظيم العمل.'],
    ],
    'مسرح الحكايات الحية': [
      ['في بداية القصة، خرجت سلمى إلى الحديقة. ما الحدث الذي يناسب بعدها؟','وجدت عصفورًا يحتاج إلى المساعدة','عادت قبل أن تخرج','انتهت القصة قبل أن تبدأ','حدث جديد في الحديقة يتابع بداية القصة.'],
      ['من يؤدي دور الشخصية أمام الجمهور؟','الممثل','المشاهد فقط','كاتب التذاكر','الممثل يجسّد الشخصية على المسرح.'],
      ['أي جملة تدل على الحوار؟','قالت ليلى: هل أساعدك؟','كانت السماء زرقاء','في الصندوق لعبة','الحوار يتضمن كلام الشخصيات.'],
      ['ما الجزء الذي يعرّفنا بالشخصيات والمكان؟','بداية القصة','العنوان وحده دائمًا','النهاية فقط','تقدم البداية الشخصيات والمكان غالبًا.'],
      ['كيف تُظهر شخصية خائفة أثناء التمثيل؟','بتعبير الوجه والصوت المناسب','بالضحك طوال الوقت','بالوقوف وظهرها للجمهور دائمًا','التعبير والصوت يساعدان على إظهار المشاعر.'],
    ],
    'مخترعو المستحيل': [
      ['تريد صنع مظلة صغيرة للعبة. ما المادة التي لا تسمح بمرور الماء بسهولة؟','البلاستيك المقاوم للماء','الورق الرقيق','القطن الجاف فقط','المادة المقاومة للماء تساعد على صنع مظلة.'],
      ['ما الخطوة الأولى المفيدة قبل صنع اختراع؟','تحديد المشكلة','رمي الأدوات','إخفاء الفكرة','تحديد المشكلة يوضح ما الذي نريد حله.'],
      ['أي أداة تساعد على تثبيت ورقتين؟','مشبك','ملعقة','كوب ماء','المشبك يثبت الورق معًا.'],
      ['لماذا نجرّب النموذج بعد صنعه؟','لنعرف ما الذي يعمل وما الذي يحتاج تعديلًا','لنتوقف عن التفكير','لنتجنب التعلم','التجربة تكشف نقاط القوة وما يحتاج إلى تحسين.'],
      ['أي فكرة تساعد على توفير الماء؟','إصلاح الصنبور المتسرب','ترك الماء جاريًا','ملء الشارع بالماء','إصلاح التسرب يمنع هدر الماء.'],
    ],
    'كرنفال سِراج': [
      ['ما ناتج 7 + 6؟','13','12','14','7 + 6 = 13.'],
      ['أي كوكب نعيش عليه؟','الأرض','المريخ','زحل','الأرض هي كوكبنا.'],
      ['ما العضو الذي نستخدمه للشم؟','الأنف','الأذن','الركبة','الأنف يساعدنا على الشم.'],
      ['أي فصل يأتي بعد الشتاء؟','الربيع','الخريف','الصيف مباشرةً قبل الربيع','يأتي الربيع بعد الشتاء.'],
      ['أي مادة تجذبها المغناطيسات غالبًا؟','الحديد','الخشب','الورق','المغناطيس يجذب الحديد.'],
    ],
    'صندوق المفاجآت': [
      ['فتحت الصندوق فوجدت شيئًا يقيس الوقت. ما هو؟','ساعة','ملعقة','وسادة','الساعة أداة لقياس الوقت.'],
      ['أي حاسة نستخدمها لسماع الجرس؟','السمع','البصر','اللمس','نسمع الجرس بالأذن.'],
      ['ما ناتج 9 - 4؟','5','4','6','9 - 4 = 5.'],
      ['أي شيء يطفو غالبًا على الماء؟','قطعة خشب','حجر ثقيل','مفتاح حديدي كبير','الخشب يطفو غالبًا على الماء.'],
      ['ما الذي نفعله قبل تناول الطعام؟','نغسل أيدينا','نلمس القمامة','نترك الطعام مكشوفًا','غسل اليدين يساعد على النظافة.'],
    ],
    'الرسائل السرية': [
      ['في شفرتك، كل رمز ⭐ يعني حرف الألف. ماذا تفعل أولًا؟','أستبدل ⭐ بالألف','أحذف كل الكلمات','أغيّر معنى الرسالة','نستبدل الرمز بالحرف المتفق عليه لفك الشفرة.'],
      ['إذا كانت الرسالة تقول «افتح الصندوق»، فما الفعل المطلوب؟','افتح','اكتب','اقفز','الفعل «افتح» يوضح المطلوب فعله.'],
      ['رتّب الحروف: ب، ا، ب. ما الكلمة؟','باب','بابا','بب','ترتيب الحروف يعطي كلمة «باب».'],
      ['أي رمز يمكن أن يدل على كلمة «شمس» في شفرة متفق عليها؟','☀️','🎒','🥄','يمكن الاتفاق على استخدام رمز الشمس للدلالة على كلمة شمس.'],
      ['وصلتك رسالة غير واضحة. ما أفضل طريقة؟','أستخدم مفتاح الشفرة','أخمن دون قراءة','أمزق الورقة','مفتاح الشفرة يساعد على فهم الرسالة.'],
    ],
    'بناء المدن': [
      ['تحتاج إلى بناء ساحة مربعة. كم ضلعًا للمربع؟','4','3','5','للمربع أربعة أضلاع.'],
      ['لديك 20 حجرًا واستخدمت 8. كم حجرًا بقي؟','12','28','8','20 - 8 = 12 حجرًا.'],
      ['أي مادة أقوى لبناء جدار ثابت؟','الطوب','ورقة رقيقة','منديل','الطوب مناسب لبناء الجدران.'],
      ['ما الشكل الذي له ثلاثة أضلاع؟','مثلث','مربع','دائرة','للمثلث ثلاثة أضلاع.'],
      ['لماذا نترك مساحة خضراء بين المباني؟','للنباتات والراحة واللعب','لإغلاق الطرق','لمنع الناس من الخروج','المساحات الخضراء مفيدة للبيئة والسكان.'],
    ],
    'مصنع الحكايات المضحكة': [
      ['في القصة، لبس القط حذاءً كبيرًا فتعثر. ما الحدث الطريف التالي؟','طار الحذاء إلى سلة الغسيل','تحول القط إلى شجرة حقيقية','اختفى القمر للأبد','الحدث الطريف يتابع الموقف بطريقة خيالية.'],
      ['أي كلمة تصف مهرجًا يجعل الناس يضحكون؟','مضحك','حزين دائمًا','صامت لا يتحرك','مضحك تعني أنه يثير الضحك.'],
      ['ما الذي تحتاجه الحكاية لتصبح مفهومة؟','أحداث مترابطة','كلمات بلا ترتيب','شخصيات بلا أي فعل','ترابط الأحداث يساعد على فهم الحكاية.'],
      ['أي نهاية مناسبة لقصة عن صديقين تصالحا؟','عادا للعب معًا','تشاجرا أكثر بلا سبب','نسي كل منهما اسمه','التصالح يقود إلى نهاية سعيدة ومنطقية.'],
      ['أي عبارة تدل على الخيال؟','ركبت السمكة دراجة إلى المدرسة','شرب الطفل الماء','فتحت المعلمة الكتاب','السمكة التي تركب دراجة فكرة خيالية مضحكة.'],
    ],
    'تحديات الفرق': [
      ['فريقك جمع 9 نقاط وفريق آخر جمع 7. كم نقطة أكثر لديكم؟','2','1','3','9 - 7 = 2 نقطتين.'],
      ['كيف يكون الفوز في مسابقة عادلة؟','نلتزم بالقواعد ونحترم الجميع','نخفي أدوات الفريق الآخر','نغيّر النتيجة','الالتزام بالقواعد واحترام المنافسين أساس اللعب العادل.'],
      ['من الأفضل أن يجيب عن السؤال؟','العضو الذي اتفق الفريق على دوره','الشخص نفسه دائمًا','لا أحد','توزيع الأدوار يتيح للجميع المشاركة.'],
      ['خسر فريقك جولة. ماذا تفعل؟','نتعلم ونحاول من جديد','نغضب من زملائنا','نترك الأدوات مبعثرة','الخسارة فرصة للتعلم والمحاولة مجددًا.'],
      ['لدى الفريق 4 بطاقات لكل لاعب و3 لاعبين. كم بطاقة يحتاج؟','12','7','9','4 × 3 = 12 بطاقة.'],
    ],
    'النهايات المتعددة': [
      ['وجدت مريم عصفورًا صغيرًا على الأرض. أي نهاية تُظهر الرحمة؟','تطلب مساعدة شخص بالغ للعناية به','تؤذيه للضحك','تتركه في خطر دون تفكير','طلب المساعدة طريقة رحيمة وآمنة.'],
      ['تأخر سامر عن موعده لأنه ساعد جاره. ما نهاية ممكنة؟','يشكره جاره ويعتذر سامر عن التأخر','يطير البيت إلى القمر','يتحول الباب إلى سمكة','هذه نهاية ممكنة ومنطقية للقصة.'],
      ['إذا اختار البطل أن يقول الحقيقة، ماذا قد يحدث؟','يثق به الآخرون','يختفي كل الناس فورًا','يتوقف الزمن','الصدق يساعد على بناء الثقة.'],
      ['أي نهاية تناسب قصة عن بذرة سُقيت كل يوم؟','تنمو نبتة صغيرة','تصبح البذرة كتابًا فورًا','تتحول إلى سيارة','الماء والرعاية يساعدان البذرة على النمو.'],
      ['لماذا يمكن أن تكون للقصة أكثر من نهاية؟','لأن قرارات الشخصيات قد تغيّر الأحداث','لأن الكلمات لا معنى لها','لأن البداية يجب حذفها','تغيّر القرارات يؤدي إلى مسارات ونهايات مختلفة.'],
    ],
  };
  final selected = banks[title] ?? <List<String>>[];
  final base = <List<String>>[
    ['ما ناتج 5 + 4؟','9','8','10','5 + 4 = 9.'],
    ['أي عضو نستخدمه للرؤية؟','العين','الأذن','الأنف','نرى الأشياء بالعين.'],
    ['أي كوكب نعيش عليه؟','الأرض','المريخ','زحل','نعيش على كوكب الأرض.'],
    ['أي تصرف يحافظ على البيئة؟','زراعة شجرة','رمي النفايات في النهر','كسر الأغصان','زراعة الأشجار تساعد البيئة.'],
    ['ما ناتج 10 - 3؟','7','6','8','10 - 3 = 7.'],
    ['أي حيوان يُسمّى ملك الغابة في القصص؟','الأسد','الأرنب','السمكة','يُعرف الأسد بهذا اللقب في القصص الشائعة.'],
    ['أي أداة نستخدمها لقص الورق؟','المقص','الملعقة','الكوب','المقص مخصص لقص الورق.'],
    ['متى نرى النجوم بوضوح غالبًا؟','ليلًا','وقت الظهيرة','داخل خزانة مغلقة','تظهر النجوم غالبًا في الليل.'],
    ['ما ناتج 3 + 6؟','9','8','10','3 + 6 = 9.'],
    ['أي مادة نحتاجها للشرب؟','الماء','الرمل','الزيت المستخدم في المحرك','الماء ضروري للجسم.'],
    ['أي فصل يكون الجو فيه حارًا غالبًا؟','الصيف','الشتاء','الخريف دائمًا','الصيف غالبًا أكثر الفصول حرارة.'],
    ['ما الذي يساعدنا على معرفة الوقت؟','الساعة','الوسادة','الطبق','الساعة تبين الوقت.'],
    ['أي شكل له أربعة أضلاع متساوية وزوايا قائمة؟','المربع','الدائرة','المثلث','المربع له أربعة أضلاع متساوية وزوايا قائمة.'],
    ['أي حاسة نستخدمها لتذوق الطعام؟','التذوق','السمع','البصر','نتذوق الطعام باللسان.'],
    ['ما ناتج 8 + 2؟','10','9','11','8 + 2 = 10.'],
  ];
  final result = List<List<String>>.from(selected);
  while (result.length < 20) {
    final row = base[(result.length - selected.length) % base.length];
    result.add(row);
  }
  // صياغة السياق في كل سؤال حتى يبقى مرتبطًا بمهمة اللعبة المختارة.
  return result.take(20).map((r) => <String>['في مغامرة «$title»: ${r[0]}', ...r.skip(1)]).toList();
}

class PlayAndLearnPage extends StatelessWidget {
  const PlayAndLearnPage({super.key});

  static final List<SirajActivity> activities = [
    SirajActivity(
      title: 'جزيرة الأسرار',
      subtitle: 'رحلة للبحث عن الكنز',
      description:
          'انطلق في مغامرة بين الجزر، وافتح الطريق إلى الكنز بحل الألغاز اللغوية والإجابة عن الأسئلة.',
      emoji: '🏝️',
      color: Color(0xFF168C83),
      skill: 'الفهم والمفردات',
      questions: questionsForActivity('جزيرة الأسرار'),
    ),
    SirajActivity(
      title: 'مدينة سِراج العجيبة',
      subtitle: 'ابنِ مدينة بالكلمات الصحيحة',
      description:
          'ساعد سكان المدينة على إكمال الكلمات والجمل، واجمع النجوم لتفتح أماكن جديدة.',
      emoji: '🏰',
      color: Color(0xFF5576C5),
      skill: 'القراءة وبناء الجمل',
      questions: questionsForActivity('مدينة سِراج العجيبة'),
    ),
    SirajActivity(
      title: 'وكالة المحققين الصغار',
      subtitle: 'حلّ اللغز واكتشف الدليل',
      description:
          'أنت محقق صغير! ابحث عن الكلمة الصحيحة، وقارن الأدلة، واكتشف الإجابة التي تحل اللغز.',
      emoji: '🔎',
      color: Color(0xFF8A6A22),
      skill: 'الملاحظة والاستنتاج',
      questions: questionsForActivity('وكالة المحققين الصغار'),
    ),
    SirajActivity(
      title: 'مهمة لا ينجح فيها أحد وحده',
      subtitle: 'التعاون سر النجاح',
      description:
          'تحتاج هذه المهمة إلى تبادل الأفكار ومساعدة الآخرين. ناقشوا الإجابات معًا قبل اختيارها.',
      emoji: '🤝',
      color: Color(0xFF39865D),
      skill: 'التعاون والتواصل',
      questions: questionsForActivity('مهمة لا ينجح فيها أحد وحده'),
    ),
    SirajActivity(
      title: 'مسرح الحكايات الحية',
      subtitle: 'رتّب الأحداث واكتشف القصة',
      description:
          'تعرّف إلى شخصيات الحكاية، وفكّر في بداية القصة وأحداثها ونهايتها، ثم أجب عن التحديات.',
      emoji: '🎭',
      color: Color(0xFFAD5B7A),
      skill: 'التعبير وفهم النص',
      questions: questionsForActivity('مسرح الحكايات الحية'),
    ),
    SirajActivity(
      title: 'مخترعو المستحيل',
      subtitle: 'أفكار ذكية وأسئلة ممتعة',
      description:
          'استخدم خيالك، واختر الكلمات المناسبة، واكتشف كيف يمكن لفكرة صغيرة أن تتحول إلى اختراع.',
      emoji: '💡',
      color: Color(0xFFD18B27),
      skill: 'التفكير الإبداعي',
      questions: questionsForActivity('مخترعو المستحيل'),
    ),
    SirajActivity(
      title: 'كرنفال سِراج',
      subtitle: 'ألعاب لغوية متنوعة',
      description:
          'ادخل عالم الألعاب القصيرة، واختبر معرفتك بالحروف والكلمات والمعاني بطريقة مرحة.',
      emoji: '🎪',
      color: Color(0xFF9A5BC1),
      skill: 'المراجعة العامة',
      questions: questionsForActivity('كرنفال سِراج'),
    ),
    SirajActivity(
      title: 'صندوق المفاجآت',
      subtitle: 'افتح الصندوق بالسؤال الصحيح',
      description:
          'كل إجابة صحيحة تقرّبك من فتح الصندوق. اقرأ السؤال بهدوء واختر إجابتك.',
      emoji: '🎁',
      color: Color(0xFFD15C49),
      skill: 'المفردات والتمييز',
      questions: questionsForActivity('صندوق المفاجآت'),
    ),
    SirajActivity(
      title: 'الرسائل السرية',
      subtitle: 'اكتشف الكلمة المخفية',
      description:
          'افكك الشفرات البسيطة، وانتبه إلى الحروف والكلمات لتصل إلى الرسالة المخفية.',
      emoji: '✉️',
      color: Color(0xFF467E9D),
      skill: 'تمييز الحروف والكلمات',
      questions: questionsForActivity('الرسائل السرية'),
    ),
    SirajActivity(
      title: 'بناء المدن',
      subtitle: 'كل إجابة تبني جزءًا جديدًا',
      description:
          'أجب عن الأسئلة لتضيف مباني جديدة إلى مدينتك، وتعلّم كيف تصنع الكلمات عالمًا متكاملًا.',
      emoji: '🏗️',
      color: Color(0xFF9B7942),
      skill: 'القراءة والمفردات',
      questions: questionsForActivity('بناء المدن'),
    ),
    SirajActivity(
      title: 'مصنع الحكايات المضحكة',
      subtitle: 'كلمات تصنع حكاية طريفة',
      description:
          'اختر الإجابات، وتخيّل كيف تتكوّن الحكايات من كلمات وشخصيات وأحداث غير متوقعة.',
      emoji: '🤹',
      color: Color(0xFFDB7B37),
      skill: 'اللغة والخيال',
      questions: questionsForActivity('مصنع الحكايات المضحكة'),
    ),
    SirajActivity(
      title: 'تحديات الفرق',
      subtitle: 'تحدّوا بعضكم بروح رياضية',
      description:
          'يمكن للمعلم تقسيم الطلاب إلى فرق، وقراءة السؤال للجميع، ثم مناقشة الإجابات والتعلّم من الأخطاء.',
      emoji: '🏆',
      color: Color(0xFF357C68),
      skill: 'التعاون والمراجعة',
      questions: questionsForActivity('تحديات الفرق'),
    ),
    SirajActivity(
      title: 'النهايات المتعددة',
      subtitle: 'اختر، وفكّر، واكتشف',
      description:
          'تخيّل أكثر من نهاية للقصة، ثم اختبر فهمك للكلمات والجمل من خلال مجموعة من الأسئلة.',
      emoji: '🌈',
      color: Color(0xFF7868B5),
      skill: 'الفهم والتفكير',
      questions: questionsForActivity('النهايات المتعددة'),
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
                        ? 'ستعبر 20 محطة في رحلة البحث عن الكنز: اتبع الخريطة، وافحص الآثار، وحل مسائل صغيرة، وتعلّم عن الطبيعة، واجمع الأدلة حتى تصل إلى الكنز.'
                        : 'أمامك ${activity.questions.length} مهمة في مغامرة «${activity.title}». اقرأ كل موقف، واختر الحل، وتعلّم من التفسير الذي يظهر بعد إجابتك.',
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

  static final List<SirajQuestion> islandQuestions = questionsForActivity('جزيرة الأسرار');

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
                        ? 'أتممت مراحل الجزيرة وجمعت الأدلة. نتيجتك $score من ${islandQuestions.length}.'
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
                  Wrap(
                    alignment: WrapAlignment.spaceAround,
                    spacing: 8,
                    runSpacing: 10,
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
                          Text(['الشاطئ', 'الخريطة', 'الممر', 'الجدول', 'الصدفة', 'المصباح', 'البحيرة', 'الطقس', 'الرسالة', 'المنظار', 'الكهف', 'السهم', 'الماء', 'العش', 'الصندوق', 'الطريق', 'الصوت', 'النبتة', 'المفتاح', 'الكنز'][i], style: const TextStyle(fontSize: 9, color: textColor, fontWeight: FontWeight.w600)),
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
                    Text(['🌊', '🗺️', '👣', '💧', '🐚', '🔦', '🐟', '🌧️', '✉️', '🔭', '🕳️', '➡️', '🚰', '🪺', '🪙', '🪨', '👂', '🌱', '🗝️', '💎'][stageIndex], style: const TextStyle(fontSize: 42)),
                    const SizedBox(height: 10),
                    Text('المحطة ${stageIndex + 1} من ${islandQuestions.length}', textAlign: TextAlign.center, style: const TextStyle(color: royalGreen, fontSize: 19, fontWeight: FontWeight.bold)),
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
                    Text('لقد استخدمت الملاحظة والقراءة والحساب والتفكير لتجاوز المحطات العشرين. تذكّر: الخطأ فرصة للتعلّم، والمحاولة تقرّبك من النجاح.', textAlign: TextAlign.center, style: TextStyle(color: textColor, height: 1.9)),
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
       
