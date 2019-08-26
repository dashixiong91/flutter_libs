import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Toast {
  static const int LENGTH_SHORT = 1000;
  static const int LENGTH_LONG = 2000;

  static Future<void> show(
    String text,
    BuildContext context, {
    int duration = LENGTH_SHORT,
    LikeToastPosition position = LikeToastPosition.CENTER,
  }) async {
    LikeToastManager manager = LikeToastManager.getInstance('toast');
    Widget toast = Text(
      text,
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.white,
      ),
    );
    manager.createView(
        context: context,
        child: toast,
        position: position,
        isEventOpaque: true);
    await Future.delayed(Duration(milliseconds: duration));
    manager.dismiss();
  }
}

class LikeToastManager {
  static Map<String, LikeToastManager> manager = {};
  String key;

  static LikeToastManager getInstance(String key) {
    assert(key != null && key.isNotEmpty);
    if (!manager.containsKey(key)) {
      manager[key] = LikeToastManager._internal(key);
    }
    return manager[key];
  }

  LikeToastManager._internal(this.key);

  OverlayState _overlayState;
  OverlayEntry _overlayEntry;
  bool _isVisible = false;

  void createView(
      {@required BuildContext context,
      @required Widget child,
      @required bool isEventOpaque,
      LikeToastPosition position}) {
    assert(context != null);
    assert(child != null);
    if (_isVisible) {
      dismiss();
    }
    _overlayState = Overlay.of(context);
    _overlayEntry = new OverlayEntry(
      builder: (BuildContext context) => LikeToastWidget(
          child: child, position: position, isEventOpaque: isEventOpaque),
    );
    _isVisible = true;
    _overlayState.insert(_overlayEntry);
  }

  dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

enum LikeToastPosition {
  CENTER,
  TOP,
  BOTTOM,
}

class LikeToastWidget extends StatelessWidget {
  final Widget child;
  final LikeToastPosition position;
  final bool isEventOpaque;

  LikeToastWidget({
    Key key,
    @required this.child,
    this.isEventOpaque = true,
    this.position = LikeToastPosition.CENTER,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isTextToast = child is Text;
    Widget content = child;
    content = Padding(
      padding: isTextToast
          ? const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0)
          : const EdgeInsets.all(2.0),
      child: content,
    );
    content = Container(
      decoration: ShapeDecoration(
          color: Colors.black87,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)))),
      child: content,
    );
    content = Material(
      type: MaterialType.transparency,
      child: content,
    );
    content = Padding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: content,
        ),
      ),
    );
    if (!isEventOpaque) {
      content = Listener(
        behavior: HitTestBehavior.opaque,
        child: content,
      );
    }
    return content;
  }
}
