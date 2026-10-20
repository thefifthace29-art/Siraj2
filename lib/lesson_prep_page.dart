
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart';

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
  final _pageController = TextEditingController();
  final _previousController = TextEditingController();
  final _notesController = TextEditingController();

  String subject = 'العربية لغتي';
  String grade = 'الصف الثاني الابتدائي';
  String duration = '45 دقيقة';
  String lessonType = 'درس جديد';

  String? preparedLesson;
  bool isGenerating = false;
  bool isReadingPdf = false;

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
    _pageController.text = widget.initialPage?.toString() ?? '';
  }

  @override
  void dispose() {
    _lessonController.dispose();
    _unitController.dispose();
    _pageController.dispose();
    _previousController.dispose();
    _notesController.dispose();
    super.dispose();
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
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: prepGold.withOpacity(0.6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: prepGreen, width: 1.5),
      ),
    );
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

  Widget textField({
    required String label,
    required TextEditingController controller,
    String? hint,
    int maxLines = 1,
    bool requiredField = false,
    IconData? icon,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textDirection: TextDirection.rtl,
      decoration: fieldDecoration(label, hint: hint, icon: icon),
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
        border: Border.all(color: prepGold.withOpacity(0.55)),
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

  /// استخراج النص الفعلي من صفحة PDF.
  ///
  /// رقم الصفحة هنا هو رقم صفحة PDF ابتداءً من 1،
  /// كما يستخدمه عارض الكتاب في التطبيق.
  Future<String> _extractPdfPageText(int pageNumber) async {
    if (pageNumber < 1) {
      throw Exception('رقم صفحة الكتاب غير صالح.');
    }

    PdfDocument? document;

    try {
      final ByteData data =
          await rootBundle.load('arabic_grade2_term1.pdf');

      final Uint8List bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      document = PdfDocument(inputBytes: bytes);

      if (pageNumber > document.pages.count) {
        throw Exception(
          'رقم الصفحة $pageNumber يتجاوز عدد صفحات ملف الكتاب '
          '(${document.pages.count} صفحة). '
          'تحقق من رقم الصفحة في الفهرس.',
        );
      }

      final text = PdfTextExtractor(document).extractText(
        startPageIndex: pageNumber - 1,
        endPageIndex: pageNumber - 1,
      );

      final cleaned = text
          .replaceAll('\u0000', '')
          .replaceAll(RegExp(r'[ \t]+\n'), '\n')
          .trim();

      if (cleaned.isEmpty) {
        throw Exception(
          'لم أستطع استخراج نص من صفحة $pageNumber. '
          'قد تكون الصفحة مصوّرة وليست نصية؛ عندها نحتاج إلى OCR.',
        );
      }

      return cleaned;
    } finally {
      document?.dispose();
    }
  }

  Future<void> generatePreparation() async {
    if (isGenerating) return;
    if (!_formKey.currentState!.validate()) return;

    final lesson = _lessonController.text.trim();
    final unit = _unitController.text.trim();
    final previous = _previousController.text.trim();
    final notes = _notesController.text.trim();
    final pageNumber = int.tryParse(_pageController.text.trim());

    if (subject == 'العربية لغتي' &&
        (pageNumber == null || pageNumber < 1)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('أدخل رقم صفحة الدرس لكي يقرأ التطبيق محتواها.'),
        ),
      );
      return;
    }

    setState(() {
      isGenerating = true;
      isReadingPdf = subject == 'العربية لغتي';
      preparedLesson = null;
    });

    try {
      String textbookText = '';

      if (subject == 'العربية لغتي') {
        textbookText = await _extractPdfPageText(pageNumber!);

        if (!mounted) return;

        setState(() {
          isReadingPdf = false;
        });
      }

      final systemPrompt =
          'أنت خبير في إعداد الدروس وفق المنهاج السوري. '
          'استخدم نص الكتاب الذي يرسله المستخدم أساساً للتحضير. '
          'اجعل التحضير مرتبطاً بمحتوى الصفحة الفعلي، ولا تنسب '
          'إلى الكتاب نصوصاً أو معلومات غير موجودة في المحتوى المرسل. '
          'إذا كان النص المستخرج غير كافٍ لتحديد جزء من الدرس، '
          'صرّح بذلك بوضوح ولا تخترع تفاصيل على أنها من الكتاب. '
          'أعد التحضير باللغة العربية الفصحى، بطريقة تربوية عملية '
          'ومفصلة وقابلة للتطبيق. '
          'التزم بالعناوين العشرة التالية وبالترتيب نفسه، '
          'واكتب كل عنوان في سطر مستقل: '
          'مخرجات التعلم، طرائق التدريس، موارد التعلم ووسائطه، '
          'التمهيد والتهيئة، سير الدرس، إغلاق الدرس، التقويم المرحلي، '
          'التقويم النهائي، نشاط للمتميزين، نشاط للأقل تحصيلاً. '
          'لا تحذف أي عنوان. اجعل مخرجات التعلم قابلة للملاحظة والقياس. '
          'فصّل سير الدرس إلى خطوات مرقمة، ووضح في كل خطوة دور المعلم '
          'ودور المتعلم والزمن والأسئلة المتوقعة وإجاباتها. '
          'وزع زمن الخطوات بحيث يساوي مدة الحصة المحددة. '
          'اجعل التقويم المرحلي أثناء الدرس والتقويم النهائي في نهايته. '
          'راعِ عمر الطلاب والفروق الفردية، وقدم نشاطاً إثرائياً '
          'للمتميزين ونشاطاً مبسطاً للطلاب الذين يحتاجون إلى دعم.';

      final userPrompt = StringBuffer()
        ..writeln('أعد تحضير الدرس التالي وفق المنهاج السوري.')
        ..writeln('المادة: $subject')
        ..writeln('الصف: $grade')
        ..writeln('عنوان الدرس: $lesson')
        ..writeln('الوحدة أو المجال: $unit')
        ..writeln('نوع الدرس: $lessonType')
        ..writeln('مدة الحصة: $duration')
        ..writeln('المعارف السابقة: $previous')
        ..writeln('ملاحظات المعلم: $notes');

      if (pageNumber != null) {
        userPrompt.writeln('رقم صفحة PDF المقروءة: $pageNumber');
      }

      if (textbookText.isNotEmpty) {
        userPrompt
          ..writeln('\n--- بداية النص المستخرج من الكتاب ---')
          ..writeln(textbookText)
          ..writeln('--- نهاية النص المستخرج من الكتاب ---')
          ..writeln(
            'اعتمد على هذا النص في بناء الشرح والأمثلة والأسئلة '
            'والإجابات والأنشطة. ميّز بين المعلومات الواردة في النص '
            'والأنشطة التعليمية التي تقترحها أنت.',
          );
      } else {
        userPrompt.writeln(
          'لا يوجد نص مستخرج من ملف الكتاب لهذا الطلب. '
          'لا تدّع أنك قرأت نص الكتاب.',
        );
      }

      final response = await http
          .post(
            Uri.parse(
              'https://siraj-groq-proxy.thefifthace29.workers.dev',
            ),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'messages': [
                {'role': 'system', 'content': systemPrompt},
                {'role': 'user', 'content': userPrompt.toString()},
              ],
            }),
          )
          .timeout(const Duration(seconds: 90));

      if (response.statusCode != 200) {
        throw Exception(
          'تعذر الاتصال بخدمة التحضير '
          '(رمز الاستجابة: ${response.statusCode}).',
        );
      }

      final decoded = jsonDecode(utf8.decode(response.bodyBytes));

      if (decoded is! Map<String, dynamic>) {
        throw Exception('صيغة الاستجابة غير صالحة.');
      }

      final choices = decoded['choices'];
      if (choices is! List || choices.isEmpty) {
        throw Exception(
          'لم تصل نتيجة من خدمة التحضير. تحقق من إعداد الخدمة.',
        );
      }

      final firstChoice = choices.first;
      if (firstChoice is! Map) {
        throw Exception('صيغة نتيجة التحضير غير صالحة.');
      }

      final message = firstChoice['message'];
      if (message is! Map) {
        throw Exception('لم يصل محتوى التحضير.');
      }

      final result = message['content'];
      if (result is! String || result.trim().isEmpty) {
        throw Exception('وصل محتوى فارغ من خدمة التحضير.');
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
          duration: const Duration(seconds: 10),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isGenerating = false;
          isReadingPdf = false;
        });
      }
    }
  }

  void clearForm() {
    if (isGenerating) return;

    _formKey.currentState?.reset();
    _lessonController.text = widget.initialLessonTitle ?? '';
    _unitController.text = widget.initialUnitTitle ?? '';
    _pageController.text = widget.initialPage?.toString() ?? '';
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
        .replaceAll(
          RegExp(r'^[\s\d٠-٩١-٩.،:：؛\-ـ)（(]+'),
          '',
        )
        .replaceAll(RegExp(r'[:：\-ـ]+$'), '')
        .trim();
  }

  List<Map<String, String>> _splitPreparation(String text) {
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

    final sections = <Map<String, String>>[];
    String? currentTitle;
    final buffer = StringBuffer();

    for (final line in text.split('\n')) {
      var headingText = _normalizeHeading(line);
      headingText = headingText.replaceFirst(
        RegExp(r'^[٠-٩١-٩0-9]+[\s.)،:\-ـ]+'),
        '',
      );

      final heading = aliases[headingText.trim()];

      if (heading != null) {
        if (currentTitle != null) {
          sections.add({
            'title': currentTitle,
            'content': buffer.toString().trim(),
          });
        }

        currentTitle = heading;
        buffer.clear();
      } else if (currentTitle != null) {
        buffer.writeln(line);
      }
    }

    if (currentTitle != null) {
      sections.add({
        'title': currentTitle,
        'content': buffer.toString().trim(),
      });
    }

    if (sections.isEmpty) {
      return [
        {'title': 'التحضير الكامل', 'content': text.trim()},
      ];
    }

    final ordered = <Map<String, String>>[];

    for (final title in _prepSections) {
      for (final section in sections) {
        if (section['title'] == title) {
          ordered.add(section);
        }
      }
    }

    for (final section in sections) {
      if (!_prepSections.contains(section['title'])) {
        ordered.add(section);
      }
    }

    return ordered;
  }

  Future<void> copyPreparation() async {
    if (preparedLesson == null) return;

    await Clipboard.setData(ClipboardData(text: preparedLesson!));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم نسخ التحضير'),
        backgroundColor: prepGreen,
      ),
    );
  }

  Widget _buildPreparationSection(Map<String, String> section) {
    final title = section['title'] ?? 'قسم التحضير';
    final content = section['content'] ?? '';
    final index = _prepSections.indexOf(title);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: prepGreen.withOpacity(0.20)),
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
            content.isEmpty ? 'لم يُدرج محتوى لهذا القسم.' : content,
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
              border: Border.all(color: prepGold, width: 1.2),
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
                  'يقرأ سِراج نص الصفحة المحددة من الكتاب، '
                  'ثم يستخدم محتواها لإعداد تحضير مرتبط بالدرس.',
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
                    const SizedBox(height: 13),
                    textField(
                      label: 'رقم صفحة الدرس في ملف PDF',
                      controller: _pageController,
                      hint: 'أدخل رقم الصفحة كما تظهر في عارض الكتاب',
                      requiredField: true,
                      icon: Icons.picture_as_pdf_outlined,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'تُستخدم الصفحة لاستخراج النص من ملف الكتاب '
                      'المضمّن في التطبيق.',
                      style: TextStyle(
                        color: Colors.black54,
                        height: 1.6,
                        fontSize: 12,
                      ),
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
                      padding: const EdgeInsets.symmetric(vertical: 14),
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
                          ? (isReadingPdf
                              ? 'جارٍ قراءة صفحة الكتاب...'
                              : 'جارٍ إعداد التحضير...')
                          : 'قراءة الدرس وإعداد التحضير',
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
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.restart_alt_rounded),
                    label: const Text('مسح الحقول والبدء من جديد'),
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
                      padding: const EdgeInsets.symmetric(vertical: 14),
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
