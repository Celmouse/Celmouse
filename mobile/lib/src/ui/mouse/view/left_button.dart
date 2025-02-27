
import 'package:controller/src/domain/models/button_settings.dart';
import 'package:controller/src/ui/mouse/viewmodel/left_button_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeftMouseButton extends StatelessWidget {
  const LeftMouseButton({
    super.key,
    required this.settings,
  });

  final ButtonSettings settings;

  @override
  Widget build(BuildContext context) {
    final LeftButtonViewmodel viewmodel = LeftButtonViewmodel(
      mouseRepository: context.read(),
    );

    return ListenableBuilder(
      listenable: viewmodel,
      builder: (_, __) => GestureDetector(
        onTap: viewmodel.click,
        // onTapDown: (_)=> viewmodel.hold(),
        // onTapUp: (_)=> viewmodel.release(),
        child: Container(
          width: settings.width,
          height: settings.height,
          decoration: BoxDecoration(
            borderRadius: settings.borderRadius,
            color: viewmodel.isPressed
                ? settings.color[200]
                : settings.color,
          ),
        ),
      ),
    );
  }
}
