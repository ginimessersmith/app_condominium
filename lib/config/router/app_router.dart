import 'package:condominium/condominium/presentation/condominium_screen.dart';
import 'package:condominium/department/presentation/screens/department_screen.dart';
import 'package:condominium/meter/presentation/screens/meter_screen.dart';
import 'package:condominium/pay/presentation/screens/pay_screen.dart';
import 'package:condominium/perfil/presentation/perfil_owner.dart';
import 'package:condominium/perfil/presentation/perfil_techinical.dart';
import 'package:go_router/go_router.dart';

import '../../auth/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ///* Auth Routes
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

  ///! TODO: Bloquear si no se está autenticado de alguna manera
);
