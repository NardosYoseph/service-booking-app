import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvailabilitySwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AvailabilitySwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium;

    return SwitchListTile(
      title: Text(
        "available".tr,
        style: textStyle,
      ),
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      activeColor: theme.primaryColor,
    );
  }
}
