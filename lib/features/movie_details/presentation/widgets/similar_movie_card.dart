import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/features/home/data/models/movie_model.dart';

import '../views/movie_details_screen.dart';

class SimilarMovieCard extends StatelessWidget {
  final MovieModel movie;

  const SimilarMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailsScreen(movieId: movie.id),
          ),
        );
      },
      child: Container(
        width: 130,
        height: 170,
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
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.movie, color: MColors.white, size: 40),
                ),
              ),
              if (movie.genres.isNotEmpty)
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: MColors.black.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      movie.genres.first,
                      style: const TextStyle(
                        color: MColors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}