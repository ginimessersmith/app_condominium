import 'package:condominium/perfil/presentation/screens/perfil_owner.dart';
import 'package:flutter/material.dart';

class CustomAppBarPerfil extends StatelessWidget {

  const CustomAppBarPerfil({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Nombre condominio 1'),
      trailing: Icon(Icons.arrow_forward_ios_sharp),
    );
  }
}
