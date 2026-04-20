import 'package:flutter/material.dart';

class TimeLogsSearchBar extends StatelessWidget {
  final bool isDarkMode;
  final String searchQuery;
  final ValueChanged<String> onChanged;

  const TimeLogsSearchBar({
    super.key,
    required this.isDarkMode,
    required this.searchQuery,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2C2C2C) : const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDarkMode ? const Color(0xFF3A3A3A) : const Color(0xFFDDDDDD),
        ),
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: 'Search intern name...',
          hintStyle: TextStyle(
            color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
