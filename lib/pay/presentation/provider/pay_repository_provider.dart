import 'package:condominium/auth/presentation/providers/auth_provider.dart';
import 'package:condominium/pay/domain/repositories/pay_repository.dart';
import 'package:condominium/pay/infrastructure/datasources/pay_datasource_impl.dart';
import 'package:condominium/pay/infrastructure/repositories/pay_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final payRepositoryProvider = Provider<PayRepository>((ref) {
  final token = ref.watch(authProvider).user?.token ?? '';
  final payRepository =
      PayRepositoryImpl(datasource: PayDatasourceImpl(accessToken: token));
  return payRepository;
});
