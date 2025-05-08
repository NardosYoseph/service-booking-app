
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;

  const CustomTextField({
    required this.controller,
    required this.label,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
           fillColor: theme.inputDecorationTheme.fillColor ?? Colors.grey[100], // Use theme fill color
          labelStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor), 
        ),
        keyboardType: keyboardType,
        validator: (value) => value == null || value.isEmpty ? 'This field is required' : null,
      ),
    );
  }
}