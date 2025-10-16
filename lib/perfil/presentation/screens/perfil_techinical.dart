import 'package:condominium/auth/domain/entities/user.entity.dart';
import 'package:condominium/auth/presentation/providers/auth_provider.dart';
import 'package:condominium/condominium/presentation/providers/condiminium_by_tech_provider.dart';
import 'package:condominium/perfil/presentation/widget/widget.dart';
import 'package:condominium/shared/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TechnicianProfileScreen extends ConsumerStatefulWidget {
  @override
  _TechnicianProfileScreenState createState() =>
      _TechnicianProfileScreenState();
}

class _TechnicianProfileScreenState
    extends ConsumerState<TechnicianProfileScreen> {
  late bool loadCondominium;
  late String messageByProvider;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        ref.read(condominiumByTechProvider.notifier).loadCondominiumByTech());
    loadCondominium = false;
    messageByProvider = '';
  }

  @override
  Widget build(BuildContext context) {
    final condominiumByTech = ref.watch(condominiumByTechProvider);

    final UserEntity? user = ref.read(authProvider.notifier).getUser();
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          // Aquí podrías agregar lógica para manejar el estado de carga
          title: condominiumByTech.isLoading
              ? const LinearProgressIndicator()
              : condominiumByTech.errorMessage.isEmpty
                  ? Text('${condominiumByTech.condominiumByTech?.name}')
                  : Text(condominiumByTech.errorMessage),
        ),
        body: CustomPerfilUser(
          selectedCondominium: condominiumByTech.condominiumByTech,
          user: user!,
        ));
  }
}
