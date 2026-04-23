import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InternProfileImageSection extends StatelessWidget {
  final bool isDarkMode;
  final XFile? pickedImageFile; // web-safe: XFile instead of dart:io File
  final String? profileImageUrl;
  final String idNumber;
  final VoidCallback onChangeImage;
  final VoidCallback onRemoveImage;

  const InternProfileImageSection({
    super.key,
    required this.isDarkMode,
    required this.pickedImageFile,
    required this.profileImageUrl,
    required this.idNumber,
    required this.onChangeImage,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image — web-safe preview
            _buildAvatar(),
            const SizedBox(width: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: onChangeImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? const Color(0xFF3A3A3A)
                            : const Color(0xFFE0E0E0),
                        foregroundColor:
                            isDarkMode ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                      child: const Text('Change Image'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: onRemoveImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? const Color(0xFF3A3A3A)
                            : const Color(0xFFE0E0E0),
                        foregroundColor:
                            isDarkMode ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                      child: const Text('Remove Image'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Support JPEG and PNG formats under 2mb.',
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'ID NO: $idNumber',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Divider(
          color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    // If user just picked a new image, show it as a preview using FutureBuilder
    if (pickedImageFile != null) {
      return FutureBuilder<ImageProvider>(
        future: _loadPickedImage(),
        builder: (context, snapshot) {
          return CircleAvatar(
            key: ValueKey(pickedImageFile!.name),
            radius: 70,
            backgroundColor: isDarkMode
                ? const Color(0xFF3A3A3A)
                : const Color(0xFFDDDDDD),
            backgroundImage: snapshot.data,
            child: snapshot.data == null
                ? const CircularProgressIndicator()
                : null,
          );
        },
      );
    }

    // Otherwise show the server URL or placeholder
    return CircleAvatar(
      key: ValueKey(profileImageUrl ?? ''),
      radius: 70,
      backgroundColor:
          isDarkMode ? const Color(0xFF3A3A3A) : const Color(0xFFDDDDDD),
      backgroundImage: profileImageUrl != null && profileImageUrl!.isNotEmpty
          ? NetworkImage(profileImageUrl!)
          : null,
      child: profileImageUrl == null || profileImageUrl!.isEmpty
          ? Icon(
              Icons.person,
              size: 60,
              color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
            )
          : null,
    );
  }

  // Web-safe: read XFile as bytes and convert to MemoryImage
  Future<ImageProvider> _loadPickedImage() async {
    final bytes = await pickedImageFile!.readAsBytes();
    return MemoryImage(bytes);
  }
}