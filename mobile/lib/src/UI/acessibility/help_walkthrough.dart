import 'package:controller/src/ui/core/ui/support_button.dart';
import 'package:flutter/material.dart';

class MouseScreenHelpWalkthrough extends StatefulWidget {
  const MouseScreenHelpWalkthrough({super.key});

  @override
  State<MouseScreenHelpWalkthrough> createState() =>
      _MouseScreenHelpWalkthroughState();
}

class _MouseScreenHelpWalkthroughState
    extends State<MouseScreenHelpWalkthrough> {
  final PageController controller = PageController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (controller.page == pages.length - 1) {
        isLastPage = true;
      } else {
        isLastPage = false;
      }

      setState(() {
        isLastPage;
      });
    });
  }

  final pages = [
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.circle,
              color: Colors.red,
            ),
            SizedBox(
              width: 4,
            ),
            Text('Red button simulates de left mouse button'),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.circle,
              color: Colors.blue,
            ),
            SizedBox(
              width: 4,
            ),
            Text('Blue button simulates de right mouse button'),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.circle,
              color: Colors.green,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              'Green button turn on/off the pointer movement',
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 2,
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.circle,
              color: Colors.purple,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              'Holding Purple button will scroll',
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 2,
            ),
          ],
        ),
      ],
    ),
    Container(
      color: Colors.blue,
      child: const Center(child: Text("Thank you!")),
    ),
  ];

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    final body = SafeArea(
      child: PageView(
        controller: controller,
        children: pages
            .map((p) => SafeArea(
                  minimum: const EdgeInsets.symmetric(horizontal: 12),
                  child: p,
                ))
            .toList(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Help"),
        centerTitle: true,
        actions: const [
          SupportButtonComponent(),
        ],
      ),
      body: body,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // bottomNavigationBar: const BottomAppBar(
      //   color: Colors.blue,
      // ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton.extended(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if ((controller.page ?? 0) < 1) return;
              controller.previousPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            },
            heroTag: "BackBtn",
            label: const Text("Back"),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              if (isLastPage) {
                Navigator.pop(context);
              }
              controller.nextPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            },
            heroTag: "NextBtn",
            label: Row(
              children: [
                Text(isLastPage ? "Finish" : "Next"),
                const SizedBox(width: 6),
                Icon(isLastPage ? Icons.check : Icons.arrow_forward),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
