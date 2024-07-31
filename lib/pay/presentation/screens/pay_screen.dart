import 'package:condominium/shared/widgets/side_menu_owner.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class PayScreen extends StatelessWidget {
  final List<Map<String, dynamic>> payments = [
    {
      "id": "0cf38e9e-312b-446a-b5e6-3745cf3aff7d",
      "month": "Septiembre",
      "year": 2024,
      "isActive": true,
      "pay_of_service": "15.929204",
      "total_to_pay": "25.929204",
      "porcent": "53.097345",
      "pantry": "10.000000",
      "consummation": "150.000000",
      "state": 2,
      "reverse": false,
      "create_at": "2024-07-25T23:38:47.531Z",
      "update_at": "2024-07-25T23:38:47.531Z"
    },
    {
      "id": "1cf38e9e-312b-446a-b5e6-3745cf3aff7d",
      "month": "Agosto",
      "year": 2024,
      "isActive": true,
      "pay_of_service": "10.123456",
      "total_to_pay": "20.123456",
      "porcent": "40.567890",
      "pantry": "5.000000",
      "consummation": "120.000000",
      "state": 1,
      "reverse": false,
      "create_at": "2024-06-25T23:38:47.531Z",
      "update_at": "2024-06-25T23:38:47.531Z"
    },
    {
      "id": "2cf38e9e-312b-446a-b5e6-3745cf3aff7d",
      "month": "Julio",
      "year": 2024,
      "isActive": true,
      "pay_of_service": "12.987654",
      "total_to_pay": "22.987654",
      "porcent": "50.123456",
      "pantry": "8.000000",
      "consummation": "130.000000",
      "state": 3,
      "reverse": false,
      "create_at": "2024-05-25T23:38:47.531Z",
      "update_at": "2024-05-25T23:38:47.531Z"
    }
  ];

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenuOwner(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Pagos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: payments.length,
          itemBuilder: (context, index) {
            final payment = payments[index];
            return PaymentCard(
              payment: payment,
              textStyles: textStyles,
              colors: colors,
            );
          },
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  final Map<String, dynamic> payment;
  final TextTheme textStyles;
  final ColorScheme colors;

  const PaymentCard({
    required this.payment,
    required this.textStyles,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final state = payment['state'];
    Color stateColor;
    String stateText;
    IconData stateIcon;

    switch (state) {
      case 1:
        stateColor = Colors.red;
        stateText = 'Impaga';
        stateIcon = Icons.warning_amber_rounded;
        break;
      case 2:
        stateColor = Colors.orange;
        stateText = 'Procesado';
        stateIcon = Icons.sync;
        break;
      case 3:
        stateColor = Colors.green;
        stateText = 'Pagado';
        stateIcon = Icons.check_circle_outline;
        break;
      default:
        stateColor = Colors.grey;
        stateText = 'Desconocido';
        stateIcon = Icons.help_outline;
    }

    final totalToPay = double.parse(payment['total_to_pay']);
    final consummation = double.parse(payment['consummation']);
    final porcent = double.parse(payment['porcent']);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(stateIcon, color: stateColor),
              const SizedBox(width: 8),
              Text(
                '${payment['month']} ${payment['year']}',
                style: textStyles.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Total a pagar: \$${totalToPay.toStringAsFixed(2)}',
            style: textStyles.titleSmall,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.water_damage, color: colors.primary),
              const SizedBox(width: 8),
              Text(
                '${consummation.toStringAsFixed(2)} m³',
                style: textStyles.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.pie_chart, color: colors.primary),
              const SizedBox(width: 8),
              Text(
                '${porcent.toStringAsFixed(2)}%',
                style: textStyles.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Estado: $stateText',
            style: textStyles.bodyMedium?.copyWith(color: stateColor),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  theme: ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Colors.blueAccent,
      surface: Colors.white,
    ),
  ),
  home: PayScreen(),
));
