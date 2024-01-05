class Message {
  String? message;
  String? cnic;
  DateTime? currentDate;

  Message({
    this.cnic,
    this.currentDate,
    this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      cnic: json['cnic'],
      message: json['message'],
      // currentDate: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cnic': cnic,
      'message': message,
    };
  }
}
