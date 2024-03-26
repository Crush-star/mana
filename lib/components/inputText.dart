import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pluto_grid/pluto_grid.dart';

class InputText extends StatefulWidget {
  final value;
  final Function(String text) textOnChanged;
  final bool isNumber;
  const InputText(
      {super.key,
      required this.value,
      required this.textOnChanged,
      required this.isNumber});

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.text = widget.value.toString();
  }

  @override
  void didUpdateWidget(covariant InputText oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.text = widget.value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: widget.isNumber
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ]
            : null,
        style: const TextStyle(fontSize: 14),
        decoration: const InputDecoration(
          isDense: true,
          hintStyle: TextStyle(fontSize: 14),
          border: InputBorder.none,
        ),
        // focusNode: focusNode,
        controller: controller,
        onChanged: widget.textOnChanged,
      ),
    );
  }
}
