import 'package:flutter/material.dart';

class TimeLogsInternDropdown extends StatelessWidget {
  final bool isDarkMode;
  final List<String> internNames;
  final String? selectedIntern;
  final ValueChanged<String?> onChanged;

  const TimeLogsInternDropdown({
    super.key,
    required this.isDarkMode,
    required this.internNames,
    required this.selectedIntern,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure selectedIntern is valid within internNames
    final validSelected =
        internNames.contains(selectedIntern) ? selectedIntern : null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2C2C2C) : const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDarkMode ? const Color(0xFF3A3A3A) : const Color(0xFFDDDDDD),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: validSelected,
          isExpanded: true,
          dropdownColor: isDarkMode ? const Color(0xFF2C2C2C) : Colors.white,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 14,
          ),
          hint: Text(
            'Select an intern',
            style: TextStyle(
              color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
              fontSize: 14,
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
          items: internNames.map((name) {
            return DropdownMenuItem(
              value: name,
              child: Text(name),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
