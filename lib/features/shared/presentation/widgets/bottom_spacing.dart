import 'package:flutter/material.dart';

import 'package:transactions_app/core/core.dart';

class BottomSpacing extends StatelessWidget {
  const BottomSpacing({super.key, this.spacingPercentage = bottomSpacing});

  final double spacingPercentage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * spacingPercentage,
    );
  }
}
