import 'package:flutter/material.dart';
import '../../../models/user.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../theme/text_styles.dart';

class UserProfileCard extends StatelessWidget {
  final User user;

  const UserProfileCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user.profileImage != null)
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.profileImage!),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              user.name ?? 'User',
              style: AppTextStyles.headline,
            ),
            const SizedBox(height: 8),
            Text(
              user.email,
              style: AppTextStyles.bodyRegular,
            ),
            if (user.isVerified) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.verified,
                    color: context.colorScheme.primary,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Verified',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}