import 'package:flutter/material.dart';

class MyOverlayEntry {
  MyOverlayEntry();

  OverlayEntry? overlayHandler;
  bool get hasHandler => overlayHandler != null;

  rebuildOverlay() {
    overlayHandler?.markNeedsBuild();
  }

  closeOverlay() {
    overlayHandler?.remove();
    overlayHandler = null;
  }

  showOverlay(BuildContext context, Widget child) {
    OverlayEntry buildOverlayEntry() {
      return OverlayEntry(builder: (_) {
        if (!context.mounted) return Container();
        final RenderBox inputBox = context.findRenderObject() as RenderBox;
        final inputPosition = inputBox.localToGlobal(Offset.zero);
        return Positioned(
          top: inputPosition.dy + inputBox.size.height,
          left: inputPosition.dx,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 184, 184, 184).withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            width: inputBox.size.width,
            height: 200,
            child: Material(child: child),
          ),
        );
      });
    }

    if (overlayHandler != null) {
      return;
    }
    final overlay = buildOverlayEntry();
    Overlay.of(context).insert(overlay);
    overlayHandler = overlay;
  }
}

class MyOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => Navigator.of(context).pop(),
      onVerticalDragUpdate: (details) {
        if ((details.primaryDelta ?? 0) > 10.0 ||
            (details.primaryDelta ?? 0) < -10.0) {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Text('Overlay Content'),
        ),
      ),
    );
  }
}
