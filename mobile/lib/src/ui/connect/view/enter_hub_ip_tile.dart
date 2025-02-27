import 'package:controller/src/ui/connect/viewmodel/connect_hub_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EnterHubIPTile extends StatefulWidget {
  final ConnectHUBViewmodel viewmodel;

  const EnterHubIPTile({
    super.key,
    required this.viewmodel,
  });

  @override
  EnterHubIPTileState createState() => EnterHubIPTileState();
}

class EnterHubIPTileState extends State<EnterHubIPTile> {
  final TextEditingController ipController = TextEditingController();
  final List<int> ports = [6589, 8443, 7771];
  int selectedPort = 7771;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.input),
      title: const Text('Enter HUB IP Manually'),
      subtitle: const Text('Connect using its IP address'),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Enter HUB IP'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: ipController,
                  decoration: const InputDecoration(
                    labelText: 'HUB IP',
                    hintText: '192.168.0.1',
                  ),
                ),
                const SizedBox(height: 16),
                Visibility(
                  visible: kDebugMode,
                  child: DropdownButtonFormField<int>(
                    value: selectedPort,
                    decoration: const InputDecoration(
                      labelText: 'Select Port',
                    ),
                    items: ports.map((int port) {
                      return DropdownMenuItem<int>(
                        value: port,
                        child: Text(port.toString()),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedPort = newValue!;
                      });
                    },
                  ),
                ),
                ListenableBuilder(
                  listenable: widget.viewmodel,
                  builder: (BuildContext context, Widget? child) {
                    return Visibility(
                      visible: widget.viewmodel.errorMessage != null,
                      child: Center(
                        child: Text(
                          widget.viewmodel.errorMessage ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ListenableBuilder(
                listenable: widget.viewmodel,
                builder: (BuildContext context, Widget? child) {
                  return TextButton(
                    onPressed: widget.viewmodel.isConnecting
                        ? null
                        : () {
                            widget.viewmodel.connect(ipController.text);
                          },
                    child: widget.viewmodel.isConnecting
                        ? const CupertinoActivityIndicator()
                        : const Text('Connect'),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
