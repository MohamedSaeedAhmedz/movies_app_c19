class UserModel {
  String selectedAvatarPath;
  String name;
  String phoneNumber;

  UserModel({
    required this.selectedAvatarPath,
    required this.name,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      selectedAvatarPath: json['selectedAvatarPath'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'selectedAvatarPath': selectedAvatarPath,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }
}
