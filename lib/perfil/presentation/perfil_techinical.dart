import 'package:condominium/shared/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class TechnicianProfileScreen extends StatelessWidget {
  final Map<String, dynamic> technician = {
    "id": "bfd1b62a-01ad-49ef-8698-48a446e29689",
    "fullname": "roman",
    "lastname": "roca",
    "email": "roman@gmail.com",
    "phone": null,
    "codeCountry": null,
    "gender": "m",
    "photoUrl": null,
    "created_at": "2024-05-01T21:59:03.826Z",
    "updated_at": "2024-05-01T21:59:03.826Z",
    "type_user": 0,
    "pay": [
      {
        "id": "4338ae6c-401b-4d89-9275-27f21b0f9be8",
        "month": "Septiembre",
        "year": 2024,
        "isActive": true,
        "pay_of_service": "1.327434",
        "total_to_pay": "11.327434",
        "porcent": "4.424779",
        "pantry": "10.000000",
        "consummation": "12.500000",
        "state": 2,
        "reverse": false,
        "create_at": "2024-07-25T23:38:47.549Z",
        "update_at": "2024-07-25T23:38:47.549Z"
      }
    ],
    "role": {
      "id": "795a9b87-b095-48b3-be4e-9807c3d2d6dd",
      "name": "TECNICO",
      "description": "Rol con Acceso de tecnico",
      "isEnable": true,
      "created_at": "2024-04-10T03:34:22.075Z",
      "updated_at": "2024-04-10T03:34:22.075Z"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImJmZDFiNjJhLTAxYWQtNDllZi04Njk4LTQ4YTQ0NmUyOTY4OSIsImlhdCI6MTcyMjEyNjg3NywiZXhwIjoxNzIyMjEzMjc3fQ.6-cTJctqEUkBR6ZvMGgX3bnVvtn_1ErhpXs6Q-NcBvI"
  };

  @override
  Widget build(BuildContext context) {
     final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      drawer: SideMenu( scaffoldKey: scaffoldKey ),
      appBar: AppBar(
        title: Text('Perfil '),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  // backgroundImage: technician['photoUrl'] != null
                  //     ? NetworkImage(technician['photoUrl'])
                  //     : AssetImage('assets/avatar_placeholder.png') as ImageProvider,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  '${technician['fullname']} ${technician['lastname']}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              _buildInfoRow(Icons.email, 'Email', technician['email']),
              _buildInfoRow(Icons.phone, 'Phone', technician['phone'] ?? 'N/A'),
              _buildInfoRow(Icons.person, 'Gender', technician['gender'] == 'm' ? 'Masculino' : 'Femenino'),
              SizedBox(height: 20),
              _buildSectionTitle('Role'),
              _buildRoleInfo(technician['role']),
              SizedBox(height: 20),
              // _buildSectionTitle('Payments'),
              // _buildPaymentList(technician['pay']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRoleInfo(Map<String, dynamic> role) {
    return Card(
      color: Colors.blue[50],
      child: ListTile(
        leading: Icon(Icons.work, color: Colors.blue),
        title: Text(role['name']),
        subtitle: Text(role['description']),
      ),
    );
  }

  Widget _buildPaymentList(List<dynamic> payments) {
    if (payments.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('No Payments Available'),
      );
    }

    return Column(
      children: payments.map<Widget>((payment) {
        return Card(
          child: ListTile(
            title: Text('Month: ${payment['month']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Year: ${payment['year']}'),
                Text('Total to Pay: ${payment['total_to_pay']}'),
                Text('Percentage: ${payment['porcent']}'),
                Text('Consumption: ${payment['consummation']}'),
              ],
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Add your onTap functionality here
            },
          ),
        );
      }).toList(),
    );
  }
}
