import 'package:flutter/material.dart';
import 'package:manager_system/components/overlay.dart';

class SelectOption {
  late String value;
  late String text;
  SelectOption({required this.text, required this.value});
}

class Select extends StatefulWidget {
  final List<SelectOption> options;
  final String value;
  final Function(String value) onChange;
  final Widget? bottomExtend;

  const Select({
    Key? key,
    required this.options,
    required this.value,
    required this.onChange,
    this.bottomExtend,
  }) : super(key: key);

  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {
  MyOverlayEntry myOverlayEntry = MyOverlayEntry();
  @override
  Widget build(BuildContext context) {
    Widget overlayChild = ListView.builder(
      itemCount: widget.bottomExtend != null
          ? widget.options.length + 1
          : widget.options.length,
      itemBuilder: (_, int index) {
        if (index >= widget.options.length) {
          return widget.bottomExtend;
        }
        final option = widget.options[index];
        final isHovered = ValueNotifier<bool>(false);
        return MouseRegion(
          onHover: (_) {
            isHovered.value = true;
          },
          onExit: (_) {
            isHovered.value = false;
          },
          child: InkWell(
            onTap: () {
              widget.onChange(option.value);
            },
            child: Container(
              color:
                  isHovered.value ? Colors.grey.withOpacity(0.5) : Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(option.text),
              ),
            ),
          ),
        );
      },
    );

    return GestureDetector(
      onTap: () {
        myOverlayEntry.showOverlay(context, overlayChild);
      },
      child: Container(
          alignment: Alignment.center,
          child: Row(
            children: [
              Text(widget.value),
              const Icon(Icons.arrow_drop_down),
            ],
          )),
    );
  }
}
