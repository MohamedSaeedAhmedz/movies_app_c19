import 'package:flutter/material.dart';
import '../../../core/resources/app_color.dart';
import '../../../core/routes/AppRoutes.dart';
import '../model/onboarding_item.dart';
import '../widgets/onboarding_background.dart';
import '../widgets/onboarding_content.dart';


class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingItem> _pages = [
    OnboardingItem(
      imagePath: 'assets/image/ON1.png',
      title: 'Find Your Next\nFavorite Movie Here',
      description:
      'Get access to a huge library of movies\nto suit all tastes. You will surely like it.',
      buttonText: 'Explore Now',
    ),
    OnboardingItem(
      imagePath: 'assets/image/ON2.png',
      title: 'Discover Movies',
      description:
      'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
      buttonText: 'Next',
    ),
    OnboardingItem(
      imagePath: 'assets/image/ON3.png',
      title: 'Explore All Genres',
      description:
      'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
      buttonText: 'Next',
    ),
    OnboardingItem(
      imagePath: 'assets/image/ON4.png',
      title: 'Create Watchlists',
      description:
      'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
      buttonText: 'Next',
    ),
    OnboardingItem(
      imagePath: 'assets/image/ON5.png',
      title: 'Rate, Review, and Learn',
      description:
      'Share your thoughts on the movies you\'ve watched. Dive deep into film details and help others discover great movies with your reviews.',
      buttonText: 'Next',
    ),
    OnboardingItem(
      imagePath: 'assets/image/ON6.png',
      title: 'Start Watching Now',
      description: '',
      buttonText: 'Finish',
    ),
  ];

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.login,
      );
    }
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.black,
      body: PageView.builder(
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final page = _pages[index];

          return Stack(
            fit: StackFit.expand,
            children: [
              OnboardingBackground(page: page),
              Column(
                children: [
                  const Spacer(),
                  OnboardingContent(
                    page: page,
                    currentIndex: _currentIndex,
                    pagesLength: _pages.length,
                    onNext: _nextPage,
                    onBack: _previousPage,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}