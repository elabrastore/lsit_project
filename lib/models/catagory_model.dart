// ignore_for_file: file_names

class CategoriesModel {
  final String categoryId;
  final String catagoryImag;
  final String catagoryName;
  final dynamic createdAt;
  final dynamic updateAt;

  CategoriesModel({
    required this.categoryId,
    required this.catagoryImag,
    required this.catagoryName,
    required this.createdAt,
    required this.updateAt,
  });

  // Serialize the UserModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'catagoryImag': catagoryImag,
      'catagoryName': catagoryName,
      'createdAt': createdAt,
      'updateAt': updateAt,
    };
  }

  // Create a UserModel instance from a JSON map
  factory CategoriesModel.fromMap(Map<String, dynamic> json) {
    return CategoriesModel(
      categoryId: json['categoryId'],
      catagoryImag: json['catagoryImag'],
      catagoryName: json['catagoryName'],
      createdAt: json['createdAt'],
      updateAt: json['updateAt'],
    );
  }
}
