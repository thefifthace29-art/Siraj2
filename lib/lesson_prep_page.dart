
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

const Color prepGreen = Color(0xFF0A4D2E);
const Color prepGold = Color(0xFFD4AF37);
const Color prepCream = Color(0xFFFDFBF7);

class LessonPrepPage extends StatefulWidget {
  const LessonPrepPage({super.key});

  @override
  State<LessonPrepPage> createState() => _LessonPrepPageState();
}

class _LessonPrepPageState extends State<LessonPrepPage> {
  final _formKey = GlobalKey<FormState>();
  final _lessonController = TextEditingController();
  final _unitController = TextEditingController();
  final _previousController = TextEditingController();
  final _notesController = TextEditingController();

  String subject = 'العربية لغتي';
  String grade = 'الصف الثاني الابتدائي';
  String duration = '45 دقيقة';
  String lessonType = 'درس جديد';

  String? preparedLesson;
  bool isGenerating = false;

  @override
  void dispose() {
    _lessonController.dispose();
    _unitController.dispose();
    _previousController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Widget sectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: prepGreen, size: 24),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: prepGreen,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration fieldDecoration(
    String label, {
    String? hint,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon:
          icon == null ? null : Icon(icon, color: prepGreen),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: prepGold.withOpacity(0.6),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: prepGold.withOpacity(0.6),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: prepGreen,
          width: 1.5,
        ),
      ),
    );
  }

  Widget textField({
    required String label,
    required TextEditingController controller,
    String? hint,
    int maxLines = 1,
    bool requiredField = false,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      textInputAction: maxLines > 1
          ? TextInputAction.newline
          : TextInputAction.next,
      decoration: fieldDecoration(
        label,
        hint: hint,
        icon: icon,
      ),
      validator: requiredField
          ? (value) {
              if (value == null || value.trim().isEmpty) {
                return 'يرجى إدخال $label';
              }
              return null;
            }
          : null,
    );
  }

  Widget dropdownField({
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
    IconData? icon,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: fieldDecoration(label, icon: icon),
      items: options
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget formCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: prepGold.withOpacity(0.55),
        ),
        boxShadow: [
          BoxShadow(
            color: prepGreen.withOpacity(0.035),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle(title, icon),
          ...children,
        ],
      ),
    );
  }

  Future<void> generatePreparation() async {
    if (isGenerating) return;
    if (!_formKey.currentState!.validate()) return;

    final lesson = _lessonController.text.trim();
    final unit = _unitController.text.trim();
    final previous = _previousController.text.trim();
    final notes = _notesController.text.trim();

    setState(() {
      isGenerating = true;
      preparedLesson = null;
    });

    try {
      final response = await http
          .post(
            Uri.parse(
              'https://siraj-groq-proxy.thefifthace29.workers.dev',
            ),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'messages': [
  {
    'role': 'system',
  'content':
      'أنت خبير في إعداد الدروس وفق المنهاج السوري. '
      'أعد تحضير الدرس باللغة العربية بطريقة تربوية عملية ومفصلة. '
      'التزم حصراً بالأقسام العشرة التالية وبالترتيب نفسه، '
      'ولا تضف أي قسم آخر إلى نموذج التحضير: '
      '1. مخرجات التعلم '
      '2. طرائق التدريس '
      '3. موارد التعلم ووسائطه '
      '4. التمهيد والتهيئة '
      '5. سير الدرس '
      '6. إغلاق الدرس '
      '7. التقويم المرحلي '
      '8. التقويم النهائي '
      '9. نشاط للمتميزين '
      '10. نشاط للأقل تحصيلاً. '
      'اجعل مخرجات التعلم قابلة للملاحظة والقياس. '
      'فصّل سير الدرس إلى خطوات توضح دور المعلم والمتعلم، '
      'ووزع الزمن بما يناسب مدة الحصة. '
      'اجعل التقويم المرحلي أثناء سير الدرس والتقويم النهائي في نهايته. '
      'قدم نشاطاً للمتميزين وآخر للطلاب الأقل تحصيلاً. '
      'لا تحذف أي عنوان ولا تضف أقساماً أخرى.',
},
                {
                  'role': 'user',
                  'content':
                      'أعد تحضير الدرس التالي وفق المنهاج السوري:\n'
                      'المادة: $subject\n'
                      'الصف: $grade\n'
                      'عنوان الدرس: $lesson\n'
                      'الوحدة أو المجال: $unit\n'
                      'نوع الدرس: $lessonType\n'
                      'مدة الحصة: $duration\n'
                      'المعارف السابقة: $previous\n'
                      'ملاحظات المعلم: $notes\n\n'
                      'نظم الإجابة بعناوين واضحة، '
                      'واكتب خطوات عملية يستطيع المعلم تنفيذها '
                      'مباشرة داخل الصف، مع أسئلة وأمثلة مناسبة '
                      'لعمر الطلاب.',
                },
              ],
            }),
          )
          .timeout(const Duration(seconds: 45));
      if (response.statusCode != 200) {
        throw Exception('تعذر الاتصال بخدمة التحضير');
      }

      final data = jsonDecode(
        utf8.decode(response.bodyBytes),
      );

      final result =
          data['choices'][0]['message']['content'] as String;

      if (result.trim().isEmpty) {
        throw Exception('لم يصل تحضير صالح');
      }

      if (!mounted) return;

      setState(() {
        preparedLesson = result.trim();
      });

    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تعذر إنشاء التحضير: $error'),
                    duration: const Duration(seconds: 8),
        ),
      );

      return;
    } finally {
      if (mounted) {
        setState(() {
          isGenerating = false;
        });
      }
    }
          final buffer = StringBuffer();

    buffer.writeln('تحضير درس: $lesson');
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('المادة: $subject');
    buffer.writeln('الصف: $grade');
    buffer.writeln('نوع الدرس: $lessonType');
    buffer.writeln('زمن الحصة: $duration');

    if (unit.isNotEmpty) {
      buffer.writeln('الوحدة: $unit');
    }

    buffer.writeln();
    buffer.writeln('أولًا: الأهداف التعليمية');
    buffer.writeln('بنهاية الحصة يُتوقع من المتعلم أن يكون قادرًا على:');
    buffer.writeln('١. يحدد الفكرة أو المهارة الأساسية في الدرس.');
    buffer.writeln('٢. يشارك في النشاط التعليمي المرتبط بموضوع الدرس.');
    buffer.writeln('٣. يجيب عن أسئلة مناسبة لمستواه.');
    buffer.writeln('٤. يطبق ما تعلمه في مهمة قصيرة.');

    buffer.writeln();
    buffer.writeln('ثانيًا: التهيئة والتمهيد');
    buffer.writeln(
      'يبدأ المعلم بتحية الطلاب وتهيئة بيئة صفية مشجعة، '
      'ثم يطرح سؤالًا أو يعرض صورة مرتبطة بموضوع الدرس، '
      'ويستمع إلى إجابات الطلاب لربط التعلم بخبراتهم السابقة.',
    );

    if (previous.isNotEmpty) {
      buffer.writeln('مراجعة التعلم السابق: $previous');
    }

    buffer.writeln();
    buffer.writeln('ثالثًا: الوسائل التعليمية');
    buffer.writeln(
      'الكتاب المدرسي، والسبورة، والبطاقات أو الصور المناسبة، '
      'وأدوات النشاط المتاحة.',
    );

    buffer.writeln();
    buffer.writeln('رابعًا: سير الدرس');
    buffer.writeln('١. التمهيد واستثارة انتباه الطلاب.');
    buffer.writeln(
      '٢. عرض موضوع الدرس وشرح المهارة الجديدة بأمثلة واضحة.',
    );
    buffer.writeln(
      '٣. تقديم نموذج عملي أمام الطلاب مع التفكير بصوت مسموع.',
    );
    buffer.writeln(
      '٤. تنفيذ نشاط موجه بمشاركة الطلاب وتصحيح الأخطاء بلطف.',
    );
    buffer.writeln(
      '٥. إتاحة فرصة للتطبيق الفردي ومراعاة الفروق الفردية.',
    );
    buffer.writeln(
      '٦. تلخيص الأفكار الأساسية والتأكد من تحقق الأهداف.',
    );

    buffer.writeln();
    buffer.writeln('خامسًا: الأنشطة الصفية');
    buffer.writeln(
      'نشاط جماعي قصير، ثم نشاط فردي يناسب مستوى الطلاب، '
      'مع تقديم دعم إضافي لمن يحتاج إليه وتحدٍّ مناسب '
      'للطلاب المتقدمين.',
    );

    buffer.writeln();
    buffer.writeln('سادسًا: التقويم');
    buffer.writeln('• أسئلة شفوية أثناء الشرح.');
    buffer.writeln('• ملاحظة أداء الطلاب خلال النشاط.');
    buffer.writeln('• مهمة قصيرة في نهاية الحصة.');
    buffer.writeln(
      '• تسجيل الطلاب الذين أتقنوا المهارة '
      'والطلاب الذين يحتاجون إلى دعم.',
    );

    buffer.writeln();
    buffer.writeln('سابعًا: مراعاة الفروق الفردية');
    buffer.writeln(
      'تبسيط التعليمات وتقديم أمثلة إضافية للطلاب '
      'الذين يواجهون صعوبة، مع تشجيع الجميع '
      'ومنحهم وقتًا كافيًا للمحاولة.',
    );

    buffer.writeln();
    buffer.writeln('ثامنًا: الواجب المنزلي');
    buffer.writeln(
      'تكليف قصير مرتبط بهدف الدرس، مناسب لعمر الطلاب '
      'ووقتهم، ويعزز المهارة دون إرهاق.',
    );

    if (notes.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('ملاحظات المعلم');
      buffer.writeln(notes);
    }

    buffer.writeln();
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln(
      'ملاحظة: هذا نموذج محلي أولي، '
      'ويجب تخصيص أهدافه وأنشطته وفق محتوى الدرس الفعلي.',
    );

    if (!mounted) return;

    setState(() {
      preparedLesson = buffer.toString();
    });
  }

  void clearForm() {
    if (isGenerating) return;

    _formKey.currentState?.reset();
    _lessonController.clear();
    _unitController.clear();
    _previousController.clear();
    _notesController.clear();

    setState(() {
      subject = 'العربية لغتي';
      grade = 'الصف الثاني الابتدائي';
      duration = '45 دقيقة';
      lessonType = 'درس جديد';
      preparedLesson = null;
    });
  }

