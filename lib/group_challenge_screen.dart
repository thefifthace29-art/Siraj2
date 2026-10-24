import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

// ألوان التطبيق الرئيسية
const Color royalGreen = Color(0xFF0A4D2E);
const Color gold = Color(0xFFD4AF37);
const Color textColor = Color(0xFF2C3E50);

// نموذج بيانات فريق الصف
class ClassGroup {
  String name;
  int score;
  Color color;

  ClassGroup({
    required this.name,
    this.score = 0,
    required this.color,
  });
}

// نموذج باب القصر التنافسي
class CastleDoor {
  final int id;
  final String title;
  final String skill;
  final IconData icon;
  final List<SirajQuestion> questions;
  bool isUnlocked;

  CastleDoor({
    required this.id,
    required this.title,
    required this.skill,
    required this.icon,
    required this.questions,
    this.isUnlocked = false,
  });
}

// بنك أسئلة الأبواب الصفية لدروس العربية لغتي - الصف الثاني
final List<CastleDoor> initialCastleDoors = [
  CastleDoor(
    id: 1,
    title: 'باب الحروف والكلمات',
    skill: 'الإملاء والتمييز البصري',
    icon: Icons.spellcheck_rounded,
    questions: const [
      SirajQuestion(
        question: 'أي كلمة تبدأ بحرف الشين ومضبوطة بالشكل الصحيح؟',
        options: ['شَجَرَة', 'زَهْرَة', 'قَمَر'],
        correctIndex: 0,
        explanation: 'ممتاز! كلمة «شَجَرَة» تبدأ بحرف الشين المفتوح.',
      ),
      SirajQuestion(
        question: 'اختر الكلمة التي تنتهي بتاء مربوطة (ة):',
        options: ['بَيْت', 'مَدْرَسَة', 'كِتاب'],
        correctIndex: 1,
        explanation: 'أحسنت! «مَدْرَسَة» تنتهي بتاء مربوطة تُنطق هاءً عند الوقوف.',
      ),
    ],
  ),
  CastleDoor(
    id: 2,
    title: 'باب القواعد المبسطة',
    skill: 'تركيب الجمل وأقسام الكلام',
    icon: Icons.architecture_rounded,
    questions: const [
      SirajQuestion(
        question: 'ما نوع الكلمة «يَقْرَأُ» في جملة (يَقْرَأُ الطّالِبُ)؟',
        options: ['اِسْم', 'فِعْل', 'حَرْف'],
        correctIndex: 1,
        explanation: 'رائع! «يَقْرَأُ» فعل يدل على حدث يتم في الزمن الحاضر.',
      ),
      SirajQuestion(
        question: 'أي جملة تعبر عن اسم مجرور بـ (في)؟',
        options: ['ذَهَبَ إلى المَدْرَسَةِ', 'الكِتابُ في الحَقيبَةِ', 'قَلَمُ أَحْمَدَ'],
        correctIndex: 1,
        explanation: 'صحيح! الكلمة بعد «في» تكون اسمًا مجرورًا.',
      ),
    ],
  ),
  CastleDoor(
    id: 3,
    title: 'باب المفردات والمعاني',
    skill: 'الترادف والأضداد',
    icon: Icons.menu_book_rounded,
    questions: const [
      SirajQuestion(
        question: 'ما مرادف كلمة «الوَطَن»؟',
        options: ['المَلْعَب', 'الديار والأرض', 'السَّفَر'],
        correctIndex: 1,
        explanation: 'أحسنت! الوطن هو الأرض والديار التي ننتمي إليها.',
      ),
      SirajQuestion(
        question: 'ما ضد كلمة «تَعاوُن»؟',
        options: ['مُساعَدَة', 'تَخالُف وأنانيّة', 'إِخاء'],
        correctIndex: 1,
        explanation: 'صحيح! التعاون ضده الأنانيّة والتخالف.',
      ),
    ],
  ),
  CastleDoor(
    id: 4,
    title: 'باب الفهم والاستنتاج',
    skill: 'الفهم القرائي والقيم',
    icon: Icons.psychology_rounded,
    questions: const [
      SirajQuestion(
        question: 'ماذا نفعل عندما يدخل المعلم إلى الصف؟',
        options: ['نَقِفُ ونُحَيّيهِ بِاحْتِرام', 'نَتَكَلَّمُ مَعَ زُمَلائِنا', 'نَخْرُجُ مِنَ الصَّفّ'],
        correctIndex: 0,
        explanation: 'بارك الله فيكم! احترام المعلم وتقديره من أخلاق الطالب الذكي.',
      ),
    ],
  ),
];
class GroupChallengeScreen extends StatefulWidget {
  const GroupChallengeScreen({super.key});

