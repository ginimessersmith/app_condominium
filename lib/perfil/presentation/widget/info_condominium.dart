import 'package:condominium/condominium/domain/domain_condominium.dart';
import 'package:flutter/material.dart';

class InfoCondominium extends StatelessWidget {
  const InfoCondominium({
    super.key,
    required this.condominium,
  });
  final CondominiumEntity? condominium;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final String? imagenCondominium = condominium?.image;
    final String? nameCondominium = condominium?.name;
    final String? address = condominium?.address;
    final String? pantry = condominium?.pantry;
    final int? numberApartment = condominium?.numberOfApartments;
    final double? pantryValue = pantry != null ? double.tryParse(pantry) : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nameCondominium != null && nameCondominium.isNotEmpty
              ? nameCondominium
              : '',
          style: textStyle.titleMedium,
        ),
        const SizedBox(
          height: 10,
        ),
        Card(
          clipBehavior: Clip.hardEdge,
          child: imagenCondominium != null && imagenCondominium.isNotEmpty
              ? Image.network(
                  imagenCondominium,
                  height: 200,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        if (address != null && address.isNotEmpty)
          Text(
            'Direccion: $address',
            style: textStyle.bodyLarge,
          ),
        if (numberApartment != null)
          Text(
            'Numero de Departamentos: $numberApartment',
            style: textStyle.bodyLarge,
          ),
        if (pantry != null)
          Text(
            'Dispensa: ${pantryValue?.toStringAsFixed(2)}',
            style: textStyle.bodyLarge,
          )
      ],
    );
  }
}
