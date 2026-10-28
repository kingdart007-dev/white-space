import 'package:go_router/go_router.dart';

import '../features/foundation/presentation/foundation_home_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const FoundationHomePage(),
    ),
  ],
);
