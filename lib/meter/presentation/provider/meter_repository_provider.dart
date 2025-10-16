import 'package:condominium/auth/presentation/providers/auth_provider.dart';
import 'package:condominium/meter/domain/repositories/meter_repository.dart';
import 'package:condominium/meter/infrastructure/datasources/meter_datasource_impl.dart';
import 'package:condominium/meter/infrastructure/repositories/meter_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final meterRepositoryProvider = Provider<MeterRepository>((ref) {
  final token = ref.watch(authProvider).user?.token ??'no-token';
  return MeterRepositoryImpl(
      datasource: MeterDatasourceImpl(accessToken: token));
});
