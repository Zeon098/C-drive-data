class UserModel {
  String id = '';
  String name = '';
  String email = '';
  String gender = '';
  String image = '';
  String createdAt = '';
  String password = '';
  String confirmPassword = '';
  String userUuid = '';
  bool inApppaymentSubscription = false;

  UserModel.empty();

  UserModel({
    this.id = '',
    required this.name,
    required this.email,
    this.gender = '',
    this.image = '',
    this.createdAt = '',
    this.password = '',
    this.confirmPassword = '',
    this.userUuid = '',
    this.inApppaymentSubscription = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      gender: json['gender'] ?? '',
      image: json['image'] ?? '',
      createdAt: json['createdAt'] ?? '',
      userUuid: json['userUuid'] ?? '',
      inApppaymentSubscription: json['inApppaymentSubscription'] ?? false,
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? gender,
    String? image,
    String? userUuid,
    bool? inApppaymentSubscription,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      createdAt: createdAt,
      userUuid: userUuid ?? this.userUuid,
      inApppaymentSubscription:
          inApppaymentSubscription ?? this.inApppaymentSubscription,
    );
  }

  Map<String, dynamic> toJsonToStore() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'image': image,
      'createdAt': createdAt,
      'userUuid': userUuid,
      'inApppaymentSubscription': inApppaymentSubscription,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
