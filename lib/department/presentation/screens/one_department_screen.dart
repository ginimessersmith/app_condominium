import 'package:animate_do/animate_do.dart';
import 'package:condominium/department/domain/entities/department.entity.dart';
import 'package:condominium/department/presentation/providers/one_department_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widget/cardDepartment.widget.dart';

class OneDepartmentScreen extends ConsumerStatefulWidget {
  final String departmentId;

  const OneDepartmentScreen({super.key, required this.departmentId});

  @override
  _OneDepartmentScreenState createState() => _OneDepartmentScreenState();
}

class _OneDepartmentScreenState extends ConsumerState<OneDepartmentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      ref
          .read(oneDepartmentProvider(widget.departmentId).notifier)
          .loadOneDepartment();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final oneDepartmentState =
        ref.watch(oneDepartmentProvider(widget.departmentId));
    final oneDepartment = oneDepartmentState.department;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle', style: textStyle.titleMedium),
      ),
      body: oneDepartmentState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : oneDepartmentState.errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    'Error en obtener los datos',
                    style: textStyle.bodyLarge,
                  ),
                )
              : oneDepartment != null
                  ? InfoDepartment(oneDepartment: oneDepartment)
                  : const Center(
                      child:
                          Text('No se encontraron detalles del departamento'),
                    ),
    );
  }
}

class InfoDepartment extends StatefulWidget {
  const InfoDepartment({
    super.key,
    required this.oneDepartment,
  });

  final DepartmentEntity oneDepartment;

  @override
  State<InfoDepartment> createState() => _InfoDepartmentState();
}

class _InfoDepartmentState extends State<InfoDepartment>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageViewController,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                _currentPageIndex =
                    index; // Actualiza el índice de la página actual
              });
            },
            children: [
              FadeIn(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardDepartment(
                          textStyle: textStyle,
                          color: color,
                          oneDepartment: widget.oneDepartment),
                    ],
                  ),
                ),
              ),
              // FadeIn(
              //   child: Padding(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         CardDepartment(
              //             textStyle: textStyle,
              //             color: color,
              //             oneDepartment: widget.oneDepartment),
              //       ],
              //     ),
              //   ),
              // ),
              // FadeIn(
              //   child: Padding(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         CardDepartment(
              //             textStyle: textStyle,
              //             color: color,
              //             oneDepartment: widget.oneDepartment),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        // const SizedBox(
        //   height: 16,
        // ),
        // SmoothPageIndicator(
        //   controller: _pageViewController,
        //   count: 3,
        //   effect: WormEffect(
        //     dotHeight: 12,
        //     dotWidth: 12,
        //     activeDotColor: color.primary,
        //   ),
        // ),
        // const SizedBox(
        //   height: 16,
        // ),
      ],
    );
  }
}
