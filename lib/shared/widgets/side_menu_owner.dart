import 'package:condominium/auth/domain/domain.dart';
import 'package:condominium/auth/presentation/providers/auth_provider.dart';
import 'package:condominium/shared/providers/drawnerProvider.dart';

import 'package:condominium/shared/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SideMenuOwner extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenuOwner({super.key, required this.scaffoldKey});

  @override
  _SideMenuOwnerState createState() => _SideMenuOwnerState();
}

class _SideMenuOwnerState extends ConsumerState<SideMenuOwner> {
  // late int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final UserEntity? user = ref.watch(authProvider.notifier).getUser();
    final navDrawerIndex = ref.watch(drawerIndexProvider);
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, hasNotch ? 40 : 20, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Saludos', style: textStyles.titleMedium),
                const SizedBox(height: 4),
                Text(user != null ? user.fullname : '',
                    style: textStyles.titleSmall),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildMenuItem(
            context,
            text: 'Mi Perfil',
            icon: Icons.home_outlined,
            onTap: () {
              ref.read(drawerIndexProvider.notifier).setIndex(0);
              context.push('/perfil_owner');
              widget.scaffoldKey.currentState?.closeDrawer();
            },
            selected: navDrawerIndex == 0,
          ),
          _buildMenuItem(
            context,
            text: 'Mis Departamentos',
            icon: Icons.maps_home_work,
            onTap: () {
              ref.read(drawerIndexProvider.notifier).setIndex(1);
              // appRouter.go('/department');
              context.push('/department');
              widget.scaffoldKey.currentState?.closeDrawer();
            },
            selected: navDrawerIndex == 1,
          ),
          _buildMenuItem(
            context,
            text: 'Mis Pagos',
            icon: Icons.paid_outlined,
            onTap: () {
             ref.read(drawerIndexProvider.notifier).setIndex(2);
              context.push('/pay');
              widget.scaffoldKey.currentState?.closeDrawer();
            },
            selected: navDrawerIndex == 2,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
            child: Text('Otras opciones'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomFilledButton(
                onPressed: () async {
                  ref.read(drawerIndexProvider.notifier).setIndex(0);
                  await ref.read(authProvider.notifier).logout();
                },
                text: 'Cerrar sesión'),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required String text,
      required IconData icon,
      required VoidCallback onTap,
      required bool selected}) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = selected
        ? TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold)
        : null;
    final iconColor = selected ? colorScheme.primary : Colors.black54;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: colorScheme.primary.withOpacity(0.2),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            color: selected
                ? colorScheme.primary.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(icon, color: iconColor),
                const SizedBox(width: 16),
                Text(text, style: textStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
