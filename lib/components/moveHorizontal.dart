import 'package:flutter/material.dart';

class MoveHorizontalWidget extends StatefulWidget {
  final Widget Function(ScrollController) childBuild;
  const MoveHorizontalWidget({super.key, required this.childBuild});

  @override
  State<MoveHorizontalWidget> createState() => _MoveHorizontalWidgetState();
}

class _MoveHorizontalWidgetState extends State<MoveHorizontalWidget> {
  double horizontalOffset = 0.0;
  ScrollController horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        horizontalOffset =
            details.localPosition.dx + horizontalScrollController.offset;
      },
      onHorizontalDragUpdate: (details) {
        final moveOffset = horizontalOffset - details.localPosition.dx;
        horizontalScrollController.jumpTo(moveOffset);
      },
      child: widget.childBuild(horizontalScrollController),
    );
  }
}
