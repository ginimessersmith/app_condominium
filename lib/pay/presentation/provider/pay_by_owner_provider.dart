import 'package:condominium/pay/domain/repositories/pay_repository.dart';
import 'package:condominium/pay/infrastructure/mappers/payByOwner.mapper.dart';
import 'package:condominium/pay/presentation/provider/pay_repository_provider.dart';
import 'package:condominium/shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final payByOwnerProvider =
    StateNotifierProvider.autoDispose<PayByOwnerNotifier, PayByOwnerState>((ref) {
  final payRepository = ref.watch(payRepositoryProvider);

  return PayByOwnerNotifier(payRepository: payRepository);
});

class PayByOwnerNotifier extends StateNotifier<PayByOwnerState> {
  final PayRepository payRepository;
  PayByOwnerNotifier({required this.payRepository}) : super(PayByOwnerState());

  loadPay() async {
    try {
      if (state.isLoading) return;
      state = state.copyWith(isLoading: true);

      final payByOwnerUnPaid = await payRepository.payByOwner(1);
      final payByOwnerProcess = await payRepository.payByOwner(2);
      final payByOwnerMade = await payRepository.payByOwner(3);

      state = state.copyWith(
          isLoading: false,
          payUnPaid: payByOwnerUnPaid,
          payProcess: payByOwnerProcess,
          payMade: payByOwnerMade,
          errorMessage: '');
    } on CustomError catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error no implementado',
      );
    }
  }
}

class PayByOwnerState {
  final bool isLoading;
  final PayByOwner? payUnPaid;
  final PayByOwner? payProcess;
  final PayByOwner? payMade;
  final String? errorMessage;

  PayByOwnerState(
      {this.isLoading = false,
      this.payUnPaid,
      this.payProcess,
      this.payMade,
      this.errorMessage = ''});

  PayByOwnerState copyWith({
    bool? isLoading,
    PayByOwner? payUnPaid,
    PayByOwner? payProcess,
    PayByOwner? payMade,
    String? errorMessage,
  }) =>
      PayByOwnerState(
        isLoading: isLoading ?? this.isLoading,
        payUnPaid: payUnPaid ?? this.payUnPaid,
        payProcess: payProcess ?? this.payProcess,
        payMade: payMade ?? this.payMade,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
