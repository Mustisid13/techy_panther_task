class User {
  int id;
  String name;
  String email;
  String gender;
  String status;

  User({required this.id,required this.name,required this.email,required this.gender,required this.status});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id : json['id'],
        name : json['name'],
        email : json['email'],
        gender : json['gender'],
        status : json['status'],);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['status'] = status;
    return data;
  }
}