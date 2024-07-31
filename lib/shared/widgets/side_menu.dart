import 'package:condominium/config/router/app_router.dart';
import 'package:condominium/shared/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                Text('Tennico', style: textStyles.titleSmall),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildMenuItem(
            context,
            text: 'Mi Perfil',
            icon: Icons.home_outlined,
            onTap: () {
              setState(() {
                navDrawerIndex = 0;
              });
              appRouter.go('/perfil_technical');
              widget.scaffoldKey.currentState?.closeDrawer();
            },
            selected: navDrawerIndex == 0,
          ),
          _buildMenuItem(
            context,
            text: 'Mis Mediciones',
            icon: Icons.settings_applications,
            onTap: () {
              setState(() {
                navDrawerIndex = 1;
              });
              appRouter.go('/meter');
              widget.scaffoldKey.currentState?.closeDrawer();
            },
            selected: navDrawerIndex == 1,
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
                onPressed: () {
                  appRouter.go('/login');
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
