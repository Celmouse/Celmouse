import 'package:controller/src/domain/models/button_settings.dart';
import 'package:controller/src/ui/mouse/viewmodel/right_button_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RightMouseButton extends StatelessWidget {
  const RightMouseButton({
    super.key,
    required this.settings,
  });

  final ButtonSettings settings;

  @override
  Widget build(BuildContext context) {
    final RightButtonViewmodel viewmodel = RightButtonViewmodel(
      mouseRepository: context.read(),
    );

    return ListenableBuilder(
      listenable: viewmodel,
      builder: (_, __) => GestureDetector(
        onTap: viewmodel.click,
        child: Container(
          width: settings.width,
          height: settings.height,
          decoration: BoxDecoration(
            borderRadius: settings.borderRadius,
            color: viewmodel.isPressed ? settings.color[200] : settings.color,
          ),
        ),
      ),
    );
  }
}
