import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.maxLines,
    required this.txtController,
    required this.maxL,
  });

  final String hintText;
  final int maxLines;
  final TextEditingController txtController;
  final int maxL;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        maxLength: widget.maxL,
        controller: widget.txtController,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        cursorColor: Colors.black.withOpacity(0.5),
        maxLines: widget.maxLines,
      ),
    );
  }
}
