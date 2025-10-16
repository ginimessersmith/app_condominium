import 'package:condominium/condominium/presentation/providers/condiminium_by_tech_provider.dart';
import 'package:condominium/meter/presentation/provider/list_meter_provider.dart';
import 'package:condominium/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MeterScreen extends ConsumerStatefulWidget {
  final String idCondominium;
  const MeterScreen({
    required this.idCondominium,
  });

  @override
  _MeterScreenState createState() => _MeterScreenState();
}

class _MeterScreenState extends ConsumerState<MeterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() =>
        ref.read(listMeterProvider(widget.idCondominium).notifier).loadList());
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final listMeterState = ref.watch(listMeterProvider(widget.idCondominium));
    final list = listMeterState.listMeter;
    final condominiun = ref.watch(condominiumByTechProvider);

    if (listMeterState.errorMessage.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          
        ),
        body: listMeterState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Text(
                  'Error:${listMeterState.errorMessage}',
                  style: textStyle.titleMedium,
                ),
              ),
      );
    }
    if (listMeterState.listMeter.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: listMeterState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Text(
                  'sin mediciones',
                  style: textStyle.titleMedium,
                ),
              ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${condominiun.condominiumByTech?.name}'),
      ),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      body: listMeterState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: listMeterState.listMeter.length,
              itemBuilder: (BuildContext context, int index) {
                final meter = listMeterState.listMeter[index];

                return ListTile(
                  title: Text('Mes: ${meter.month}'),
                  subtitle: Text('Año: ${meter.year}'),
                  leading: Icon(
                    Icons.water_drop_outlined,
                    color: colors.primary,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                  onTap: () {
                    context.push('/meter/one-meter', extra: meter);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.push('/meter/create-meter');
          },
          icon: const Icon(Icons.add),
          label: const Text('Nueva Medicion')),
    );
  }
}
