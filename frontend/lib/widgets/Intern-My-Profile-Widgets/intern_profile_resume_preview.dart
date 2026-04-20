import 'package:flutter/material.dart';
import 'dart:io';

class InternProfileResumePreview extends StatelessWidget {
  final bool isDarkMode;
  final File? resumeFile;
  final String? resumeUrl;

  const InternProfileResumePreview({
    super.key,
    required this.isDarkMode,
    required this.resumeFile,
    required this.resumeUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 560,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Resume image content
            if (resumeFile != null)
              Positioned.fill(
                child: Image.file(
                  resumeFile!,
                  fit: BoxFit.cover,
                ),
              )
            else if (resumeUrl != null && resumeUrl!.isNotEmpty)
              Positioned.fill(
                child: Image.network(
                  resumeUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _emptyResume(),
                ),
              )
            else
              _emptyResume(),

            // Expand icon top right
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () => _showFullResume(context),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.open_in_full,
                    size: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyResume() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.description_outlined, size: 60, color: Colors.grey[400]),
          const SizedBox(height: 12),
          Text(
            'No resume uploaded',
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }

  void _showFullResume(BuildContext context) {
    if (resumeFile == null && (resumeUrl == null || resumeUrl!.isEmpty)) return;

    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: resumeFile != null
              ? Image.file(resumeFile!)
              : Image.network(resumeUrl!),
        ),
      ),
    );
  }
}
