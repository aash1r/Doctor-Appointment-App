class User {
  String? cnic;
  String? password;
  String? confirmPassword;
  String? gender;
  String? userName;
  String? dob;

  User({
    this.cnic,
    this.confirmPassword,
    this.dob,
    this.gender,
    this.password,
    this.userName,
  });

  factory User.fromDocument(Map<String, dynamic> data) {
    return User(
      cnic: data['cnic'],
      password: data['password'],
      confirmPassword: data['confirmPassword'],
      gender: data['gender'],
      userName: data['userName'],
      dob: data['dob'],
    );
  }
}
