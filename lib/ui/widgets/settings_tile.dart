import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final String trailing;
  final IconData leading;
  final VoidCallback onTap;

  const SettingTile({
    super.key,
    required this.title,
    required this.trailing,
    required this.onTap,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),

      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        leading: Icon(leading),
        title: Text(title.i18n(), style: textTheme.bodyLarge),
        trailing: Text(trailing.i18n(), style: textTheme.bodyMedium),
      ),
    );
  }
}
