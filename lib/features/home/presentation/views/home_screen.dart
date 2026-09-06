import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_app/core/resources/app_color.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/bottom_nav_bar.dart';
import 'tabs/home_tab.dart';
import 'tabs/search_tab.dart';
import 'tabs/explore_tab.dart';
import 'tabs/profile_tab.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final currentIndex = state is HomeNavChanged
              ? state.currentIndex
              : 0;

          return Scaffold(
            backgroundColor: MColors.black,
            body: IndexedStack(
              index: currentIndex,
              children: const [
                HomeTab(),
                SearchTab(),
                ExploreTab(),
                ProfileTab(),
              ],
            ),
            bottomNavigationBar: BottomNavBar(
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<HomeBloc>().add(
                  ChangeNavIndexEvent(index),
                );
              },
            ),
          );
        },
      ),
    );
  }
}