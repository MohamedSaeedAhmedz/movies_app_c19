import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/app_color.dart';

import '../../data/models/movie_model.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 180,
      decoration: BoxDecoration(
        color: MColors.dgrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.network(
              movie.mediumCoverImage,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.movie, color: MColors.white, size: 40),
                );
              },
            ),

            // Rating
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                decoration: BoxDecoration(
                  color: MColors.black.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 15),
                    const SizedBox(width: 3),
                    Text(
                      movie.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: MColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
