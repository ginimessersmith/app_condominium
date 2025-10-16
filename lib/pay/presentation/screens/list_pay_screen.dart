import 'package:condominium/pay/domain/domain_pay.dart';
import 'package:condominium/pay/presentation/provider/pay_by_owner_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ListPayUnPaidScreen extends ConsumerWidget {
  const ListPayUnPaidScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payProvider = ref.watch(payByOwnerProvider);
    final listPayUnPaid = payProvider.payUnPaid;
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    if (listPayUnPaid == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('sin datos'),),
      );
    }
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView.builder(
          itemCount: listPayUnPaid!.listPay.length,
          itemBuilder: (BuildContext context, int index) {
            final onePay = listPayUnPaid.listPay[index];
            return ListTile(
              leading: Icon(
                Icons.monetization_on_outlined,
                color: colors.primary,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: colors.secondary,
              ),
              title: Text('Mes: ${onePay.month}'),
              subtitle: Text('Año: ${onePay.year}'),
              onTap: () {
                context.push('/pay/onePay/${onePay.id}');
              },
            );
          },
        ),
      ),
    );
  }
}
