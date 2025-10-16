import 'package:condominium/auth/presentation/providers/auth_provider.dart';
import 'package:condominium/condominium/presentation/providers/condiminium_by_tech_provider.dart';
import 'package:condominium/condominium/presentation/screens/condominium_screen.dart';
import 'package:condominium/config/router/app_router_notifier.dart';
import 'package:condominium/department/presentation/screens/department_screen.dart';
import 'package:condominium/department/presentation/screens/one_department_screen.dart';
import 'package:condominium/meter/domain/entities/meter.entity.dart';
import 'package:condominium/meter/presentation/screens/screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/presentation/screens/screens.dart';
import '../../pay/presentation/screens/screens.dart';
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
          builder: (context, state) => const OwnerProfileScreen(),
        ),
        GoRoute(
          path: '/department',
          builder: (context, state) => const DepartmentScreen(),
          routes: [
            GoRoute(
              path: 'oneDepartment/:id',
              builder: (context, state) {
                final departmentId = state.pathParameters['id'] ?? 'no-id';
                return OneDepartmentScreen(
                  departmentId: departmentId,
                );
              },
            ),
          ],
        ),
        GoRoute(
            path: '/meter',
            builder: (context, state) {
              final condominiumState = ref.watch(condominiumByTechProvider);

              late String id = 'no-token';
              if (condominiumState.condominiumByTech?.id != null) {
                id = condominiumState.condominiumByTech!.id;
              }
              return MeterScreen(
                idCondominium: id,
              );
            },
            routes: [
              GoRoute(
                path: 'create-meter',
                builder: (context, state) => const CreateMeterScreen(),
              ),
              GoRoute(
                  path: 'one-meter',
                  builder: (context, state) {
                    final meter = state.extra as MeterEntity;
                    return OneMeterScreen(oneMeter: meter);
                  }),
            ]),
        GoRoute(
          path: '/pay',
          builder: (context, state) => const PayScreen(),
          routes: [
            GoRoute(
              path: 'onePay/:id',
              builder: (context, state) {
                final idParameter = state.pathParameters['id'] ?? 'no id';
                return OnePayScreen(idPay: idParameter);
              },
            ),
            GoRoute(
              path: 'listPayUnPaid',
              builder: (context, state) {
                return const ListPayUnPaidScreen();
              },
            ),
          ],
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
              // if (nameRole == 'PROPIETARIO') return '/perfil_owner';
              if (nameRole == 'PROPIETARIO') return '/pay';
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
