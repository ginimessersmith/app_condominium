import 'package:condominium/shared/widgets/side_menu_owner.dart';
import 'package:flutter/material.dart';

class DepartmentScreen extends StatelessWidget {
  const DepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulando la data recibida del JSON
    final List<Map<String, dynamic>> departments = [
      {
        "id": "6301bb45-c969-4360-92a4-09a38a52e2a5",
        "block": "C",
        "floor": 2,
        "number_department": 23,
        "guest_number": 2,
        "bedroom_number": 2,
        "isActive": true,
        "created_at": "2024-05-27T02:30:54.163Z",
        "updated_at": "2024-05-27T02:30:54.163Z",
        "condominium": {
          "id": "ac7bb731-882f-4989-8e5c-506c2eef6161",
          "name": "Vista Verde2",
          "address": "Av. Banzer",
          "latitude": "17.898989",
          "longitude": "-18.020393",
          "pantry": "10.000000",
          "image": "./fotos",
          "meter_number": "3A",
          "isActive": true,
          "number_of_apartments": 3,
          "created_at": "2024-05-01T22:04:56.281Z",
          "updated_at": "2024-05-01T22:04:56.281Z",
        },
        "meter": [
          {
            "id": "3ed899a8-ad4d-4215-8d6b-ddb33c9d5cde",
            "month": "Septiembre",
            "isActive": true,
            "state": 2,
            "year": 2024,
            "consummation": "150.000000",
            "img_url": null,
            "create_at": "2024-06-05T18:48:23.086Z",
            "update_at": "2024-06-05T18:48:23.086Z"
          }
        ],
        "pay": [
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
          }
        ]
      },
      {
        "id": "59523671-be8b-40fd-b9d5-bd057e915a88",
        "block": "A",
        "floor": 12,
        "number_department": 123,
        "guest_number": 5,
        "bedroom_number": 4,
        "isActive": true,
        "created_at": "2024-07-25T20:48:57.498Z",
        "updated_at": "2024-07-25T20:48:57.498Z",
        "condominium": {
          "id": "03aec9f1-457c-46f8-b4f4-e6eb2c0a9d92",
          "name": "Vista Verde3",
          "address": "Av. Banzer",
          "latitude": "17.898989",
          "longitude": "-18.020393",
          "pantry": "50.000000",
          "image": "./fotos",
          "meter_number": "3",
          "isActive": true,
          "number_of_apartments": 3,
          "created_at": "2024-05-30T21:22:15.418Z",
          "updated_at": "2024-05-30T21:22:15.418Z",
        },
        "meter": [
          {
            "id": "784b85bf-96a0-47d7-90f3-87ff9241f461",
            "month": "Septiembre",
            "isActive": true,
            "state": 1,
            "year": 2024,
            "consummation": "12.500000",
            "img_url": null,
            "create_at": "2024-07-25T20:53:02.456Z",
            "update_at": "2024-07-25T20:53:02.456Z"
          },
          {
            "id": "5efe972a-b0a1-4d2d-add5-d9a071db8b3b",
            "month": "Marzo",
            "isActive": true,
            "state": 1,
            "year": 2024,
            "consummation": "12.500000",
            "img_url": null,
            "create_at": "2024-07-25T20:52:55.739Z",
            "update_at": "2024-07-25T20:52:55.739Z"
          }
        ],
        "pay": []
      }
    ];
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
       drawer: SideMenuOwner( scaffoldKey: scaffoldKey ),
      appBar: AppBar(
        title: const Text('Departamentos'),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: departments.length,
        itemBuilder: (context, index) {
          final department = departments[index];
          return _DepartmentCard(department: department);
        },
      ),
    );
  }
}

class _DepartmentCard extends StatelessWidget {
  final Map<String, dynamic> department;

  const _DepartmentCard({required this.department});

  @override
  Widget build(BuildContext context) {
    final condominium = department['condominium'];
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.home, color: colors.primary, size: 40),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Departamento ${department['number_department']}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                          'Bloque: ${department['block']}, Piso: ${department['floor']}'),
                      Text('Condominio: ${condominium['name']}'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.bed, color: colors.secondary),
                const SizedBox(width: 5),
                Text('${department['bedroom_number']} dormitorios'),
                const SizedBox(width: 20),
                Icon(Icons.group, color: colors.secondary),
                const SizedBox(width: 5),
                Text('${department['guest_number']} huéspedes'),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Dirección: ${condominium['address']}',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              'Fecha de creación: ${department['created_at']}',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Lógica para navegar a los detalles del departamento
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Ver Detalles'),
                style: ElevatedButton.styleFrom(
                  primary: colors.primary,
                  onPrimary: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
