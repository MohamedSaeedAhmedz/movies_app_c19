import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/app_color.dart';

import '../../data/models/cast_model.dart';

class CastTile extends StatelessWidget {
  final CastModel cast;

  const CastTile({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MColors.dgrey,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: cast.urlSmallImage.isNotEmpty
                ? Image.network(
                    cast.urlSmallImage,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _avatarPlaceholder(),
                  )
                : _avatarPlaceholder(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name : ${cast.name}',
                  style: const TextStyle(
                    color: MColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Character : ${cast.characterName}',
                  style: const TextStyle(color: MColors.grey, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatarPlaceholder() {
    return Container(
      width: 48,
      height: 48,
      color: MColors.black,
      child: const Icon(Icons.person, color: MColors.grey, size: 24),
    );
  }
}