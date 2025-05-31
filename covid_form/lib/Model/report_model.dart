class Report {
  final String? firstname;
  final String? lastname;
  final String? nickname;
  final String? gender;
  final int? age;
  final List<String>? syntoms;

  Report({
    this.firstname,
    this.lastname,
    this.nickname,
    this.gender,
    this.age,
    this.syntoms,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'nickname': nickname,
      'gender': gender,
      'age': age,
      'syntoms': syntoms,
    };
  }

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      firstname: json['firstname'],
      lastname: json['lastname'],
      nickname: json['nickname'],
      gender: json['gender'],
      age: json['age'],
      syntoms: List<String>.from(json['syntoms'] ?? []),
    );
  }
}
