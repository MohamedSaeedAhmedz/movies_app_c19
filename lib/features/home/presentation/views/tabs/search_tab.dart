import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/core/resources/app_icon.dart';
import 'package:movies_app/core/resources/app_image.dart';

import '../../bloc/search_bloc.dart';
import '../../bloc/search_event.dart';
import '../../bloc/search_state.dart';
import '../../widgets/search_movie_card.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                onSubmitted: (query) {
                  context.read<SearchBloc>().add(SearchMoviesEvent(query));
                },
                style: const TextStyle(color: MColors.white),
                cursorColor: MColors.yellow,
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: MColors.white.withOpacity(0.6)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ImageIcon(
                      AssetImage(MIcons.search),
                      color: MColors.white,
                      size: 24,
                    ),
                  ),
                  filled: true,
                  fillColor: MColors.dgrey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchInitial) {
                      return Center(
                        child: Image.asset(
                          MImages.popcorn,
                          width: 150,
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                      );
                    }

                    if (state is SearchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: MColors.yellow),
                      );
                    }

                    if (state is SearchError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: MColors.white),
                        ),
                      );
                    }

                    if (state is SearchSuccess) {
                      if (state.movies.isEmpty) {
                        return const Center(
                          child: Text(
                            'No movies found',
                            style: TextStyle(color: MColors.white),
                          ),
                        );
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.only(top: 16),
                        itemCount: state.movies.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 191 / 279,
                            ),
                        itemBuilder: (context, index) {
                          final movie = state.movies[index];

                          return SearchMovieCard(movie: movie);
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
