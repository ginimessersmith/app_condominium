import 'package:condominium/auth/presentation/providers/auth_provider.dart';
import 'package:condominium/condominium/presentation/condominium_screen.dart';
import 'package:condominium/config/router/app_router_notifier.dart';
import 'package:condominium/department/presentation/screens/department_screen.dart';
import 'package:condominium/meter/presentation/screens/meter_screen.dart';
import 'package:condominium/pay/presentation/screens/pay_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/presentation/screens/screens.dart';
import '../../perfil/presentation/screens/screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  String? nameRole;
  return GoRouter(
      initialLocation: '/splash',
      refreshListenable: goRouterNotifier,
      routes: [
        ///* Auth Routes
        GoRoute(
          path: '/splash',
          builder: (context, state) => const CheckAuthStatusScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/condominium',
          builder: (context, state) => CondominiumScreen(),
        ),
        GoRoute(
          path: '/perfil_technical',
          builder: (context, state) => TechnicianProfileScreen(),
        ),
        GoRoute(
          path: '/perfil_owner',
          builder: (context, state) => OwnerProfileScreen(),
        ),
        GoRoute(
          path: '/department',
          builder: (context, state) => DepartmentScreen(),
        ),
        GoRoute(
          path: '/meter',
          builder: (context, state) => MeterScreen(),
        ),
        GoRoute(
          path: '/pay',
          builder: (context, state) => PayScreen(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const LoginScreen(),
        ),
      ],
      redirect: (context, state) {
        nameRole = ref.read(authProvider.notifier).getUserRole();
        final isGoinTo = state.matchedLocation;
        final authStatus = goRouterNotifier.authStatus;

        if (isGoinTo == '/splash' && authStatus == AuthStatus.checking) {
          return null;
        }
        if (isGoinTo == '/splash' &&
            authStatus == AuthStatus.notAuthenticated) {
          if (isGoinTo == '/login') {
            return null;
          } else {
            return '/login';
          }
        }

        if (authStatus == AuthStatus.authenticated) {
          if (isGoinTo == '/login' || isGoinTo == '/splash') {
            if (nameRole != null) {
              if (nameRole == 'TECNICO') return '/perfil_technical';
              if (nameRole == 'PROPIETARIO') return '/perfil_owner';
            } else {
              return '/login';
            }
          }
        }

        if (authStatus == AuthStatus.notAuthenticated) {
          if (isGoinTo == '/login') return null;
          return '/login';
        }

        return null;
      });
});
