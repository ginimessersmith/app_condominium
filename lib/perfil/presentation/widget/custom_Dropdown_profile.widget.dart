
import 'package:condominium/condominium/presentation/providers/condominium_provider.dart';
import 'package:condominium/condominium/presentation/providers/selected_condominium_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDropDownPerfil extends ConsumerStatefulWidget {
  const CustomDropDownPerfil({
    super.key,
  });

  @override
  ConsumerState<CustomDropDownPerfil> createState() =>
      _CustomDropDownPerfilState();
}

class _CustomDropDownPerfilState extends ConsumerState<CustomDropDownPerfil> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => ref.read(condoniumProvider.notifier).listCondominium());
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final condominium = ref.watch(condoniumProvider);
    final listCondominium = condominium.listCondominium;
    final selectedCondominium = ref.watch(selectedCondominiumProvider);
    final String? id = selectedCondominium?.id;

    if (condominium.isLoading) {
      return const LinearProgressIndicator();
    }

    if (listCondominium.isEmpty) {
      return const Text('Sin datos');
    }

    if (selectedCondominium == null && listCondominium.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(selectedCondominiumProvider.notifier).state = listCondominium.first;
      });
    }

    return DropdownButton(
      value: id ?? listCondominium.first.id,
      onChanged: (String? value) {
        final selectedCondominium =
            listCondominium.firstWhere((condo) => condo.id == value);
        ref.read(selectedCondominiumProvider.notifier).state =
            selectedCondominium;
      },
      items: listCondominium.map<DropdownMenuItem<String>>(
        (condominium) {
          return DropdownMenuItem<String>(
            value: condominium.id,
            child: Text(
              condominium.name,
              style: textStyles.titleSmall,
            ),
          );
        },
      ).toList(),
    );
  }
}
