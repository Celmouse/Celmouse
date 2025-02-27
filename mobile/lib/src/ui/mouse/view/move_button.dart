import 'package:controller/src/domain/models/button_settings.dart';
import 'package:controller/src/ui/mouse/viewmodel/move_button_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoveMouseButton extends StatefulWidget {
  const MoveMouseButton({
    super.key,
    required this.settings,
  });

  final ButtonSettings settings;

  @override
  State<MoveMouseButton> createState() => _MoveMouseButtonState();
}

class _MoveMouseButtonState extends State<MoveMouseButton> {
  late final MoveMouseButtonViewmodel viewmodel;

  @override
  void initState() {
    viewmodel = MoveMouseButtonViewmodel(
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
        builder: (context, _) {
          return GestureDetector(
            onTap: viewmodel.toggle,
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
        });
  }
}
