import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/auth/presentation/pages/sign_in_page.dart';
import 'package:film_link/features/auth/presentation/pages/sign_up_page.dart';
import 'package:film_link/features/auth/presentation/providers/auth_providers.dart';
import 'package:film_link/features/links/presentation/pages/links_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// App routes
class AppRoutes {
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String links = '/links';
  static const String archive = '/archive';
}

/// Router provider
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.signIn,
    redirect: (context, state) async {
      final getCurrentUser = ref.read(getCurrentUserUseCaseProvider);
      final result = await getCurrentUser(const NoParams());
      
      final isAuthenticated = result.fold(
        (_) => false,
        (user) => user != null,
      );
      
      final isAuthRoute = state.matchedLocation == AppRoutes.signIn ||
          state.matchedLocation == AppRoutes.signUp;
      
      if (!isAuthenticated && !isAuthRoute) {
        return AppRoutes.signIn;
      }
      
      if (isAuthenticated && isAuthRoute) {
        return AppRoutes.links;
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: AppRoutes.links,
        builder: (context, state) => const LinksPage(),
      ),
    ],
  );
});
