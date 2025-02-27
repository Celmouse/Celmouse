import 'package:controller/getit.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/mouse_settings_model.dart';

/// Page where you can change the cursor settings
///
/// Inverter eixos do ponteiro
/// Inverter eixos do scroll
/// Alterar sensibilidade do ponteiro
/// Alterar sensibilidade do scroll
///
/// Velocidade do duplo clique
/// Reduzir vibração
/// Atraso para pressionar e segurar
class CursorSettingsPage extends StatefulWidget {
  const CursorSettingsPage({
    super.key,
    // required this.channel,
  });

  // final WebSocketChannel channel;

  @override
  State<CursorSettingsPage> createState() => _CursorSettingsPageState();
}

class _CursorSettingsPageState extends State<CursorSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          minimum: const EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 10,
          ),
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  "Settings",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                trailing: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                    )),
              ),
              Text(
                'Pointer',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SwitchListTile(
                title: Text(
                  "Invert vertical axis:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                value: getIt.get<MouseSettings>().invertedPointerY,
                onChanged: (value) {
                  setState(() {
                    getIt.get<MouseSettings>().invertedPointerY = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text(
                  "Invert horizontal axis:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                value: getIt.get<MouseSettings>().invertedPointerX,
                onChanged: (value) {
                  setState(() {
                    getIt.get<MouseSettings>().invertedPointerX = value;
                  });
                },
              ),
              ListTile(
                title: Text(
                  'Sensitivity:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Slider(
                label: getIt.get<MouseSettings>().sensitivity.toString(),
                value: getIt.get<MouseSettings>().sensitivity.toDouble(),
                min: 1,
                divisions: 9,
                max: 10,
                onChanged: (amount) {
                  setState(() {
                    getIt.get<MouseSettings>().sensitivity = amount.round();
                  });
                },
              ),
              SwitchListTile(
                title: Text(
                  "Keep moving after scroll:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                value: getIt.get<MouseSettings>().keepMovingAfterScroll,
                onChanged: (value) {
                  setState(() {
                    getIt.get<MouseSettings>().keepMovingAfterScroll = value;
                  });
                },
              ),

              /// Scroll configurations
              Text(
                'Scroll',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SwitchListTile(
                title: Text(
                  "Invert vertical axis:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                value: getIt.get<MouseSettings>().invertedScrollY,
                onChanged: (value) {
                  setState(() {
                    getIt.get<MouseSettings>().invertedScrollY = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text(
                  "Invert horizontal axis:",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                value: getIt.get<MouseSettings>().invertedScrollX,
                onChanged: (value) {
                  setState(() {
                    getIt.get<MouseSettings>().invertedScrollX = value;
                  });
                },
              ),
              ListTile(
                title: Text(
                  'Sensitivity:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Slider(
                label: getIt.get<MouseSettings>().scrollSensitivity.toString(),
                value: getIt.get<MouseSettings>().scrollSensitivity.toDouble(),
                min: 1,
                divisions: 9,
                max: 10,
                onChanged: (amount) {
                  setState(() {
                    getIt.get<MouseSettings>().scrollSensitivity =
                        amount.round();
                  });
                  // mouse.changeScrollSensitivity(amount.round());
                },
              ),
              Text(
                'Click',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              ListTile(
                title: Text(
                  'Double click speed:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                alignment: Alignment.center,
                isExpanded: true,
                value: getIt.get<MouseSettings>().doubleClickDelayMS.duration,
                items: DoubleClickDelayOptions.values
                    .map((o) => DropdownMenuItem(
                          alignment: Alignment.center,
                          value: o.duration,
                          child: Text(
                            o.text,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    getIt.get<MouseSettings>().doubleClickDelayMS =
                        DoubleClickDelayOptions.values.firstWhere(
                      (v) => v.duration == value,
                    );
                  });
                },
              ),

              ExpansionTile(
                title: Text(
                  'Advanced options',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                children: [
                  ListTile(
                    title: Text(
                      'Reduce vibration:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    alignment: Alignment.center,
                    isExpanded: true,
                    value: getIt.get<MouseSettings>().vibrationThreshold.value,
                    items: ReduceVibrationOptions.values
                        .map((o) => DropdownMenuItem(
                              alignment: Alignment.center,
                              value: o.value,
                              child: Text(
                                o.text,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        getIt.get<MouseSettings>().vibrationThreshold =
                            ReduceVibrationOptions.values.firstWhere(
                          (v) => v.value == value,
                        );
                      });
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Press and Hold delay:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    alignment: Alignment.center,
                    isExpanded: true,
                    value: getIt.get<MouseSettings>().dragStartDelayMS.duration,
                    items: DragStartDelayOptions.values
                        .map((o) => DropdownMenuItem(
                              alignment: Alignment.center,
                              value: o.duration,
                              child: Text(
                                o.text,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        getIt.get<MouseSettings>().dragStartDelayMS =
                            DragStartDelayOptions.values.firstWhere(
                          (v) => v.duration == value,
                        );
                      });
                    },
                  ),
                ],
              ),

              /// Layout
              Visibility(
                visible: false,
                child: Text(
                  'Layout',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(
                height: 42,
              ),
            ],
          )),
    );
  }
}
/*

              RotatedBox(
                quarterTurns: -1,
                child: Slider(
                  label: sensibilidade.toStringAsFixed(2),
                  value: sensibilidade,
                  min: 0.01,
                  max: 1,
                  onChanged: (v) {
                    setState(() {
                      sensibilidade = v;
                    });

                    var data = {"changeSensitivityEvent": v};
                    widget.channel.sink.add(jsonEncode(data));
                  },
                ),
              ),
*/
