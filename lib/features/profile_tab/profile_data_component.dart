import 'package:flutter/material.dart';

class ProfileDataComponent extends StatelessWidget {
  final Widget data1;
  final Widget data2;
  const ProfileDataComponent({
    super.key,
    required this.data1,
    required this.data2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [data1, data2]);
  }
}
