import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:condominium/condominium/domain/domain_condominium.dart';

final selectedCondominiumProvider = StateProvider<CondominiumEntity?>((ref) {
  return null; // Inicialmente, no hay condominio seleccionado.
});