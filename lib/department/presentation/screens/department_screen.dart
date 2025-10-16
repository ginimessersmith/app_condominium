import 'package:condominium/department/presentation/providers/department_list_provider.dart';
import 'package:condominium/shared/widgets/side_menu_owner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DepartmentScreen extends ConsumerStatefulWidget {
  const DepartmentScreen({super.key});

  @override
  _DepartmentScreenState createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends ConsumerState<DepartmentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => ref.read(departmentByOwnerProvider.notifier).listDepartment());
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final departmentNotifier = ref.watch(departmentByOwnerProvider);
    final listDepartment = ref.watch(departmentByOwnerProvider).listDepartment;
    if (listDepartment.isEmpty) {
      return Scaffold(
        drawer: SideMenuOwner(scaffoldKey: scaffoldKey),
        appBar: AppBar(title: const Text('Mis departamentos')),
        body: departmentNotifier.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Text(
                  'Sin Departamentos',
                  style: textStyle.titleMedium,
                ),
              ),
      );
    }
    return Scaffold(
      drawer: SideMenuOwner(scaffoldKey: scaffoldKey),
      appBar: AppBar(title: const Text('Mis departamentos')),
      body: ListView.builder(
        itemCount: listDepartment.length,
        itemBuilder: (BuildContext context, int index) {
          final department = listDepartment[index];
          return ListTile(
            leading: Icon(
              Icons.house_outlined,
              color: colors.primary,
            ),
            title: Text(
              'Departamento #${department.numberDepartment}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'Bloque: ${department.block}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_sharp,
            ),
            onTap: () {
              context.push('/department/oneDepartment/${department.id}');
            },
          );
        },
      ),
    );
  }
}
