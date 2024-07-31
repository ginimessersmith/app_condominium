import 'package:condominium/shared/shared.dart';
import 'package:flutter/material.dart';

class MeterScreen extends StatefulWidget {
  @override
  _MeterScreenState createState() => _MeterScreenState();
}

class _MeterScreenState extends State<MeterScreen> {
  String? selectedMonth;
  double? consummation;
  String? selectedYear;
  String? selectedDepartment;

  final List<String> months = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];

  final List<String> departments = [
    'Departamento 101, Bloque A, Vista Verde',
    'Departamento 202, Bloque B, Vista Azul'
  ];

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Crear Medición'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Mes',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.blueAccent.withOpacity(0.1),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 4), // Ajustar el padding aquí
              ),
              items: months.map((month) {
                return DropdownMenuItem(
                  value: month,
                  child: Text(month, style: textStyles.bodyText2),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMonth = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Consumo (m³)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.blueAccent.withOpacity(0.1),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 4), // Ajustar el padding aquí
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  consummation = double.tryParse(value);
                });
              },
              style: textStyles.bodyText2,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Año',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.blueAccent.withOpacity(0.1),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 4), // Ajustar el padding aquí
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  selectedYear = value;
                });
              },
              style: textStyles.bodyText2,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Departamento',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.blueAccent.withOpacity(0.1),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 4), // Ajustar el padding aquí
              ),
              items: departments.map((department) {
                return DropdownMenuItem(
                  value: department,
                  child: Text(department, style: textStyles.bodyText2),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDepartment = value;
                });
              },
            ),
            const Spacer(),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: const Text(
                'Crear Medición',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Exito'),
                      content: Text('La medicion fue creada'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Ok'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
