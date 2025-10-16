import 'package:condominium/pay/domain/repositories/pay_repository.dart';
import 'package:condominium/pay/presentation/provider/pay_repository_provider.dart';
import 'package:condominium/shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final setOnePayProvider =
    StateNotifierProvider.family<SetOnePayNotifier, SetOnePayState, String>(
        (ref, id) {
  final payRepoProvider = ref.watch(payRepositoryProvider);

  return SetOnePayNotifier(payRepository: payRepoProvider, idPay: id,);
});

class SetOnePayNotifier extends StateNotifier<SetOnePayState> {
  final PayRepository payRepository;
  final String idPay;
  SetOnePayNotifier({
    required this.payRepository,
    required this.idPay,
  }) : super(SetOnePayState());

  
  Future<bool> setStatePay(String pathFile) async {
    try {
      if (state.isLoading) return false;
      state = state.copyWith(isLoading: true);

      final isSuccess = await payRepository.setStatePay(idPay,pathFile);

      state = state.copyWith(isLoading: false);
      return isSuccess;
    } on CustomError catch (e) {
      _setErrorMessage(e.message);
      return false; 
    } catch (e) {
      _setErrorMessage('error no implementado');
      return false; 
    }
  }

  _setErrorMessage(String message) {
    state = state.copyWith(
      isLoading: false,
      errorMessage: message,
    );
  }
}

class SetOnePayState {
  final bool isLoading;
  final String errorMessage;

  SetOnePayState({
    this.errorMessage = '',
    this.isLoading = false,
  });

  SetOnePayState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) =>
      SetOnePayState(
          isLoading: isLoading ?? this.isLoading,
          errorMessage: errorMessage ?? this.errorMessage);
}