final List<String> _prepSections = const [
  'مخرجات التعلم',
  'طرائق التدريس',
  'موارد التعلم ووسائطه',
  'التمهيد والتهيئة',
  'سير الدرس',
  'إغلاق الدرس',
  'التقويم المرحلي',
  'التقويم النهائي',
  'نشاط للمتميزين',
  'نشاط للأقل تحصيلاً',
];

List<Map<String, String>> _splitPreparation(String text) {
  final sections = <Map<String, String>>[];
  String? currentTitle;
  final currentContent = StringBuffer();

  final headingPattern = RegExp(
    r'^\s*(?:[١-١٠0-9]+[\.\-ـ):：、]?\s*)?'
    r'(مخرجات التعلم|طرائق التدريس|موارد التعلم ووسائطه|'
    r'التمهيد والتهيئة|سير الدرس|إغلاق الدرس|'
    r'التقويم المرحلي|التقويم النهائي|'
    r'نشاط للمتميزين|نشاط للأقل تحصيلاً)'
    r'\s*[:：\-ـ]?\s*$',
  );

  void saveSection() {
    if (currentTitle != null) {
      sections.add({
        'title': currentTitle!,
        'content': currentContent.toString().trim(),
      });
    }
  }

  for (final line in text.split('\n')) {
    final match = headingPattern.firstMatch(line);
    if (match != null) {
      saveSection();
      currentTitle = match.group(1);
      currentContent.clear();
    } else if (currentTitle != null) {
      currentContent.writeln(line);
    }
  }

  saveSection();

  if (sections.isEmpty) {
    return [
      {'title': 'التحضير الكامل', 'content': text.trim()},
    ];
  }

  return sections;
}

 
  Future<void> copyPreparation() async {
    if (preparedLesson == null) return;

    await Clipboard.setData(
      ClipboardData(text: preparedLesson!),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم نسخ التحضير'),
        backgroundColor: prepGreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prepCream,
      appBar: AppBar(
        backgroundColor: prepGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'تحضير الدروس',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: prepGreen,
              borderRadius: BorderRadius.circular(23),
              border: Border.all(
                color: prepGold,
                width: 1.2,
              ),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.edit_note_rounded,
                  color: prepGold,
                  size: 44,
                ),
                SizedBox(height: 9),
                Text(
                  'خطط لدرس ناجح',
                  style: TextStyle(
                    color: prepGold,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'أدخل معلومات الدرس لإعداد نموذج تحضير '
                  'منظم يمكنك مراجعته وتخصيصه.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.8,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Form(
            key: _formKey,
            child: Column(
              children: [
                formCard(
                  title: 'معلومات الدرس',
                  icon: Icons.menu_book_rounded,
                  children: [
                    dropdownField(
                      label: 'المادة',
                      value: subject,
                      icon: Icons.school_outlined,
                      options: const [
                        'العربية لغتي',
                        'الرياضيات',
                        'التربية الإسلامية',
                        'العلوم',
                        'الاجتماعيات',
                        'أخرى',
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => subject = value);
                        }
                      },
                    ),
                    const SizedBox(height: 13),
                    dropdownField(
                      label: 'الصف',
                      value: grade,
                      icon: Icons.groups_outlined,
                      options: const [
                        'الصف الأول الابتدائي',
                        'الصف الثاني الابتدائي',
                        'الصف الثالث الابتدائي',
                        'الصف الرابع الابتدائي',
                        'الصف الخامس الابتدائي',
                        'الصف السادس الابتدائي',
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => grade = value);
                        }
                      },
                    ),
                    const SizedBox(height: 13),
                    textField(
                      label: 'عنوان الدرس',
                      controller: _lessonController,
                      hint: 'مثال: وطني',
                      requiredField: true,
                      icon: Icons.title_rounded,
                    ),
                    const SizedBox(height: 13),
                    textField(
                      label: 'الوحدة أو المجال',
                      controller: _unitController,
                      hint: 'اسم الوحدة إن وجد',
                      icon: Icons.folder_outlined,
                    ),
                  ],
                ),
                formCard(
                  title: 'تنظيم الحصة',
                  icon: Icons.schedule_rounded,
                  children: [
                    dropdownField(
                      label: 'نوع الدرس',
                      value: lessonType,
                      options: const [
                        'درس جديد',
                        'مراجعة وتثبيت',
                        'تطبيق وتدريب',
                        'تقويم',
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => lessonType = value);
                        }
                      },
                    ),
                    const SizedBox(height: 13),
                    dropdownField(
                      label: 'مدة الحصة',
                      value: duration,
                      options: const [
                        '30 دقيقة',
                        '35 دقيقة',
                        '40 دقيقة',
                        '45 دقيقة',
                        '50 دقيقة',
                        '60 دقيقة',
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => duration = value);
                        }
                      },
                    ),
                    const SizedBox(height: 13),
                    textField(
                      label: 'المعارف السابقة',
                      controller: _previousController,
                      hint: 'ما الذي يعرفه الطلاب مسبقًا؟',
                      maxLines: 2,
                    ),
                    const SizedBox(height: 13),
                    textField(
                      label: 'ملاحظات المعلم',
                      controller: _notesController,
                      hint: 'مستوى الطلاب أو صعوبات متوقعة...',
                      maxLines: 3,
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed:
                        isGenerating ? null : generatePreparation,
                    style: FilledButton.styleFrom(
                      backgroundColor: prepGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: isGenerating
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.auto_awesome_rounded),
                    label: Text(
                      isGenerating
                          ? 'جارٍ إعداد التحضير...'
                          : 'إعداد نموذج التحضير',
                      style: const TextStyle(
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
                    onPressed:
                        isGenerating ? null : clearForm,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: prepGreen,
                      side: const BorderSide(color: prepGold),
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.restart_alt_rounded),
                    label: const Text(
                      'مسح الحقول والبدء من جديد',
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (preparedLesson != null) ...[
            const SizedBox(height: 24),
            formCard(
              title: 'نموذج التحضير',
              icon: Icons.description_outlined,
              children: [
                
..._splitPreparation(preparedLesson!).map((section) {
  final index = _prepSections.indexOf(section['title'] ?? '');

  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: prepGreen.withValues(alpha: 0.20),
      ),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: prepGreen.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Text(
                index >= 0 ? '${index + 1}' : '•',
                style: const TextStyle(
                  color: prepGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                section['title']!,
                style: const TextStyle(
                  color: prepGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SelectableText(
          section['content']!.isEmpty
              ? 'لم يُدرج محتوى لهذا القسم.'
              : section['content']!,
          style: const TextStyle(
            color: Color(0xFF26372D),
            fontSize: 14,
            height: 1.9,
          ),
        ),
      ],
    ),
  );
}),

                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: copyPreparation,
                    style: FilledButton.styleFrom(
                      backgroundColor: prepGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    icon: const Icon(Icons.copy_rounded),
                    label: const Text('نسخ التحضير'),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
