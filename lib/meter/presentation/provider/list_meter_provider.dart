import 'package:condominium/meter/domain/entities/meter.entity.dart';
import 'package:condominium/meter/domain/repositories/meter_repository.dart';
import 'package:condominium/meter/presentation/provider/meter_repository_provider.dart';
import 'package:condominium/shared/errors/custom_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listMeterProvider =
    StateNotifierProvider.family<ListMeterNotifier, ListMeterState, String>((ref, id) {
  final meterRepository = ref.watch(meterRepositoryProvider);
  return ListMeterNotifier(idCondominium: id, meterRepository: meterRepository);
});

class ListMeterNotifier extends StateNotifier<ListMeterState> {
  final MeterRepository meterRepository;
  final String idCondominium;
  ListMeterNotifier({
    required this.idCondominium,
    required this.meterRepository,
  }) : super(ListMeterState());

  loadList() async {
    try {
      state = state.copyWith(
        isLoading: true,
      );

      final list = await meterRepository.findByCondominium(idCondominium);
      state = state.copyWith(
        isLoading: false,
        listMeter: list,
      );
    } on CustomError catch (e) {
      _setError(e.message);
    } catch (e) {
      _setError('Error no implementado');
    }
  }

  _setError(String message) {
    state = state.copyWith(isLoading: false, errorMessage: message);
  }
}

class ListMeterState {
  final bool isLoading;
  final String errorMessage;
  final List<MeterEntity> listMeter;

  ListMeterState({
    this.isLoading = false,
    this.errorMessage = '',
    this.listMeter = const [],
  });

  ListMeterState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<MeterEntity>? listMeter,
  }) =>
      ListMeterState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        listMeter: listMeter ?? this.listMeter,
      );
}
