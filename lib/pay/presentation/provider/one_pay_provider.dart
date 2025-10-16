import 'package:condominium/pay/domain/domain_pay.dart';
import 'package:condominium/pay/domain/repositories/pay_repository.dart';
import 'package:condominium/pay/presentation/provider/pay_repository_provider.dart';
import 'package:condominium/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onePayProvider =
    StateNotifierProvider.family<OnePayNotifier, OnePayState, String>((ref,id) {
  final payRepository = ref.watch(payRepositoryProvider);
  return OnePayNotifier(payRepository: payRepository,id:id);
});

class OnePayNotifier extends StateNotifier<OnePayState> {
  final PayRepository payRepository;
  final String id;
  OnePayNotifier({
    required this.payRepository,
    required this.id,
    }) : super(OnePayState());

  findOnePay() async {
    try {
      if (state.isLoading) return;
      state = state.copyWith(
        isLoading: true,
      );
      final onePay = await payRepository.findOnePay(id);
      state = state.copyWith(
          isLoading: false, pay: onePay, isSuccess: true, errorMessage: '');
    } on CustomError catch (e) {
      _setErrorMessage(e.message);
    } catch (e) {
      _setErrorMessage('Error no implementado');
    }
  }

  _setErrorMessage(String message) {
    state = state.copyWith(
      isLoading: false,
      errorMessage: message,
    );
  }
}

class OnePayState {
  final bool isLoading;
  final String errorMessage;
  final PayEntity? pay;

  OnePayState({this.isLoading = false, this.errorMessage = '', this.pay});

  OnePayState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    PayEntity? pay,
  }) =>
      OnePayState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        pay: pay ?? this.pay,
      );
}
