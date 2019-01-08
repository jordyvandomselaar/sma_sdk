class Message {
  final String message;
  final String email;
  String url;
  String password;
  bool valid;

  Message(this.message, this.email, {this.valid = true});
}