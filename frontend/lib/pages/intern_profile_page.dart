import 'package:flutter/material.dart';
import 'package:interfaces/pages/time_logs.dart';
import '../widgets/Dashboard-Widgets/top_bar.dart';
import '../widgets/Dashboard-Widgets/sidebar.dart';
import '../widgets/Intern-My-Profile-Widgets/intern_profile_image_section.dart';
import '../widgets/Intern-My-Profile-Widgets/intern_profile_resume_preview.dart';

import 'dashboard.dart';

class InternProfilePage extends StatefulWidget {
  final dynamic intern;
  final bool isDarkMode;
  final String firstName;
  final VoidCallback onToggleDarkMode;

  const InternProfilePage({
    super.key,
    required this.intern,
    required this.isDarkMode,
    required this.firstName,
    required this.onToggleDarkMode,
  });

  @override
  State<InternProfilePage> createState() => _InternProfilePageState();
}

class _InternProfilePageState extends State<InternProfilePage> {
  int selectedIndex = 1;
  late bool _isDarkMode;

  static const double sidebarWidth = 65;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    widget.onToggleDarkMode();
  }

  void _onSidebarTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _logout() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }

  Widget _getBody() {
    switch (selectedIndex) {
      case 0:
        return DashboardOverviewPage(
          firstName: widget.firstName,
          isDarkMode: _isDarkMode,
        );

      case 1:
        return _buildProfileBody();

      case 2:
        return TimeLogsPage(
          firstName: widget.firstName,
          isDarkMode: _isDarkMode,
        );

      default:
        return const Center(child: Text("Page not found"));
    }
  }

  Widget _buildProfileBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: _isDarkMode ? Colors.white : Colors.black,
                ),
                const SizedBox(width: 6),
                Text(
                  "Back",
                  style: TextStyle(
                    color: _isDarkMode ? Colors.white : Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InternProfileImageSection(
                      isDarkMode: _isDarkMode,
                      pickedImageFile: null,
                      profileImageUrl: widget.intern['photo'] != null &&
                              widget.intern['photo'].toString().isNotEmpty
                          ? "http://localhost:8080/${widget.intern['photo'].toString().replaceFirst('/', '')}"
                          : null,
                      idNumber: widget.intern['id_number'] ?? '',
                      isEditing: false,
                      onChangeImage: () {},
                      onRemoveImage: () {},
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                            child: _buildField(
                                "First Name", widget.intern['first_name'])),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: _buildField(
                                "Last Name", widget.intern['last_name']))
                      ],
                    ),
                    _buildField("Program", widget.intern['program']),
                    _buildField("School", widget.intern['school']),
                    Row(
                      children: [
                        Expanded(
                          child: _buildField("Email", widget.intern['email']),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildField(
                            "Phone",
                            widget.intern['phone_number'],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 2,
                child: Center(
                  child: InternProfileResumePreview(
                    isDarkMode: _isDarkMode,
                    resumeFile: null,
                    resumeUrl: widget.intern['resume'] != null &&
                            widget.intern['resume'].toString().isNotEmpty
                        ? "http://localhost:8080/${widget.intern['resume'].toString().replaceFirst('/', '')}"
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.grey[100],
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(left: sidebarWidth),
              child: Column(
                children: [
                  TopBar(
                    isDarkMode: _isDarkMode,
                    firstName: widget.firstName,
                    onToggleDarkMode: _toggleDarkMode,
                  ),
                  Expanded(child: _getBody()),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Sidebar(
              isDarkMode: _isDarkMode,
              selectedIndex: selectedIndex,
              onItemSelected: _onSidebarTap,
              onLogout: _logout,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 14,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _isDarkMode ? const Color(0xFF9E9E9E) : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: _isDarkMode
                  ? const Color(0xFF2C2C2C)
                  : const Color.fromARGB(255, 189, 189, 189),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              value ?? '',
              style: TextStyle(
                color: _isDarkMode
                    ? const Color.fromARGB(255, 106, 105, 105)
                    : const Color.fromARGB(255, 32, 32, 32),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
