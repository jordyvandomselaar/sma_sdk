class Message {
  final String message;
  final String email;
  String url;
  String password;
  DateTime expirationDate;
  DateTime createdAt;

  Message(this.message, this.email) {
    this.createdAt = DateTime.now();
  }

  Message.fromJson(Map<String, dynamic> json)
      : message = json["message"],
        email = json["email"],
        url = json["url"],
        password = json["password"],
        expirationDate = DateTime.fromMicrosecondsSinceEpoch(
            json["expiration_date"]),
        createdAt = DateTime.fromMicrosecondsSinceEpoch(json["created_at"]);

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
        "expiration_date": expirationDate.microsecondsSinceEpoch,
        "created_at": createdAt.microsecondsSinceEpoch
      };
}
