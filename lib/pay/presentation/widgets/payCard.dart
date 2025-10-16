import 'package:animate_do/animate_do.dart';
import 'package:condominium/pay/infrastructure/mappers/payByOwner.mapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardPay extends StatelessWidget {
  const CardPay({
    super.key,
    required this.textStyles,
    required this.listPayUnPaid,
  });

  final TextTheme textStyles;
  final PayByOwner? listPayUnPaid;

  @override
  Widget build(BuildContext context) {
    if (listPayUnPaid == null) {
      return const Center(
        child: Text('Sin datos de las deudas'),
      );
    }

    if (listPayUnPaid!.listPay.isEmpty) {
      return Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Sin deudas',
              style: textStyles.titleSmall,
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deudas',
                style: textStyles.titleSmall,
              ),
              Row(
                children: [
                  Text(
                    'Total a Pagar',
                    style: textStyles.bodyLarge!
                        .copyWith(color: Colors.grey.shade700),
                  ),
                  const Spacer(),
                  SpinPerfect(
                    duration: const Duration(seconds: 15),
                    // spins: 2,
                    infinite: true,
                    child: const Icon(
                      Icons.dangerous_outlined,
                      color: Colors.red,
                      size: 35,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Bs ${listPayUnPaid!.total.toStringAsFixed(2)}',
                    style: textStyles.titleLarge,
                  ),
                ],
              ),
              Text(
                'Pagos Pendientes: ${listPayUnPaid!.listPay.length}',
                style: textStyles.bodyLarge!.copyWith(color: Colors.red),
              ),
              ListTile(
                // leading: Icon(Icons.dangerous),
                title: Text(
                  'Ver mis deudas',
                  style: textStyles.bodyLarge,
                ),
                // subtitle: Text('subtitulo'),
                trailing: const Icon(Icons.arrow_forward_ios_sharp),
                onTap: () {
                  context.push('/pay/listPayUnPaid');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
