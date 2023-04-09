import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/config/text_style.dart';

class UrlBottomSheet extends StatefulWidget {
  const UrlBottomSheet({super.key});

  @override
  State<UrlBottomSheet> createState() => _UrlBottomSheetState();
}

class _UrlBottomSheetState extends State<UrlBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Введите url',
              hintStyle: AppTextStyle.regular20.value
                  .copyWith(color: Colors.grey[600]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 150,
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[600])),
              onPressed: null,
              child: Text(
                'Добавить',
                style:
                    AppTextStyle.regular16.value.copyWith(color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
