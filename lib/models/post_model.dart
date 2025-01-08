import '../services/image_crud.dart';

class PostModel {
  int? id;
  String? image;
  String? description;
  String? user;
  String? userProfilePic;
  List? usersWhoLiked;

  PostModel({
    required this.id,
    required this.image,
    required this.description,
    required this.user,
    required this.userProfilePic,
    required this.usersWhoLiked,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return PostModel(
      id: json['id'],
      user: json['user'],
      userProfilePic: json["userProfilePic"],
      image: ImageCrud().getPublicImageUrl(json['image']),
      description: json['description'],
      usersWhoLiked: json["usersWhoLiked"],
    );
  }
}
