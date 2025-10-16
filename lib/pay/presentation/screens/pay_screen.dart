import 'package:condominium/pay/domain/domain_pay.dart';
import 'package:condominium/pay/infrastructure/mappers/payByOwner.mapper.dart';
import 'package:condominium/pay/presentation/provider/pay_by_owner_provider.dart';
import 'package:go_router/go_router.dart';

import 'package:condominium/shared/widgets/side_menu_owner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/widgets.dart';

class PayScreen extends ConsumerStatefulWidget {
  const PayScreen({super.key});

  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends ConsumerState {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      ref.read(payByOwnerProvider.notifier).loadPay();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final payByOwnerState = ref.watch(payByOwnerProvider);
    final listPayUnPaid = payByOwnerState.payUnPaid;
    final listPayProcess = payByOwnerState.payProcess;
    final listPayMade = payByOwnerState.payMade;

    final List<PayEntity> limitedPayProcess = (listPayProcess != null)
        ? listPayProcess.listPay.sublist(
            0,
            listPayProcess.listPay.length > 8
                ? 8
                : listPayProcess.listPay.length)
        : [];

    final List<PayEntity> limitedPayMade = (listPayMade != null)
        ? listPayMade.listPay.sublist(
            0, listPayMade.listPay.length > 8 ? 8 : listPayMade.listPay.length)
        : [];

    return Scaffold(
      drawer: SideMenuOwner(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Pagos'),
      ),
      body: payByOwnerState.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                listPayUnPaid == null
                    ? const Center(
                        child: Text('sin datos'),
                      )
                    : CardPay(
                        textStyles: textStyles, listPayUnPaid: listPayUnPaid),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Historial de pagos:',
                  style: textStyles.titleSmall,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: limitedPayProcess.length,
                        itemBuilder: (BuildContext context, int index) {
                          final onePay = limitedPayProcess[index];
                          return ListTile(
                            leading: Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.amber.shade700,
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            title: Text('Mes: ${onePay.month}'),
                            subtitle: Text('Año: ${onePay.year}'),
                            onTap: () {
                              context.push('/pay/onePay/${onePay.id}');
                            },
                          );
                        },
                      ),
                      const Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: limitedPayMade.length,
                        itemBuilder: (BuildContext context, int index) {
                          final onePay = limitedPayMade[index];
                          return ListTile(
                            leading: const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            ),
                            title: Text('Mes: ${onePay.month}'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            subtitle: Text('Año: ${onePay.year}'),
                            onTap: () {
                              context.push('/pay/onePay/${onePay.id}');
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
