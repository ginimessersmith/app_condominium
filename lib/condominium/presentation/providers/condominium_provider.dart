import 'package:condominium/condominium/domain/domain_condominium.dart';
import 'package:condominium/condominium/presentation/providers/condominium_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final condoniumProvider = StateNotifierProvider.autoDispose<
    CondominiumStateNotifier, CondominiumState>((ref) {
  final condominiumRepository = ref.watch(condominiumRepositoyProvider);

  return CondominiumStateNotifier(condominiumRepository: condominiumRepository);
});

class CondominiumStateNotifier extends StateNotifier<CondominiumState> {
  final CondominiumRepository condominiumRepository;
  bool _isDisposed = false;

  CondominiumStateNotifier({required this.condominiumRepository})
      : super(CondominiumState()) {
    // listCondominium();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> listCondominium() async {
    if (state.isLoading || _isDisposed) return;
    state = state.copyWith(isLoading: true);
    try {
      final list = await condominiumRepository.findByOwner();

      if (!_isDisposed) {
        state = state.copyWith(
          isLoading: false,
          listCondominium: list,
        );
      }
    } catch (e) {
      if (!_isDisposed) {
        state = state.copyWith(isLoading: false);
      }
    }
  }
}

class CondominiumState {
  final bool isLoading;
  final List<CondominiumEntity> listCondominium;

  CondominiumState({
    this.isLoading = false,
    this.listCondominium = const [],
  });

  CondominiumState copyWith({
    bool? isLoading,
    List<CondominiumEntity>? listCondominium,
  }) =>
      CondominiumState(
        isLoading: isLoading ?? this.isLoading,
        listCondominium: listCondominium ?? this.listCondominium,
      );
}
