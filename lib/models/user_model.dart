//User Model
class UserModel {
  String uid;
  String username;
  String email;
  String name;
  String photoUrl;
  String zipcode;

  UserModel(
      {this.uid,
      this.username,
      this.email,
      this.name,
      this.photoUrl,
      this.zipcode});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      username: data['username'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      zipcode: data['zipcode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
        "name": name,
        "photoUrl": photoUrl,
        "zipcode": zipcode
      };
}
