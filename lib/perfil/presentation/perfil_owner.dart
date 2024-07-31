import 'package:condominium/config/router/app_router.dart';
import 'package:condominium/shared/widgets/side_menu_owner.dart';
import 'package:flutter/material.dart';

class OwnerProfileScreen extends StatelessWidget {
  const OwnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulando la data recibida del JSON
    final Map<String, dynamic> userData = {
      "id": "52f54594-046c-483b-9e63-ec3a32472152",
      "fullname": "diego",
      "lastname": "roca",
      "email": "diego@gmail.com",
      "phone": null,
      "codeCountry": null,
      "gender": "m",
      "photoUrl": null,
      "created_at": "2024-05-01T22:00:18.925Z",
      "updated_at": "2024-05-01T22:00:18.925Z",
      "type_user": 0,
      "pay": [],
      "role": {
        "id": "8f6501cb-01c7-4eef-844a-99ab6b2decaf",
        "name": "PROPIETARIO",
        "description": "Rol con Acceso de usuario estandar",
        "isEnable": true,
        "created_at": "2024-04-11T17:24:52.118Z",
        "updated_at": "2024-04-11T17:24:52.118Z"
      },
      "token":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjUyZjU0NTk0LTA0NmMtNDgzYi05ZTYzLWVjM2EzMjQ3MjE1MiIsImlhdCI6MTcyMjEyNzk3NiwiZXhwIjoxNzIyMjE0Mzc2fQ.hpsb96F1u-Mc8oEUJ-bdpO_CwOHoUGjVk_v0TAWWK3I"
    };

    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      drawer: SideMenuOwner(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: Text('Bienvenido ${userData['fullname']}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileHeader(userData),
            const SizedBox(height: 20),
            _buildProfileInfo(userData),
            const SizedBox(height: 20),
            ListTile(
              title: Text('Mis Departamentos'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                appRouter.go('/department');
              },
            )
          ],
        ),
      ),
      // floatingActionButton:,
    );
  }

  Widget _buildProfileHeader(Map<String, dynamic> userData) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.blueAccent,
          child: Icon(
            Icons.person,
            size: 50,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${userData['fullname']} ${userData['lastname']}',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          userData['email'],
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildProfileInfo(Map<String, dynamic> userData) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.phone),
          title: Text(userData['phone'] ?? 'No tiene numero de telefono'),
        ),
        ListTile(
          leading: Icon(Icons.location_city),
          title: Text(userData['codeCountry'] != null
              ? '+${userData['codeCountry']}'
              : 'No tiene codigo del pais'),
        ),
        ListTile(
          leading: Icon(Icons.access_time),
          title: Text('Registrado en: ${userData['created_at']}'),
        ),
        // ListTile(
        //   leading: Icon(Icons.update),
        //   title: Text('Actualizado en: ${userData['updated_at']}'),
        // ),
      ],
    );
  }
}
