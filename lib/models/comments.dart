//Comment Model
class Comments {
  String id;
  String description;
  String dateAdded;
  String storeId;
  String userId;

  Comments(
      {this.id, this.description, this.dateAdded, this.storeId, this.userId});

  factory Comments.fromMap(Map data) {
    return Comments(
      id: data['uid'],
      description: data['description'] ?? '',
      dateAdded: data['dateAdded'] ?? '',
      storeId: data['storeId'] ?? '',
      userId: data['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "dateAdded": dateAdded,
        "storeId": storeId,
        "userId": userId
      };
}
