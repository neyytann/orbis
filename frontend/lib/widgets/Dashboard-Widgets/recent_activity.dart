import 'package:flutter/material.dart';

class RecentActivity extends StatelessWidget {
  final bool isDarkMode;
  final List<Map<String, dynamic>> activities;

  const RecentActivity({
    super.key,
    required this.isDarkMode,
    required this.activities,
  });

  String _formatDate(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return '';

    try {
      final date = DateTime.parse(isoDate).toLocal();
      return "${_monthName(date.month)} ${date.day}, ${date.year}";
    } catch (e) {
      return isoDate;
    }
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  String _formatDateTime(BuildContext context, String? date, String? time) {
    if (date == null || date.isEmpty) return '';

    try {
      final parsedDate = DateTime.parse(date).toLocal();

      String formattedDate =
          "${_monthName(parsedDate.month)} ${parsedDate.day}";

      if (time != null && time.isNotEmpty && time != "–") {
        final parsedTime = DateTime.parse("1970-01-01T$time");
        final formattedTime =
            TimeOfDay.fromDateTime(parsedTime).format(context);

        return "$formattedDate • $formattedTime";
      }

      return formattedDate;
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2E2E2E) : const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Activity",
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(color: Colors.grey),
          const SizedBox(height: 8),
          activities.isEmpty
              ? Text(
                  "No recent activity",
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 13,
                  ),
                )
              : Column(
                  children: activities.map((a) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: isDarkMode
                                ? Colors.grey[400]
                                : Colors.grey[600],
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: a['name'] ?? '',
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' clocked in · ${a['status']} · ${_formatDateTime(context, a['log_date'], a['time_in'])}',
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.grey[400]
                                          : Colors.grey[600],
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
