import 'package:animate_do/animate_do.dart';
import 'package:condominium/auth/domain/domain.dart';
import 'package:condominium/condominium/domain/domain_condominium.dart';
import 'package:condominium/perfil/presentation/widget/widget.dart';
import 'package:flutter/material.dart';

class CustomPerfilUser extends StatelessWidget {
  const CustomPerfilUser({
    super.key,
    required this.user,
    required this.selectedCondominium,
  });

  final UserEntity user;
  final CondominiumEntity? selectedCondominium;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final String? profileImageUrl = user.photoUrl;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (user.role.name == 'PROPIETARIO')
            SpinPerfect(
              duration: const Duration(seconds: 10),
              infinite: true,
              child: Icon(
                Icons.wifi_protected_setup_outlined,
                color: colors.primary,
              ),
            ),
          Row(
            children: [
              const Spacer(),
              if (user.role.name == 'TECNICO')
                FilledButton.icon(
                  onPressed: () {},
                  icon: SpinPerfect(
                    infinite: true,
                    duration: const Duration(seconds: 15),
                    child: const Icon(Icons.settings),
                  ),
                  label: const Text('Tecnico'),
                ),
            ],
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    profileImageUrl != null && profileImageUrl.isNotEmpty
                        ? NetworkImage(profileImageUrl)
                        : null,
                child: profileImageUrl == null || profileImageUrl.isEmpty
                    ? Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.grey.shade500,
                      )
                    : null,
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                  child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullname,
                        style: textStyle.titleMedium,
                      ),
                      Text(
                        user.email,
                        style: textStyle.bodyLarge,
                      ),
                      if (user.phone != null && user.codeCountry != null)
                        Text(
                          '+(${user.codeCountry}) ${user.phone}',
                          style: textStyle.bodyLarge,
                        ),
                    ],
                  ),
                ),
              )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            thickness: 2,
          ),
          if (selectedCondominium != null)
            Text(
              'Informacion de su condominio:',
              style: textStyle.bodyLarge,
              overflow: TextOverflow.visible,
              maxLines: 1,
            ),
          InfoCondominium(condominium: selectedCondominium)
        ],
      ),
    );
  }
}
