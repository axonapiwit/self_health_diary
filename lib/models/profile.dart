class Profile {
  String fname;
  String lname;
  String role;

  Profile({
    this.fname = '',
    this.lname = '',
    this.role = '',
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      fname: json['fname'],
      lname: json['lname'],
      role: json['role'],
    );
  }
}