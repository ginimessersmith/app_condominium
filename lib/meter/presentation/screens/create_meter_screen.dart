import 'dart:io';
import 'package:condominium/condominium/presentation/providers/condiminium_by_tech_provider.dart';
import 'package:condominium/department/domain/domain_department.dart';
import 'package:condominium/meter/presentation/provider/create_meter_provider.dart';
import 'package:condominium/shared/services/camera_gallery_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateMeterScreen extends ConsumerStatefulWidget {
  const CreateMeterScreen({super.key});

  @override
  _CreateMeterScreenState createState() => _CreateMeterScreenState();
}

class _CreateMeterScreenState extends ConsumerState<CreateMeterScreen> {
  String? _selectedImagePath;
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _consummationController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  String? _selectedMonth;
  DepartmentEntity? _selectedDepartment;

  bool _isFormValid = false;

  @override
  void dispose() {
    _pageController.dispose();
    _consummationController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  Future<void> _selectPhoto() async {
    String? photo = await CameraGalleryServiceImpl().selectPhoto();

    if (photo != null) {
      setState(() {
        _selectedImagePath =
            photo; // Guardar la ruta de la imagen seleccionada.
      });
    }
  }

  Future<void> _takePhoto() async {
    String? photo = await CameraGalleryServiceImpl().takePhoto();

    if (photo != null) {
      setState(() {
        _selectedImagePath =
            photo; // Guardar la ruta de la imagen seleccionada.
      });
    }
  }

  void _deletePhoto() {
    setState(() {
      _selectedImagePath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final condominiumByTechState = ref.watch(condominiumByTechProvider);
    final listDepartment = condominiumByTechState.condominiumByTech?.department;
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final createMeterState = ref.watch(createMeterProvider);

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

    return Scaffold(
      appBar: AppBar(title: const Text('Crear Medición')),
      // drawer: SideMenu(scaffoldKey: scaffoldKey),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          //TODO Primera Pagina del Page View
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              onChanged: _validateForm,
              child: ListView(
                children: [
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Mes'),
                    value: _selectedMonth,
                    items: months
                        .map((month) => DropdownMenuItem(
                              value: month,
                              child: Text(month, style: textStyle.bodyLarge),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedMonth = value;
                      });
                      _validateForm();
                    },
                    validator: (value) =>
                        value == null ? 'El mes es obligatorio' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Consumo'),
                    controller: _consummationController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El consumo es obligatorio';
                      }
                      final consum = double.tryParse(value);
                      if (consum == null || consum <= 0) {
                        return 'Debe ingresar un valor válido para el consumo';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Año'),
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El año es obligatorio';
                      }
                      final year = int.tryParse(value);
                      if (year == null || year < 2000 || year > 2100) {
                        return 'Debe ingresar un año válido';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<DepartmentEntity>(
                    decoration:
                        const InputDecoration(labelText: 'Departamento'),
                    value: _selectedDepartment,
                    items: listDepartment
                        ?.map((dept) => DropdownMenuItem<DepartmentEntity>(
                              value: dept,
                              child: Text(
                                'Bloque: ${dept.block}, Nro. Departamento: ${dept.numberDepartment}',
                                style: textStyle.bodyLarge,
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDepartment =
                            value; // Guardar el valor seleccionado
                      });
                      _validateForm();
                    },
                    validator: (value) =>
                        value == null ? 'El departamento es obligatorio' : null,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _selectPhoto,
                        style: ButtonStyle(
                          backgroundColor:
                              // ignore: unnecessary_const
                              MaterialStatePropertyAll(colors.primary),
                        ),
                        icon: const Icon(
                          Icons.photo_library_outlined,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: _takePhoto,
                        style: ButtonStyle(
                          backgroundColor:
                              // ignore: unnecessary_const
                              MaterialStatePropertyAll(colors.primary),
                        ),
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: _deletePhoto,
                        style: const ButtonStyle(
                          backgroundColor:
                              // ignore: unnecessary_const
                              MaterialStatePropertyAll(Colors.red),
                        ),
                        icon: const Icon(
                          Icons.delete_outline_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  if (_selectedImagePath !=
                      null) // NUEVO: Mostrar la imagen si se ha seleccionado.
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.file(
                        File(
                            _selectedImagePath!), // Mostrar la imagen seleccionada.
                        height: 250, // Altura de la previsualización.
                        width: double.infinity, // Ancho completo.
                        fit: BoxFit
                            .cover, // Ajustar la imagen para que ocupe todo el espacio.
                      ),
                    ),
                  const SizedBox(height: 15),
                  FilledButton.icon(
                    onPressed: _isFormValid
                        ? () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        : null,
                    icon: const Icon(Icons.label_important),
                    label: const Text('Siguiente'),
                  ),
                ],
              ),
            ),
          ),
          //TODO Segunda página (Verificación)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Verifique los datos ingresados:',
                    style: textStyle.titleSmall),
                const SizedBox(height: 16),
                Text('Mes: $_selectedMonth', style: textStyle.bodyLarge),
                Text('Consumo: ${_consummationController.text}',
                    style: textStyle.bodyLarge),
                Text('Año: ${_yearController.text}',
                    style: textStyle.bodyLarge),
                Text(
                  'Departamento: Bloque ${_selectedDepartment?.block}, Nro. Departamento: ${_selectedDepartment?.numberDepartment}',
                  style: textStyle.bodyLarge,
                  softWrap: true,
                ),
                const SizedBox(height: 15),
                if (_selectedImagePath !=
                    null) // NUEVO: Mostrar la imagen si se ha seleccionado.
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.file(
                      File(
                          _selectedImagePath!), // Mostrar la imagen seleccionada.
                      height: 200, // Altura de la previsualización.
                      width: double.infinity, // Ancho completo.
                      fit: BoxFit
                          .cover, // Ajustar la imagen para que ocupe todo el espacio.
                    ),
                  ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('volver al formulario'),
                    ),
                    FilledButton(
                      onPressed: (_selectedImagePath == null)
                          ? null
                          : () async {
                              final meterData = {
                                "month": _selectedMonth,
                                "consummation": _consummationController.text,
                                "year": int.parse(_yearController.text),
                                "department_id": _selectedDepartment?.id,
                                "file": _selectedImagePath
                              };
                              // print(meterData);
                              await ref
                                  .read(createMeterProvider.notifier)
                                  .createMeasurement(meterData);
                              if (createMeterState.isSuccess) {
                                ref
                                    .read(createMeterProvider.notifier)
                                    .resetState();
                                if (context.mounted) {
                                  context.go('/meter');
                                }
                              }
                            },
                      child: const Text('Guardar'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (createMeterState.isLoading)
                  const Center(child: CircularProgressIndicator()),
                if (createMeterState.errorMessage.isNotEmpty)
                  Row(
                    children: [
                      const Icon(
                        Icons.dangerous_outlined,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Error al crear la medicion: ${createMeterState.errorMessage}',
                        style: textStyle.bodyLarge,
                      ),
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
