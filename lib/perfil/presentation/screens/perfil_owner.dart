import 'package:condominium/auth/domain/domain.dart';
import 'package:condominium/auth/presentation/providers/auth_provider.dart';
import 'package:condominium/perfil/presentation/widget/custom_appBar_profile.widget.dart';
import 'package:condominium/shared/widgets/side_menu_owner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OwnerProfileScreen extends ConsumerWidget {
  const OwnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final UserEntity? user = ref.read(authProvider.notifier).getUser();
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      drawer: SideMenuOwner(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: CustomDropDownPerfil(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (user != null) Text('user: ${user.fullname}'),
          ],
        ),
      ),
      // floatingActionButton:,
    );
  }
}

class CustomDropDownPerfil extends StatefulWidget {
  const CustomDropDownPerfil({
    super.key,
  });

  @override
  State<CustomDropDownPerfil> createState() => _CustomDropDownPerfilState();
}

class _CustomDropDownPerfilState extends State<CustomDropDownPerfil> {
  // final List<Condominium> condominiums;
  @override
  Widget build(BuildContext context) {
    // Condominium firstCondominium = con
    return Text('dropdown propietario');
  }
}
