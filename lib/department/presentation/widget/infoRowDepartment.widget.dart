import 'package:flutter/material.dart';

class InfoRowDepartment extends StatelessWidget {
  final String data1;
  final String data2;
  const InfoRowDepartment({
    super.key,
    required this.data1,
    required this.data2,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          data1,
          style: textStyle.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          data2,
          style: textStyle.bodyLarge,
        ),
      ],
    );
  }
}
