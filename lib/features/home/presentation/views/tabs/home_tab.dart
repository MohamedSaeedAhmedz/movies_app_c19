import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/core/resources/app_image.dart';

import 'package:movies_app/features/home/presentation/widgets/featured_movies.dart';
import 'package:movies_app/features/home/presentation/widgets/movie_section.dart';

import 'package:movies_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:movies_app/features/home/presentation/bloc/home_state.dart';

import '../../../data/models/movie_model.dart';

class HomeTab extends StatelessWidget {
  final ValueChanged<MovieModel>? onMovieChanged;

  const HomeTab({super.key, this.onMovieChanged});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeMoviesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeMoviesError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: MColors.white),
              textAlign: TextAlign.center,
            ),
          );
        }

        if (state is HomeMoviesSuccess) {
          final movies = state.movies;

          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Available Now
                  Center(
                    child: Image.asset(MImages.an, width: 267, height: 93),
                  ),

                  const SizedBox(height: 20),

                  // Featured Movies
                  FeaturedMovies(
                    movies: movies,
                    onMovieChanged: onMovieChanged,
                  ),

                  const SizedBox(height: 28),

                  // Watch Now
                  Center(
                    child: Image.asset(MImages.wn, width: 354, height: 146),
                  ),

                  const SizedBox(height: 20),

                  // Action Movies
                  MovieSection(title: 'Action', movies: movies),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
