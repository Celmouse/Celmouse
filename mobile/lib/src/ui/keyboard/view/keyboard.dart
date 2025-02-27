import 'package:controller/src/ui/keyboard/viewmodel/keyboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../UI/keyboard/model.dart';
import '../../../UI/keyboard/keyboard_theme.dart';

class KeyboardTyppingPage extends StatefulWidget {
  const KeyboardTyppingPage({
    super.key,
    this.theme = defaultKeyboardTheme,
    required this.viewmodel,
  });

  final KeyboardTheme theme;
  final KeyboardViewModel viewmodel;

  @override
  KeyboardTyppingPageState createState() => KeyboardTyppingPageState();
}

class KeyboardTyppingPageState extends State<KeyboardTyppingPage> {
  double _getKeyHeight(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? widget.theme.keyHeight * 0.95
        : widget.theme.keyHeight;
  }

  double _getKeyWidth(double flex) {
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? widget.theme.keyWidth * flex * 0.8
        : widget.theme.keyWidth * flex;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.viewmodel.keys
                    .map<Row>((row) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: row.map<Widget>((keyItem) {
                            return Expanded(
                              flex: keyItem.flex,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(widget.theme.keySpacing / 2),
                                child: KeyButton(
                                    keyItem: keyItem,
                                    viewModel: widget.viewmodel,
                                    theme: widget.theme,
                                    keyHeight: _getKeyHeight(context),
                                    keyWidth:
                                        _getKeyWidth(keyItem.flex.toDouble()),
                                    onPressed: () {
                                      if (keyItem.type == KeyType.normal) {
                                        widget.viewmodel.onCharPressed(
                                          keyItem.label!,
                                        );
                                      } else {
                                        widget.viewmodel.onSpecialKeyPressed(
                                          keyItem.specialKeyType!,
                                        );
                                      }
                                    },
                                    onReleased: () {
                                      if (keyItem.type == KeyType.normal) {
                                        return;
                                        // widget.viewmodel.onCharReleased(
                                        //   keyItem.label!,
                                        // );
                                      } else {
                                        widget.viewmodel.onSpecialKeyReleased(
                                          keyItem.specialKeyType!,
                                        );
                                      }
                                    }),
                              ),
                            );
                          }).toList(),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KeyButton extends StatefulWidget {
  final MKey keyItem;
  final KeyboardViewModel viewModel;
  final KeyboardTheme theme;
  final double keyHeight;
  final double keyWidth;
  final VoidCallback onPressed;
  final VoidCallback onReleased;

  const KeyButton({
    super.key,
    required this.keyItem,
    required this.viewModel,
    required this.theme,
    required this.keyHeight,
    required this.keyWidth,
    required this.onPressed,
    required this.onReleased,
  });

  @override
  KeyButtonState createState() => KeyButtonState();
}

class KeyButtonState extends State<KeyButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        HapticFeedback.lightImpact();
        setState(() => _isPressed = true);
        widget.onPressed();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onReleased();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: widget.keyHeight,
        width: widget.keyWidth,
        decoration: BoxDecoration(
          color: _isPressed
              ? widget.theme.keyPressedColor
              : widget.keyItem.type == KeyType.normal
                  ? widget.theme.keyColor
                  : widget.keyItem.type == KeyType.special
                      ? widget.theme.specialKeyColor
                      : widget.theme.aderenceKeyColor,
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: widget.keyItem.label != null
                  ? Text(
                      widget.viewModel.isShiftActive
                          ? widget.keyItem.label!.toUpperCase()
                          : widget.keyItem.label!,
                      style: widget.keyItem.type == KeyType.normal
                          ? widget.theme.textStyle
                          : widget.keyItem.type == KeyType.special
                              ? widget.theme.specialTextStyle
                              : widget.theme.aderenceTextStyle,
                    )
                  : Icon(widget.keyItem.icon, size: 24),
            ),
            if (widget.keyItem.label == "Shift" &&
                widget.viewModel.isShiftActive)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
