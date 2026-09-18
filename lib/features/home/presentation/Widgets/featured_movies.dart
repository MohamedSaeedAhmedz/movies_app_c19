import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/features/movie_details/presentation/views/movie_details_screen.dart';

import '../../data/models/movie_model.dart';

class FeaturedMovies extends StatefulWidget {
  final List<MovieModel> movies;
  final ValueChanged<MovieModel>? onMovieChanged;

  const FeaturedMovies({super.key, required this.movies, this.onMovieChanged});

  @override
  State<FeaturedMovies> createState() => _FeaturedMoviesState();
}

class _FeaturedMoviesState extends State<FeaturedMovies> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 0.58, initialPage: 1);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final movies = widget.movies.take(3).toList();

      if (movies.isNotEmpty) {
        final index = movies.length > 1 ? 1 : 0;

        widget.onMovieChanged?.call(movies[index]);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movies = widget.movies.take(3).toList();

    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 390,
      child: PageView.builder(
        controller: _pageController,
        itemCount: movies.length,
        onPageChanged: (index) {
          widget.onMovieChanged?.call(movies[index]);
        },
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double scale = 0.8;

              if (_pageController.position.haveDimensions) {
                final page =
                    _pageController.page ??
                    _pageController.initialPage.toDouble();

                final difference = (page - index).abs();

                scale = (1 - (difference * 0.2)).clamp(0.8, 1.0).toDouble();
              }

              return Center(
                child: Transform.scale(
                  scale: scale,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                       context,
                       MaterialPageRoute(
                        builder: (_) => MovieDetailsScreen(movieId: movies[index].id),
                      ),
                    );
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 234,
                      height: 351,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: MColors.dgrey,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Image.network(
                              movies[index].largeCoverImage,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.movie,
                                    color: MColors.white,
                                    size: 40,
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: MColors.black.withOpacity(0.75),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      movies[index].rating.toStringAsFixed(1),
                                      style: const TextStyle(
                                        color: MColors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