  @override
  State<GroupChallengeScreen> createState() => _GroupChallengeScreenState();
}

class _GroupChallengeScreenState extends State<GroupChallengeScreen> {
  // قائمة فرق الفصل
  final List<ClassGroup> groups = [
    ClassGroup(name: 'فرسان المعرفة', color: const Color(0xFF168C83)),
    ClassGroup(name: 'أبطال سِراج', color: const Color(0xFF5576C5)),
    ClassGroup(name: 'روّاد الأندلس', color: const Color(0xFF8A6A22)),
  ];

  int activeGroupIndex = 0;
  late List<CastleDoor> doors;

  @override
  void initState() {
    super.initState();
    doors = List.from(initialCastleDoors);
  }

  void addScoreToCurrentGroup(int points) {
    setState(() {
      groups[activeGroupIndex].score += points;
      // الانتقال التلقائي للفريق التالي لإعطاء فرصة للجميع
      activeGroupIndex = (activeGroupIndex + 1) % groups.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: royalGreen,
        foregroundColor: Colors.white,
        title: const Text('تحدي القصر - مسابقة المجموعات'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 1. شاشة لوحة نتيحة الفرق الصفية
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: gold, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    '🏆 لائحة صدارة المجموعات',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: royalGreen,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(groups.length, (index) {
                      final group = groups[index];
                      final isActive = index == activeGroupIndex;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: group.color.withOpacity(isActive ? 0.2 : 0.08),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: isActive ? group.color : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              group.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: group.color,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${group.score} نقطة',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // إرشاد المعلم
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9E8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: gold.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.record_voice_over_rounded, color: royalGreen),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'الدور الآن على: «${groups[activeGroupIndex].name}» • اختر باباً لطرح السؤال على الفريق.',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: royalGreen,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 2. أبواب القصر
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemCount: doors.length,
              itemBuilder: (context, index) {
                final door = doors[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(
                      color: door.isUnlocked ? Colors.green : gold,
                      width: 1.5,
                    ),
                  ),
                  child: InkWell(
                    onTap: () => _openDoorQuestionDialog(context, door),
                    borderRadius: BorderRadius.circular(18),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            door.isUnlocked
                                ? Icons.lock_open_rounded
                                : Icons.lock_rounded,
                            size: 38,
                            color: door.isUnlocked ? Colors.green : royalGreen,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            door.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: royalGreen,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            door.skill,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF6B746D),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // نافذة السؤال للمعلم
  void _openDoorQuestionDialog(BuildContext context, CastleDoor door) {
    if (door.questions.isEmpty) return;
    final q = door.questions.first;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(door.icon, color: royalGreen),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                door.title,
                style: const TextStyle(fontSize: 16, color: royalGreen),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'السؤال لمجموعة: (${groups[activeGroupIndex].name})',
              style: TextStyle(
                color: groups[activeGroupIndex].color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 20),
            Text(
              q.question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(q.options.length, (i) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F2EB),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${['أ', 'ب', 'ج'][i]} - ${q.options[i]}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              );
            }),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showExplanationDialog(context, q, door);
            },
            child: const Text('كشف الإجابة الشرح'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: royalGreen),
            onPressed: () {
              setState(() {
                door.isUnlocked = true;
              });
              addScoreToCurrentGroup(10);
              Navigator.pop(ctx);
            },
            child: const Text('إجابة صحيحة (+10)'),
          ),
        ],
      ),
    );
  }

  void _showExplanationDialog(
      BuildContext context, SirajQuestion q, CastleDoor door) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('التوضيح التربوي'),
        content: Text(q.explanation),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('تم'),
          )
        ],
      ),
    );
  }
}
