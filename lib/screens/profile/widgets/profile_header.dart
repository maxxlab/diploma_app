// lib/screens/profile/widgets/profile_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/extensions/context_extension.dart';
import 'package:tourist_app/screens/profile/widgets/profile_image_picker.dart';
import '../../../models/user.dart';
import '../bloc/profile_bloc.dart';

class ProfileHeader extends StatelessWidget {
  final User user;

  const ProfileHeader({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ProfileImagePicker(
              imageUrl: user.profileImage,
              onImagePicked: (imageUrl) {
                context.read<ProfileBloc>().add(
                  UpdateProfileImage(imageUrl: imageUrl),
                );
              },
            ),
            const SizedBox(height: 24),
            _buildNameSection(context),
            const SizedBox(height: 16),
            _buildEmailSection(context),
            if (user.isVerified) ...[
              const SizedBox(height: 16),
              _buildVerifiedBadge(context),
            ],
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildNameSection(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final isUpdating = state is ProfileLoaded && state.isUpdatingName;

        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    user.name ?? 'User',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap to edit name',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (isUpdating)
              Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.only(left: 12),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: context.colorScheme.primary,
                ),
              )
            else
              IconButton(
                onPressed: () => _showEditNameDialog(context),
                icon: Icon(
                  Icons.edit,
                  size: 20,
                  color: Colors.grey.shade600,
                ),
                tooltip: 'Edit Name',
              ),
          ],
        );
      },
    );
  }

  Widget _buildEmailSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.email_outlined,
            size: 20,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              user.email,
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifiedBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified,
            size: 16,
            color: Colors.green.shade600,
          ),
          const SizedBox(width: 6),
          Text(
            'Verified Account',
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.green.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditNameDialog(BuildContext context) {
    final nameController = TextEditingController(text: user.name ?? '');

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Name'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
          ),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newName = nameController.text.trim();
              if (newName.isNotEmpty && newName != user.name) {
                context.read<ProfileBloc>().add(
                  UpdateProfileName(name: newName),
                );
              }
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}