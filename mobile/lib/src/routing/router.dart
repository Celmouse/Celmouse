import 'package:controller/src/routing/routes.dart';
import 'package:controller/src/ui/connect/view/connect_hub_page.dart';
import 'package:controller/src/ui/connect/viewmodel/connect_hub_viewmodel.dart';
import 'package:controller/src/ui/mouse/view/mouse_page.dart';
import 'package:controller/src/ui/mouse/viewmodel/mouse_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRouter router = GoRouter(
  initialLocation: Routes.connect,
  routes: [
    GoRoute(
      path: Routes.connect,
      builder: (context, state) => ConnectHUBPage(
        viewmodel: ConnectHUBViewmodel(
          connectRepository: context.read(),
        ),
      ),
    ),
    GoRoute(
      path: Routes.mouse,
      builder: (context, state) => MousePage(
        viewmodel: MouseViewmodel(
          mouseRepository: context.read(),
        ),
      ),
    ),
  ],
);
