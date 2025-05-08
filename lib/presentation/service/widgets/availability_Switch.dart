
import 'package:flutter/material.dart';

class AvailabilitySwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AvailabilitySwitch({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text("Available", style: TextStyle(fontSize: 16)),
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      activeColor: Colors.deepPurple,
      activeTrackColor: Colors.deepPurple.withOpacity(0.3),
    );
  }
}
