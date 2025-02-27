import 'dart:async';

import 'package:controller/src/UI/trackpad/viewmodel/trackpad_viewmodel.dart';
import 'package:controller/src/ui/ads/view/banner.dart';
import 'package:controller/src/ui/mouse_move/view/components/mouse_mode_switch.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TrackPad extends StatefulWidget {
  const TrackPad({
    super.key,
    required this.currentIndex,
    required this.onToggle,
  });

  final int currentIndex;
  final void Function(int) onToggle;
  @override
  State<TrackPad> createState() => _TrackPadState();
}

class _TrackPadState extends State<TrackPad> {
  late final TrackPadViewModel viewModel;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
    viewModel = TrackPadViewModel(
      mouseRepository: context.read(),
    );
    super.initState();
  }

  bool _isMoving = false;

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  Size lastMovimentDelta = const Size(0, 0);

  @override
  Widget build(BuildContext context) {
    final body = ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TouchpadGestureDetector(
                onStartMoving: (details) {
                  _isMoving = true;
                  viewModel.startDragging(
                    details.localPosition.dx,
                    details.localPosition.dy,
                  );
                },
                onMove: (details) {
                  if (!_isMoving) return;

                  final x = details.delta.dx;
                  final y = details.delta.dy;

                  viewModel.updateDragging(x, y);
                  lastMovimentDelta = Size(x, y);
                },
                onEndMoving: (details) {
                  _isMoving = false;
                  viewModel.updateDragging(lastMovimentDelta.width * -1,
                      lastMovimentDelta.height * -1);
                  viewModel.stopDragging();
                },
                onCancelMove: () {
                  _isMoving = false;
                },
                onRightClick: () {
                  viewModel.handleTwoFingerTap();
                },
                onClick: () {
                  viewModel.handleTap();
                },
                onDoubleClick: () {
                  viewModel.handleDoubleTap();
                },
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    color: viewModel.backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      //TODO: Add this as optional
                      Visibility(
                        visible: false,
                        child: Positioned(
                          left: viewModel.mouseX - 50,
                          top: viewModel.mouseY - 50,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: viewModel.dotColor,
                              boxShadow: viewModel.isDragging ||
                                      viewModel.isTapped ||
                                      viewModel.isDoubleTapped ||
                                      viewModel.isTwoFingerTapped
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.2),
                                        offset: const Offset(5, 5),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      ),
                                      const BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(-5, -5),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : [
                                      const BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(-2, -2),
                                        blurRadius: 5,
                                      ),
                                      BoxShadow(
                                        color: Colors.grey[300]!,
                                        offset: const Offset(2, 2),
                                        blurRadius: 5,
                                      ),
                                    ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });

    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return Column(
          children: [
            MouseModeSwitch(
              onToggle: widget.onToggle,
              currentIndex: widget.currentIndex,
            ),
            const SizedBox(
              height: 12,
            ),
            body,
            const SizedBox(
              height: 12,
            ),
            BannerAdWidget(
              orientation: orientation,
            ),
          ],
        );
      } else {
        return Row(
          children: [
            SizedBox(
              width: 250,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MouseModeSwitch(
                      onToggle: widget.onToggle,
                      currentIndex: widget.currentIndex,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    BannerAdWidget(
                      orientation: orientation,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            body,
          ],
        );
      }
    });
  }
}

class TwoFingerDoubleTapGestureRecognizer extends OneSequenceGestureRecognizer {
  VoidCallback? onTwoFingerDoubleTap;

  final List<PointerDownEvent> _pointerEvents = [];
  static const int _maxPointers = 2;

  @override
  void addPointer(PointerEvent event) {
    if (event is PointerDownEvent) {
      _pointerEvents.add(event);
    }
    startTrackingPointer(event.pointer);
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerDownEvent) {
      Timer(const Duration(milliseconds: 100), () {
        _pointerEvents.clear();
      });
      if (_pointerEvents.length == _maxPointers) {
        if (onTwoFingerDoubleTap != null) {
          onTwoFingerDoubleTap!();
        }
      }
    } else {
      _pointerEvents.clear();
    }
  }

  @override
  String get debugDescription => 'TwoFingerDoubleTap';

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  void stopTrackingPointer(int pointer) {
    super.stopTrackingPointer(pointer);
  }

  @override
  void resolve(GestureDisposition disposition) {
    super.resolve(disposition);
  }
}

class TouchpadGestureDetector extends StatelessWidget {
  const TouchpadGestureDetector({
    super.key,
    required this.child,
    required this.onClick,
    required this.onRightClick,
    required this.onDoubleClick,
    this.onMove,
    this.onEndMoving,
    this.onStartMoving,
    this.onCancelMove,
  });

  final Widget child;
  final VoidCallback onRightClick;
  final VoidCallback onClick;
  final VoidCallback onDoubleClick;
  final void Function(DragStartDetails)? onStartMoving;
  final void Function(DragUpdateDetails)? onMove;
  final void Function()? onCancelMove;
  final void Function(DragEndDetails)? onEndMoving;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        PanGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
          () => PanGestureRecognizer(),
          (PanGestureRecognizer instance) {
            instance
              ..onStart = onStartMoving
              ..onUpdate = onMove
              ..onCancel = onCancelMove
              ..onEnd = onEndMoving;
          },
        ),
        DoubleTapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<DoubleTapGestureRecognizer>(
          () => DoubleTapGestureRecognizer(),
          (DoubleTapGestureRecognizer instance) {
            instance.onDoubleTap = onDoubleClick;
          },
        ),
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () => TapGestureRecognizer(),
          (TapGestureRecognizer instance) {
            instance.onTap = onClick;
          },
        ),
        TwoFingerDoubleTapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<
                TwoFingerDoubleTapGestureRecognizer>(
          () => TwoFingerDoubleTapGestureRecognizer(),
          (
            TwoFingerDoubleTapGestureRecognizer instance,
          ) {
            instance.onTwoFingerDoubleTap = onRightClick;
          },
        ),
      },
      child: child,
    );
  }
}
