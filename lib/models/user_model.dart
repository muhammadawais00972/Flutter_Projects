
class UserModel{
  final String id;
  final String email;
  final  String displayName;
  final String photoURL;
  final bool isOnline;
  final DateTime lastSeen;
  final DateTime createdAt;

  UserModel({required this.email,
       required this.displayName,
     required this.photoURL,
       required this.isOnline,
     required  this.lastSeen,
    required this.id,
        required this.createdAt,
});


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'isOnline': isOnline,
      'lastSeen': lastSeen,
      'createdAt': createdAt,
    };
  }
  static UserModel fromMap(Map<String,dynamic>map,String id) {
    return UserModel(
        email: map['email'] ?? '',
        displayName: map['displayName']  ?? '',
        photoURL: map['photoURL']  ?? '',
        isOnline: map['isOnline']  ?? false,
        lastSeen:DateTime.fromMicrosecondsSinceEpoch(map[' lastSeen'] ??0),
        id:  map['id']  ?? '',
        createdAt:DateTime.fromMicrosecondsSinceEpoch(map[' createdAt'] ??0),
    );

  }
  UserModel copywith({
    String ? id,
    String ? email,
    String ?displayName,
    String ?photoURL,
    bool ? isOnline,
    DateTime?lastSeen,
    DateTime?createdAt,
}){
    return UserModel(
        email: email?? this.email,
        displayName: displayName?? this.displayName,
        photoURL: photoURL?? this.photoURL,
        isOnline: isOnline?? this.isOnline,
        lastSeen: lastSeen?? this.lastSeen,
        id: id?? this.id,
        createdAt: createdAt?? this.createdAt);
  }
}