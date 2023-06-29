class UserModel {
  String? name;
  int? phone;
  dynamic? createdAt;

  UserModel({this.name, this.phone, this.createdAt});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'createdAt': createdAt,
    };
  }

  UserModel copyWith({
    String? name,
    int? phone,
    int? userNumber,
    dynamic? createdAt,
  }) {
    return UserModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
