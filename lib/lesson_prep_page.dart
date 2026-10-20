
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

const Color prepGreen = Color(0xFF0A4D2E);
const Color prepGold = Color(0xFFD4AF37);
const Color prepCream = Color(0xFFFDFBF7);

class LessonPrepPage extends StatefulWidget {
  const LessonPrepPage({
    super.key,
    this.initialLessonTitle,
    this.initialUnitTitle,
    this.initialPage,
  });

  final String? initialLessonTitle;
  final String? initialUnitTitle;
  final int? initialPage;

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

  static const List<String> _prepSections = [
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

  @override
  void initState() {
    super.initState();

    _lessonController.text = widget.initialLessonTitle ?? '';
    _unitController.text = widget.initialUnitTitle ?? '';
  }

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
      prefixIcon: icon == null
          ? null
          : Icon(icon, color: prepGreen),
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
      final textbookPageText = widget.initialPage == null
          ? ''
          : '\nرقم صفحة الدرس في الكتاب: ${widget.initialPage}';

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
                      'أعد تحضير الدرس باللغة العربية الفصحى، '
                      'بطريقة تربوية عملية ومفصلة وقابلة للتطبيق. '
                      'التزم بالعناوين العشرة التالية وبالترتيب نفسه، '
                      'واكتب كل عنوان في سطر مستقل: '
                      'مخرجات التعلم، طرائق التدريس، '
                      'موارد التعلم ووسائطه، التمهيد والتهيئة، '
                      'سير الدرس، إغلاق الدرس، التقويم المرحلي، '
                      'التقويم النهائي، نشاط للمتميزين، '
                      'نشاط للأقل تحصيلاً. '
                      'لا تضف عنواناً رئيسياً آخر ولا تحذف أي عنوان. '
                      'اجعل مخرجات التعلم قابلة للملاحظة والقياس. '
                      'فصّل سير الدرس إلى خطوات مرقمة، '
                      'ووضح في كل خطوة دور المعلم ودور المتعلم '
                      'والزمن والأسئلة المتوقعة وإجاباتها. '
                      'وزع زمن جميع خطوات الحصة بحيث يساوي مدة الحصة '
                      'المحددة. '
                      'اجعل التقويم المرحلي أثناء سير الدرس، '
                      'والتقويم النهائي في نهاية الحصة. '
                      'قدم نشاطاً إثرائياً للمتميزين ونشاطاً مبسطاً '
                      'للطلاب الذين يحتاجون إلى دعم. '
                      'لا تدّع الاطلاع على نص الكتاب إذا لم يُقدّم لك. '
                      'إذا لم تتوفر تفاصيل محتوى الدرس، فاجعل التحضير '
                      'مبنياً على عنوان الدرس، وتجنب اختلاق نصوص '
                      'أو معلومات محددة ونسبتها إلى الكتاب.',
                },
                {
                  'role': 'user',
                  'content':
                      'أعد تحضير الدرس التالي وفق المنهاج السوري:\n'
                      'المادة: $subject\n'
                      'الصف: $grade\n'
                      'عنوان الدرس: $lesson\n'
                      'الوحدة أو المجال: $unit\n'
                      '$textbookPageText\n'
                      'نوع الدرس: $lessonType\n'
                      'مدة الحصة: $duration\n'
                      'المعارف السابقة: $previous\n'
                      'ملاحظات المعلم: $notes\n\n'
                      'اكتب محتوى عملياً ومفصلاً يستطيع المعلم '
                      'تنفيذه مباشرة داخل الصف، مع مراعاة عمر الطلاب '
                      'والفروق الفردية. '
                      'اكتب العناوين العشرة المطلوبة كما هي تماماً، '
                      'واجعل لكل عنوان محتوى واضحاً ومفيداً.',
                },
              ],
            }),
          )
          .timeout(const Duration(seconds: 45));

      if (response.statusCode != 200) {
        throw Exception(
          'تعذر الاتصال بخدمة التحضير '
          '(رمز الاستجابة: ${response.statusCode})',
        );
      }

      final decoded = jsonDecode(
        utf8.decode(response.bodyBytes),
      );

      if (decoded is! Map<String, dynamic>) {
        throw Exception('صيغة الاستجابة غير صالحة');
      }

      final choices = decoded['choices'];
      if (choices is! List || choices.isEmpty) {
        throw Exception('لم تصل نتيجة من خدمة التحضير');
      }

      final firstChoice = choices.first;
      if (firstChoice is! Map) {
        throw Exception('صيغة نتيجة التحضير غير صالحة');
      }

      final message = firstChoice['message'];
      if (message is! Map) {
        throw Exception('لم يصل محتوى التحضير');
      }

      final result = message['content'];
      if (result is! String || result.trim().isEmpty) {
        throw Exception('وصل محتوى فارغ من خدمة التحضير');
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
    } finally {
      if (mounted) {
        setState(() {
          isGenerating = false;
        });
      }
    }
  }

  void clearForm() {
    if (isGenerating) return;

    _formKey.currentState?.reset();

    _lessonController.text = widget.initialLessonTitle ?? '';
    _unitController.text = widget.initialUnitTitle ?? '';
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

  String _normalizeHeading(String value) {
    return value
        .replaceAll('**', '')
        .replaceAll('__', '')
        .replaceAll('*', '')
        .replaceAll('#', '')
        .replaceAll(RegExp(r'^[\s\d٠-٩١-٩.،:：؛\-ـ)（(]+'), '')
        .replaceAll(RegExp(r'[:：\-ـ]+$'), '')
        .trim();
  }

  List<Map<String, String>> _splitPreparation(String text) {
    final sections = <Map<String, String>>[];
    String? currentTitle;
    final currentContent = StringBuffer();

    final aliases = <String, String>{
      'مخرجات التعلم': 'مخرجات التعلم',
      'الأهداف التعليمية': 'مخرجات التعلم',
      'اهداف التعلم': 'مخرجات التعلم',
      'طرائق التدريس': 'طرائق التدريس',
      'استراتيجيات التدريس': 'طرائق التدريس',
      'طرق التدريس': 'طرائق التدريس',
      'موارد التعلم ووسائطه': 'موارد التعلم ووسائطه',
      'الوسائل التعليمية': 'موارد التعلم ووسائطه',
      'موارد التعلم': 'موارد التعلم ووسائطه',
      'التمهيد والتهيئة': 'التمهيد والتهيئة',
      'التهيئة والتمهيد': 'التمهيد والتهيئة',
      'التمهيد': 'التمهيد والتهيئة',
      'سير الدرس': 'سير الدرس',
      'خطوات الدرس': 'سير الدرس',
      'إغلاق الدرس': 'إغلاق الدرس',
      'اغلاق الدرس': 'إغلاق الدرس',
      'الخاتمة': 'إغلاق الدرس',
      'التقويم المرحلي': 'التقويم المرحلي',
      'التقويم التكويني': 'التقويم المرحلي',
      'التقويم أثناء الدرس': 'التقويم المرحلي',
      'التقويم النهائي': 'التقويم النهائي',
      'التقويم الختامي': 'التقويم النهائي',
      'نشاط للمتميزين': 'نشاط للمتميزين',
      'نشاط للمتفوقين': 'نشاط للمتميزين',
      'نشاط الإثراء': 'نشاط للمتميزين',
      'نشاط للأقل تحصيلاً': 'نشاط للأقل تحصيلاً',
      'نشاط للاقل تحصيلا': 'نشاط للأقل تحصيلاً',
      'نشاط للطلاب الضعاف': 'نشاط للأقل تحصيلاً',
      'نشاط علاجي': 'نشاط للأقل تحصيلاً',
    };

    String? matchHeading(String line) {
      var cleaned = _normalizeHeading(line);

      // تجاهل الترقيم في بداية العنوان.
      cleaned = cleaned.replaceFirst(
        RegExp(r'^[٠-٩١-٩0-9]+[\s.)،:\-ـ]+'),
        '',
      );

      cleaned = cleaned.trim();

      for (final entry in aliases.entries) {
        if (cleaned == entry.key) {
          return entry.value;
        }
      }

      return null;
    }

    void saveSection() {
      if (currentTitle != null) {
        sections.add({
          'title': currentTitle!,
          'content': currentContent.toString().trim(),
        });
      }
    }

    for (final line in text.split('\n')) {
      final heading = matchHeading(line);

      if (heading != null) {
        saveSection();
        currentTitle = heading;
        currentContent.clear();
      } else if (currentTitle != null) {
        currentContent.writeln(line);
      }
    }

    saveSection();

    if (sections.isEmpty) {
      return [
        {
          'title': 'التحضير الكامل',
          'content': text.trim(),
        },
      ];
    }

    // عرض الأقسام وفق الترتيب المعتمد، حتى لو اختلف ترتيب
    // العناوين في استجابة خدمة التحضير.
    final orderedSections = <Map<String, String>>[];

    for (final title in _prepSections) {
      for (final section in sections) {
        if (section['title'] == title) {
          orderedSections.add(section);
        }
      }
    }

    // لا نفقد أي محتوى لم يتعرف المحلل على عنوانه.
    for (final section in sections) {
      if (!_prepSections.contains(section['title'])) {
        orderedSections.add(section);
      }
    }

    return orderedSections;
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

  Widget _buildPreparationSection(
    Map<String, String> section,
  ) {
    final title = section['title'] ?? 'قسم التحضير';
    final content = section['content'] ?? '';
    final index = _prepSections.indexOf(title);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: prepGreen.withOpacity(0.20),
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
                  color: prepGreen.withOpacity(0.10),
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
                  title,
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
            content.isEmpty
                ? 'لم يُدرج محتوى لهذا القسم.'
                : content,
            style: const TextStyle(
              color: Color(0xFF26372D),
              fontSize: 14,
              height: 1.9,
            ),
          ),
        ],
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
            child: Column(
              children: [
                const Icon(
                  Icons.edit_note_rounded,
                  color: prepGold,
                  size: 44,
                ),
                const SizedBox(height: 9),
                const Text(
                  'خطط لدرس ناجح',
                  style: TextStyle(
                    color: prepGold,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'أدخل معلومات الدرس لإعداد نموذج تحضير '
                  'منظم يمكنك مراجعته وتخصيصه.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.8,
                    fontSize: 14,
                  ),
                ),
                if (widget.initialPage != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'صفحة الدرس في الكتاب: ${widget.initialPage}',
                    style: const TextStyle(
                      color: prepGold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
                        vertical: 14,
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
                    onPressed: isGenerating ? null : clearForm,
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
                ..._splitPreparation(preparedLesson!)
                    .map(_buildPreparationSection),
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
