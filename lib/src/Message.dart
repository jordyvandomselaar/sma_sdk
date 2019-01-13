class Message {
  final String message;
  final String email;
  String url;
  String password;
  DateTime expirationDate;

  Message(this.message, this.email);

  Message.fromJson(Map<String, dynamic> json)
      : message = json["message"],
        email = json["email"],
        url = json["url"],
        password = json["password"],
        expirationDate = DateTime.fromMicrosecondsSinceEpoch(
            json["expiration_date"]);

  bool isExpired() {
    return DateTime.now().microsecondsSinceEpoch >
        this.expirationDate.microsecondsSinceEpoch;
  }

  bool isValid() {
    return !this.isExpired();
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "email": email,
        "url": url,
        "password": password,
        "expiration_date": expirationDate.microsecondsSinceEpoch
      };
}
