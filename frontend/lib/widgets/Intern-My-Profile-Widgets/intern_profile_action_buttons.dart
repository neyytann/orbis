import 'package:flutter/material.dart';

class InternProfileActionButtons extends StatelessWidget {
  final bool isDarkMode;
  final bool isSaving;
  final VoidCallback onSave;
  final VoidCallback onUploadResume;

  const InternProfileActionButtons({
    super.key,
    required this.isDarkMode,
    required this.isSaving,
    required this.onSave,
    required this.onUploadResume,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Save Changes
        ElevatedButton(
          onPressed: isSaving ? null : onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00BCD4),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: isSaving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Text(
                  'Save Changes',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
        ),
        const SizedBox(width: 12),
        // Upload Resume
        ElevatedButton(
          onPressed: onUploadResume,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isDarkMode ? const Color(0xFF3A3A3A) : const Color(0xFFE0E0E0),
            foregroundColor: isDarkMode ? Colors.white : Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Upload Resume',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
