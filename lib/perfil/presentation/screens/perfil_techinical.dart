import 'package:condominium/auth/domain/entities/user.entity.dart';
import 'package:condominium/auth/presentation/providers/auth_provider.dart';
import 'package:condominium/shared/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TechnicianProfileScreen extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final UserEntity? user = ref.read(authProvider.notifier).getUser();
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: Text('Bienvenido tecnico'),
        centerTitle: true,
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
