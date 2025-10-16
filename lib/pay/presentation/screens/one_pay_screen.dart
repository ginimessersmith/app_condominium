import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:condominium/pay/domain/domain_pay.dart';
import 'package:condominium/pay/presentation/provider/one_pay_provider.dart';
import 'package:condominium/pay/presentation/provider/set_state_one_Pay_provider.dart';
import 'package:condominium/shared/services/camera_gallery_service_impl.dart';
import 'package:condominium/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class OnePayScreen extends ConsumerStatefulWidget {
  final String idPay;
  const OnePayScreen({super.key, required this.idPay});

  @override
  _OnePayState createState() => _OnePayState();
}

class _OnePayState extends ConsumerState<OnePayScreen> {
  String? _selectedImagePath;
  void openDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        bool isLoading = false;
        String? errorMessage;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Pagar'),
              content: isLoading
                  ? const LinearProgressIndicator()
                  : errorMessage != null
                      ? Text('Error: $errorMessage')
                      : const Text('¿Desea procesar el pago?'),
              actions: [
                if (!isLoading) ...[
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(errorMessage != null ? 'OK' : 'Cancelar'),
                  ),
                  if (errorMessage == null)
                    FilledButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });

                        try {
                          final success = await ref
                              .read(setOnePayProvider(widget.idPay).notifier)
                              .setStatePay(_selectedImagePath!);

                          setState(() {
                            isLoading = false;
                          });

                          if (success) {
                            context.pop();
                            context.push('/pay');
                          } else {
                            setState(() {
                              errorMessage =
                                  'Hubo un error al procesar el pago';
                            });
                          }
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                            errorMessage = 'Error inesperado: $e';
                          });
                        }
                      },
                      child: const Text('Procesar pago'),
                    ),
                ],
              ],
            );
          },
        );
      },
    );
  }

  // NUEVO: Método para seleccionar una imagen desde la galería.
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
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => ref.read(onePayProvider(widget.idPay).notifier).findOnePay());
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final onePayState = ref.watch(onePayProvider(widget.idPay));
    final onePay = onePayState.pay;
    if (onePayState.isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (onePayState.errorMessage.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(
            'Error: ${onePayState.errorMessage}',
            style: textStyle.titleLarge,
          ),
        ),
      );
    }
    if (onePay == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(
            'Sin datos',
            style: textStyle.titleLarge,
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          CardOnePay(
            onePay: onePay,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton.icon(
                onPressed: _selectPhoto,
                icon: const Icon(Icons.photo_library_outlined),
                label: const Text('Abrir Galeria'),
              ),
              const SizedBox(
                width: 25,
              ),
              FilledButton.icon(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red)
                ),
                onPressed: _deletePhoto,
                icon: const Icon(
                  Icons.delete_outline_outlined,
                ),
                label: const Text('Eliminar'),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // FilledButton.icon(
              //   onPressed: _takePhoto,
              //   icon: const Icon(
              //     Icons.camera_alt_outlined,
              //   ),
              //   label: const Text('Abrir Camara'),
              // ),
              
            ],
          ),
          if (_selectedImagePath !=
              null) // NUEVO: Mostrar la imagen si se ha seleccionado.
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.file(
                File(_selectedImagePath!), // Mostrar la imagen seleccionada.
                height: 200, // Altura de la previsualización.
                width: double.infinity, // Ancho completo.
                fit: BoxFit
                    .cover, // Ajustar la imagen para que ocupe todo el espacio.
              ),
            ),
        ],
      ),
      floatingActionButton: (onePay != null && onePay.state == 1)
          ? FloatingActionButton.extended(
              onPressed: (_selectedImagePath ==null) ? null : () {
                openDialog(context);
              },
              label: const Text('Pagar'),
              icon: const Icon(Icons.monetization_on_outlined),
            )
          : null,
    );
  }
}

class CardOnePay extends StatelessWidget {
  final PayEntity onePay;
  const CardOnePay({
    super.key,
    required this.onePay,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  if (onePay.state == 1)
                    Text(
                      'Pago Pendiente',
                      style: textStyle.titleMedium,
                    ),
                  if (onePay.state == 2)
                    Text(
                      'Pago en proceso',
                      style: textStyle.titleMedium,
                    ),
                  if (onePay.state == 3)
                    Text(
                      'Pago Realizado',
                      style: textStyle.titleMedium,
                    ),
                  const Spacer(),
                  if (onePay.state == 1)
                    SpinPerfect(
                      infinite: true,
                      duration: const Duration(seconds: 15),
                      child: const Icon(
                        Icons.dangerous_outlined,
                        color: Colors.red,
                        size: 35,
                      ),
                    ),
                  if (onePay.state == 2)
                    FadeIn(
                      child: Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.amber.shade700,
                        size: 35,
                      ),
                    ),
                  if (onePay.state == 3)
                    FadeIn(
                      child: const Icon(
                        Icons.check_circle_outline_outlined,
                        color: Colors.green,
                        size: 35,
                      ),
                    ),
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              _InfoRowPay(
                textOne: 'Consumo',
                textTow: Helpers.formattedText(onePay.consummation),
                isPorcent: false,
                isTotal: false,
              ),
              _InfoRowPay(
                textOne: 'Mes',
                textTow: onePay.month,
                isPorcent: false,
                isTotal: false,
              ),
              _InfoRowPay(
                textOne: 'Año',
                textTow: onePay.year.toString(),
                isPorcent: false,
                isTotal: false,
              ),
              _InfoRowPay(
                textOne: 'Dispensa',
                textTow: Helpers.formattedText(onePay.pantry),
                isPorcent: false,
                isTotal: false,
              ),
              _InfoRowPay(
                textOne: 'Pago por servicio',
                textTow: Helpers.formattedText(onePay.payOfService),
                isPorcent: false,
                isTotal: false,
              ),
              _InfoRowPay(
                textOne: 'Total',
                textTow: Helpers.formattedText(onePay.totalToPay),
                isPorcent: false,
                isTotal: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRowPay extends StatelessWidget {
  final String textOne;
  final String textTow;
  final bool isPorcent;
  final bool isTotal;
  const _InfoRowPay({
    super.key,
    required this.textOne,
    required this.textTow,
    required this.isPorcent,
    required this.isTotal,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isTotal
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    textOne,
                    style: textStyle.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : Text(
                  textOne,
                  style: textStyle.bodyLarge,
                ),
          isPorcent
              ? Text(
                  '$textTow %',
                  style: textStyle.bodyLarge,
                )
              : isTotal
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Text(
                        textTow,
                        style: textStyle.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  : Text(
                      textTow,
                      style: textStyle.bodyLarge,
                    )
        ],
      ),
    );
  }
}
