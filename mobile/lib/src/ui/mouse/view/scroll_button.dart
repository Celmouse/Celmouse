import 'package:controller/src/domain/models/button_settings.dart';
import 'package:controller/src/ui/mouse/viewmodel/scroll_button_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScrollMouseButton extends StatefulWidget {
  const ScrollMouseButton({
    super.key,
    required this.settings,
  });

  final ButtonSettings settings;

  @override
  State<ScrollMouseButton> createState() => _ScrollMouseButtonState();
}

class _ScrollMouseButtonState extends State<ScrollMouseButton> {
  late final ScrollMouseButtonViewmodel viewmodel;

  @override
  void initState() {
    viewmodel = ScrollMouseButtonViewmodel(
      mouseReposiry: context.read(),
    );
    super.initState();
  }

  @override
  void dispose() {
    viewmodel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewmodel.isActive,
      builder: (_, __) {
        return GestureDetector(
          onTapDown: (_) => viewmodel.toggle(),
          onTapUp: (_) => viewmodel.toggle(),
          child: Container(
            width: widget.settings.width,
            height: widget.settings.height,
            decoration: BoxDecoration(
              borderRadius: widget.settings.borderRadius,
              color: viewmodel.isActive.value
                  ? widget.settings.color[200]
                  : widget.settings.color,
            ),
          ),
        );
      },
    );
  }
}
