import 'package:condominium/auth/domain/domain.dart';
import 'package:condominium/auth/presentation/providers/auth_provider.dart';
import 'package:condominium/condominium/presentation/providers/condominium_provider.dart';
import 'package:condominium/condominium/presentation/providers/selected_condominium_provider.dart';
import 'package:condominium/perfil/presentation/widget/widget.dart';
import 'package:condominium/shared/widgets/side_menu_owner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OwnerProfileScreen extends ConsumerStatefulWidget {
  const OwnerProfileScreen({super.key});

  @override
  _OwnerProfileScreenState createState() => _OwnerProfileScreenState();
}

class _OwnerProfileScreenState extends ConsumerState<OwnerProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCondominium = ref.watch(selectedCondominiumProvider);

    final UserEntity? user = ref.read(authProvider.notifier).getUser();
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenuOwner(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: CustomDropDownPerfil(),
      ),
      body: CustomPerfilUser(
        user: user!,
        selectedCondominium: selectedCondominium,
      ),
      // floatingActionButton:,
    );
  }
}
