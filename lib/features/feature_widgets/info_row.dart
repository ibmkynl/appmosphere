import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title.i18n(), style: const TextStyle(fontWeight: FontWeight.bold)), Text(value)],
      ),
    );
  }
}
