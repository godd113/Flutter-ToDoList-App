final String tableUser = 'users';

class ModelUser {
  int userID;
  String userName;
  String email;
  String uuid;

  ModelUser(
      {required this.userID,
      required this.userName,
      required this.email,
      required this.uuid});

  ModelUser copy(
          {int? userID, String? userName, String? email, String? uuid}) =>
      ModelUser(
          userID: userID ?? this.userID,
          userName: userName ?? this.userName,
          email: email ?? this.email,
          uuid: uuid ?? this.uuid);

  static ModelUser fromJson(Map<String, Object?> json) => ModelUser(
      userID: json['_id'] as int,
      userName: json['userName'] as String,
      email: json['email'] as String,
      uuid: json['uuid'] as String);

  Map<String, Object?> toJson() => {
        UserFields.userID: userID,
        UserFields.userName: userName,
        UserFields.email: email,
        UserFields.uuid: uuid
      };
}

class UserFields {
  // สร้างเป็นลิสรายการสำหรับคอลัมน์ฟิลด์
  static final List<String> values = [userID, userName, email];

  // กำหนดแต่ละฟิลด์ของตาราง ต้องเป็น String ทั้งหมด
  static const String userID =
      '_id'; // ตัวแรกต้องเป็น _id ส่วนอื่นใช้ชื่อะไรก็ได้
  static const String userName = 'userName';
  static const String email = 'email';
  static const String uuid = 'uuid';
}
