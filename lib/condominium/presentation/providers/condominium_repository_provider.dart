import 'package:condominium/auth/presentation/providers/auth_provider.dart';
import 'package:condominium/condominium/domain/domain_condominium.dart';
import 'package:condominium/condominium/infrastructure/domain/condominium_datasource_impl.dart';
import 'package:condominium/condominium/infrastructure/repositories/condominium_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final condominiumRepositoyProvider = Provider<CondominiumRepository>((ref) {
  final token = ref.watch(authProvider).user?.token ?? '';
  final condominiumRepository = CondominiumRepositoryImpl(
      datasource: CondominiumDatasourceImpl(accessToken: token));
  return condominiumRepository;
});
