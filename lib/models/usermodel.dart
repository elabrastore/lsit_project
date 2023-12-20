class UserModel {
  final String uId;
  final String username;
  final String email;
  final String phone;
  final String userimage;
  final String userDevicetoken;
  final String street;
  final String country;
  final String useraddress;
  final bool isAdmin;
  final bool isActive;
  final dynamic createdOn;

  UserModel(
      {required this.uId,
      required this.username,
      required this.email,
      required this.phone,
      required this.userimage,
      required this.userDevicetoken,
      required this.street,
      required this.country,
      required this.useraddress,
      required this.isAdmin,
      required this.isActive,
      required this.createdOn});

  Map<String, dynamic> toMap() {
    return {
      "uId": uId,
      "username": username,
      "email": email,
      "phone": phone,
      "userimage": userimage,
      "userDevicetoken": userDevicetoken,
      "street": street,
      "country": country,
      "useraddress": useraddress,
      "isAdmin": isAdmin, // Correct field name
      "isActive": isActive,
      "createdOn": createdOn,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      uId: json["uId"],
      username: json["username"],
      email: json["email"],
      phone: json["phone"],
      userimage: json["userimage"],
      userDevicetoken: json["userDevicetoken"],
      street: json["street"],
      country: json["useraddress"],
      useraddress: json["useraddress"],
      isAdmin: json["isadmin"],
      isActive: json["isactive"],
      createdOn: json["createdon"].toString(),
    );
  }
}
