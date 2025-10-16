import 'package:animate_do/animate_do.dart';
import 'package:condominium/meter/domain/entities/meter.entity.dart';
import 'package:condominium/shared/shared.dart';
import 'package:flutter/material.dart';

class OneMeterScreen extends StatelessWidget {
  final MeterEntity oneMeter;
  const OneMeterScreen({required this.oneMeter});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            clipBehavior: Clip.hardEdge,
            elevation: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Detalles de la medicion',
                        style: textStyle.titleSmall,
                      ),
                      FadeInRight(
                        duration: const Duration(seconds: 1),
                        child: Icon(
                          Icons.water_drop_outlined,
                          color: colors.primary,
                        ),
                      )
                    ],
                  ),
                ),
                _InfoRowMeter(
                  dataOne: 'Mes',
                  dataTwo: oneMeter.month,
                ),
                _InfoRowMeter(
                  dataOne: 'Año',
                  dataTwo: oneMeter.year.toString(),
                ),
                _InfoRowMeter(
                  dataOne: 'Consumo',
                  dataTwo: Helpers.formattedText(oneMeter.consummation),
                ),
                // _InfoRowMeter(
                //   dataOne: 'Consumo',
                //   dataTwo: Helpers.formattedText(oneMeter.consummation),
                // ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Divider(),
                ),
                _InfoRowMeter(
                  dataOne: 'Bloque del Departamento',
                  dataTwo: oneMeter.department!.block,
                ),
                _InfoRowMeter(
                  dataOne: 'Piso del departamento',
                  dataTwo: oneMeter.department!.floor.toString(),
                ),
                _InfoRowMeter(
                  dataOne: 'Numero del departamento',
                  dataTwo: oneMeter.department!.numberDepartment.toString(),
                ),
                _InfoRowMeter(
                  dataOne: 'Huespedes del departamento',
                  dataTwo: oneMeter.department!.guestNumber.toString(),
                ),
                SizedBox(
                  height: 20,
                ),
                if (oneMeter.imgUrl != null)
                  oneMeter.imgUrl!.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            oneMeter.imgUrl!,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return const Text(
                                'Imagen no disponible',
                                style: TextStyle(color: Colors.red),
                              ); // O usa un ícono o imagen de respaldo aquí.
                            },
                          ),
                        )
                      : Text(''),
              ],
            ),
          ),
        ));
  }
}

class _InfoRowMeter extends StatelessWidget {
  final String dataOne;
  final String dataTwo;
  const _InfoRowMeter({
    super.key,
    required this.dataOne,
    required this.dataTwo,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dataOne,
            style: textStyle.bodyLarge,
          ),
          Text(
            dataTwo,
            style: textStyle.bodyLarge,
          ),
        ],
      ),
    );
  }
}
