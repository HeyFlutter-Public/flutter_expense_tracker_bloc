import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.radius = 9.0,
    this.addPadding = false,
  });

  final double radius;
  final bool addPadding;

  @override
  Widget build(BuildContext context) {
    final diameter = radius * 2;

    return Center(
      child: Padding(
        padding: addPadding ? const EdgeInsets.all(16) : EdgeInsets.zero,
        child: SizedBox(
          height: diameter,
          width: diameter,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
