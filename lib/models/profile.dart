class Profile {
  String fname;
  String lname;
  String gender;
  String role;
  int height;
  int weight;
  int bmi;

  Profile({
    this.fname = '',
    this.lname = '',
    this.gender = '',
    this.role = '',
    this.weight = 0,
    this.height = 0,
    this.bmi = 0,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      fname: json['fname'],
      lname: json['lname'],
      gender: json['gender'],
      role: json['role'],
      height: json['height'],
      weight: json['weight'],
      bmi: json['bmi'],
    );
  }
}
