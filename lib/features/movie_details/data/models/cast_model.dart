class CastModel {
  final String name;
  final String characterName;
  final String urlSmallImage;

  CastModel({
    required this.name,
    required this.characterName,
    required this.urlSmallImage,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'] ?? '',
      characterName: json['character_name'] ?? '',
      urlSmallImage: json['url_small_image'] ?? '',
    );
  }
}