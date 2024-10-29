import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/provider/radio_provider.dart';

class RadioWidget extends ConsumerWidget {
  const RadioWidget({
    super.key,
    required this.titleRadio,
    required this.categoryColor,
    required this.valueInput,
    required this.onChnageValue,
  });

  final String titleRadio;
  final Color categoryColor;
  final int valueInput;
  final VoidCallback onChnageValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radio = ref.watch(radioProvider);
    return Theme(
      data: ThemeData(unselectedWidgetColor: categoryColor),
      child: RadioListTile(
        enableFeedback: false,
        contentPadding: EdgeInsets.zero,
        splashRadius: 0,
        hoverColor: Colors.transparent,
        title: Transform.translate(
          offset: const Offset(-10, 0),
          child: Text(
            titleRadio,
            style: TextStyle(
              fontSize: 18.0,
              color: categoryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        value: valueInput,
        groupValue: radio,
        onChanged: (value) => onChnageValue(),
        activeColor: categoryColor,
      ),
    );
  }
}
