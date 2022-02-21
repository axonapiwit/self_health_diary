class Profile {
  String fname;
  String lname;
  int height;
  int weight;
  String gender;
  String role;

  Profile({
    this.fname = '',
    this.lname = '',
    this.height = 0,
    this.weight = 0,
    this.gender = '',
    this.role = '',
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      fname: json['fname'],
      lname: json['lname'],
      height: json['height'],
      weight: json['weight'],
      gender: json['gender'],
      role: json['role'],
    );
  }
}
