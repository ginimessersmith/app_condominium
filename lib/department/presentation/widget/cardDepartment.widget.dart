
import 'package:condominium/department/domain/domain_department.dart';
import 'package:condominium/department/presentation/widget/infoRowDepartment.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardDepartment extends StatelessWidget {
  
 

  const CardDepartment({
    super.key,
    required this.textStyle,
    required this.color,
    required this.oneDepartment,
  });

  final TextTheme textStyle;
  final ColorScheme color;
   final DepartmentEntity oneDepartment;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Departamento',
                  style: textStyle.titleSmall,
                ),
                Text(
                  ' #${oneDepartment.numberDepartment}',
                  style: textStyle.titleSmall,
                ),
                const Spacer(),
                Icon(
                  Icons.house_outlined,
                  color: color.primary,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InfoRowDepartment(
              data1: 'Huespedes',
              data2: oneDepartment.guestNumber.toString(),
            ),
            InfoRowDepartment(
              data1: 'Bloque',
              data2: oneDepartment.block,
            ),
            InfoRowDepartment(
              data1: 'Piso',
              data2: oneDepartment.floor.toString(),
            ),
            InfoRowDepartment(
              data1: 'Dormitorios',
              data2: oneDepartment.bedroomNumber.toString(),
            ),
            InfoRowDepartment(
              data1: 'Condominio',
              data2: oneDepartment.condominium?.name ??'no data',
            ),
          ],
        ),
      ),
    );
  }
}

