import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surf_flutter_study_jam_2023/config/text_style.dart';

/// Виджет для ввода ссылки на билет
class UrlBottomSheet extends StatefulWidget {
  const UrlBottomSheet({super.key});

  @override
  State<UrlBottomSheet> createState() => _UrlBottomSheetState();
}

class _UrlBottomSheetState extends State<UrlBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  /// Проверяет буфер обмена на наличие ссылки на билет
  void checkClipboard() async {
    final content = await Clipboard.getData(Clipboard.kTextPlain);
    if (content?.text != null && content!.text!.endsWith(".pdf")) {
      _controller.text = content.text!;
    }
  }

  /// Проверяет валидность ссылки
  bool checkIsUrlValid(String url) {
    final data = url.toLowerCase();
    final isValidUrl = Uri.tryParse(data)?.isAbsolute;
    final hasHttps = data.startsWith("https://");
    final hasPdf = data.endsWith(".pdf");
    return isValidUrl == true && hasHttps && hasPdf;
  }

  /// Добавляет ссылку на билет в список
  void addUrl(BuildContext context, String url) async {
    if (checkIsUrlValid(url)) {
      Navigator.pop(context, url);
      return;
    }
    Navigator.pop(context, "");
  }

  @override
  void initState() {
    super.initState();
    checkClipboard();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Column(children: [
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Введите url',
            labelStyle:
                AppTextStyle.regular16.value.copyWith(color: Colors.grey[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusColor: Colors.purple,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Введите URL';
            }
            if (!checkIsUrlValid(value)) {
              return 'Введите корректный URL';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: 150,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) {
                if (checkIsUrlValid(_controller.text)) {
                  return Colors.purple;
                }
                return Colors.grey[600]!;
              }),
            ),
            onPressed: () => addUrl(context, _controller.text),
            child: Text(
              'Добавить',
              style: AppTextStyle.regular16.value.copyWith(color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
}
