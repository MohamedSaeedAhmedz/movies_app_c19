import 'cast_model.dart';

class MovieDetailsModel {
  final int id;
  final String title;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final int likeCount;
  final int downloadCount;
  final String summary;
  final String descriptionFull;
  final String language;
  final String mpaRating;
  final String ytTrailerCode;
  final String backgroundImage;
  final String largeCoverImage;
  final String mediumCoverImage;
  final List<String> screenshots;
  final List<CastModel> cast;

  MovieDetailsModel({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.likeCount,
    required this.downloadCount,
    required this.summary,
    required this.descriptionFull,
    required this.language,
    required this.mpaRating,
    required this.ytTrailerCode,
    required this.backgroundImage,
    required this.largeCoverImage,
    required this.mediumCoverImage,
    required this.screenshots,
    required this.cast,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    final screenshots = <String>[
      if ((json['large_screenshot_image1'] ?? '').toString().isNotEmpty)
        json['large_screenshot_image1'],
      if ((json['large_screenshot_image2'] ?? '').toString().isNotEmpty)
        json['large_screenshot_image2'],
      if ((json['large_screenshot_image3'] ?? '').toString().isNotEmpty)
        json['large_screenshot_image3'],
    ];

    return MovieDetailsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      genres: List<String>.from(json['genres'] ?? []),
      likeCount: json['like_count'] ?? 0,
      downloadCount: json['download_count'] ?? 0,
      summary: json['description_intro'] ?? json['summary'] ?? json['synopsis'] ?? '',
      descriptionFull: (json['description_full'] ?? json['summary'] ?? ''),
      language: json['language'] ?? '',
      mpaRating: json['mpa_rating'] ?? '',
      ytTrailerCode: json['yt_trailer_code'] ?? '',
      backgroundImage: json['background_image'] ?? '',
      largeCoverImage: json['large_cover_image'] ?? '',
      mediumCoverImage: json['medium_cover_image'] ?? '',
      screenshots: screenshots,
      cast: json['cast'] != null
          ? List<CastModel>.from(
              (json['cast'] as List).map((c) => CastModel.fromJson(c)),
            )
          : [],
    );
  }
}