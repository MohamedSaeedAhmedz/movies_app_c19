import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_app/core/resources/app_color.dart';

import '../../data/data_sources/home_remote_data_source.dart';
import '../../data/models/movie_model.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/use_cases/get_movies_use_case.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/bottom_nav_bar.dart';
import 'tabs/home_tab.dart';
import 'tabs/search_tab.dart';
import 'tabs/explore_tab.dart';
import 'tabs/profile_tab.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  MovieModel? selectedMovie;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        getMoviesUseCase: GetMoviesUseCase(
          repository: HomeRepositoryImpl(
            remoteDataSource: HomeRemoteDataSource(),
          ),
        ),
      )..add(GetMoviesEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeMoviesSuccess &&
              selectedMovie == null &&
              state.movies.isNotEmpty) {
            selectedMovie = state.movies.length > 1
                ? state.movies[1]
                : state.movies[0];
          }

          return Scaffold(
            backgroundColor: MColors.black,

            extendBody: true,

            body: Stack(
              children: [
                // Full Screen Background
                if (currentIndex == 0 && selectedMovie != null)
                  Positioned.fill(
                    child: Image.network(
                      selectedMovie!.backgroundImage,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: MColors.black);
                      },
                    ),
                  ),

                // Dark Overlay
                if (currentIndex == 0 && selectedMovie != null)
                  Positioned.fill(
                    child: Container(color: MColors.black.withOpacity(0.65)),
                  ),

                // Tabs
                IndexedStack(
                  index: currentIndex,
                  children: [
                    HomeTab(
                      onMovieChanged: (movie) {
                        setState(() {
                          selectedMovie = movie;
                        });
                      },
                    ),
                    const SearchTab(),
                    const ExploreTab(),
                    const ProfileTab(),
                  ],
                ),
              ],
            ),

            // Navigation Bar
            bottomNavigationBar: BottomNavBar(
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });

                context.read<HomeBloc>().add(ChangeNavIndexEvent(index));
              },
            ),
          );
        },
      ),
    );
  }
}
