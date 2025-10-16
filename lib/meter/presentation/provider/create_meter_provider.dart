import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:condominium/meter/domain/repositories/meter_repository.dart';
import 'package:condominium/meter/presentation/provider/meter_repository_provider.dart';
import 'package:condominium/shared/errors/custom_error.dart';

final createMeterProvider = StateNotifierProvider<CreateMeterNotifier, CreateMeterState>(
  (ref) {
    final meterRepository = ref.watch(meterRepositoryProvider);
    return CreateMeterNotifier(meterRepository: meterRepository);
  },
);

class CreateMeterNotifier extends StateNotifier<CreateMeterState> {
  final MeterRepository meterRepository;

  CreateMeterNotifier({
    required this.meterRepository,
  }) : super(CreateMeterState());

  Future<void> createMeasurement(Map<String, dynamic> data) async {
    try {
      state = state.copyWith(isLoading: true);
      await meterRepository.createMeter(data);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } on CustomError catch (e) {
      _setError(e.message);
    } catch (e) {
      _setError('Error no implementado');
    }
  }

 void resetState() {
    state = CreateMeterState(); // Restablecer el estado inicial
  }
  _setError(String message) {
    state = state.copyWith(isLoading: false, errorMessage: message);
  }
}

class CreateMeterState {
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;

  CreateMeterState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  CreateMeterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) =>
      CreateMeterState(
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
