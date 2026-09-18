import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/features/home/data/models/movie_model.dart';

import '../../data/data_sources/movie_details_remote_data_source.dart';
import '../../data/models/movie_details_model.dart';
import '../../data/repositories/movie_details_repository_impl.dart';
import '../../domain/use_cases/get_movie_details_use_case.dart';
import '../bloc/movie_details_bloc.dart';
import '../bloc/movie_details_event.dart';
import '../bloc/movie_details_state.dart';
import '../widgets/cast_tile.dart';
import '../widgets/genre_chip.dart';
import '../widgets/screenshot_gallery.dart';
import '../widgets/similar_movie_card.dart';
import '../widgets/stat_badge.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieDetailsBloc(
        getMovieDetailsUseCase: GetMovieDetailsUseCase(
          repository: MovieDetailsRepositoryImpl(
            remoteDataSource: MovieDetailsRemoteDataSource(),
          ),
        ),
      )..add(GetMovieDetailsEvent(movieId)),
      child: Scaffold(
        backgroundColor: MColors.black,
        body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: MColors.yellow),
              );
            }

            if (state is MovieDetailsError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    state.message,
                    style: const TextStyle(color: MColors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            final success = state as MovieDetailsSuccess;

            return _MovieDetailsBody(
              details: success.details,
              similarMovies: success.similarMovies,
            );
          },
        ),
      ),
    );
  }
}

class _MovieDetailsBody extends StatelessWidget {
  final MovieDetailsModel details;
  final List<MovieModel> similarMovies;

  const _MovieDetailsBody({
    required this.details,
    required this.similarMovies,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Poster(details: details),

          const SizedBox(height: 16),

          Center(
            child: Text(
              details.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: MColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              details.year > 0 ? details.year.toString() : '',
              style: const TextStyle(color: MColors.grey, fontSize: 14),
            ),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: MColors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Watch',
                  style: TextStyle(
                    color: MColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StatBadge(
                icon: Icons.thumb_up,
                iconColor: MColors.yellow,
                label: '${details.likeCount}',
              ),
              const SizedBox(width: 10),
              StatBadge(
                icon: Icons.download,
                iconColor: MColors.grey,
                label: '${details.downloadCount}',
              ),
              const SizedBox(width: 10),
              StatBadge(
                icon: Icons.star,
                iconColor: Colors.amber,
                label: details.rating.toStringAsFixed(1),
              ),
            ],
          ),

          const SizedBox(height: 28),

          if (details.screenshots.isNotEmpty) ...[
            const _SectionTitle('Screen Shots'),
            const SizedBox(height: 12),
            ScreenshotGallery(screenshots: details.screenshots),
            const SizedBox(height: 28),
          ],

          if (similarMovies.isNotEmpty) ...[
            const _SectionTitle('Similar'),
            const SizedBox(height: 12),
            SizedBox(
              height: 170,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: similarMovies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SimilarMovieCard(movie: similarMovies[index]),
                  );
                },
              ),
            ),
            const SizedBox(height: 28),
          ],

          const _SectionTitle('Summary'),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              details.descriptionFull.isNotEmpty
                  ? details.descriptionFull
                  : details.summary,
              style: const TextStyle(
                color: MColors.grey,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 28),

          if (details.cast.isNotEmpty) ...[
            const _SectionTitle('Cast'),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: details.cast
                    .map((cast) => CastTile(cast: cast))
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),
          ],

          if (details.genres.isNotEmpty) ...[
            const _SectionTitle('Genres'),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: details.genres
                    .map((genre) => GenreChip(label: genre))
                    .toList(),
              ),
            ),
          ],

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _Poster extends StatelessWidget {
  final MovieDetailsModel details;

  const _Poster({required this.details});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            details.backgroundImage.isNotEmpty
                ? details.backgroundImage
                : details.largeCoverImage,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(color: MColors.dgrey),
          ),

          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, MColors.black],
                stops: [0.6, 1.0],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CircleIconButton(
                    icon: Icons.arrow_back_ios_new,
                    onTap: () => Navigator.pop(context),
                  ),
                  _CircleIconButton(icon: Icons.bookmark_border, onTap: () {}),
                ],
              ),
            ),
          ),

          Center(
            child: _CircleIconButton(
              icon: Icons.play_arrow,
              size: 64,
              iconSize: 32,
              backgroundColor: MColors.yellow,
              iconColor: MColors.black,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final Color iconColor;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.size = 40,
    this.iconSize = 18,
    this.backgroundColor = MColors.black,
    this.iconColor = MColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(
            backgroundColor == MColors.black ? 0.6 : 1,
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: iconSize),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          color: MColors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}