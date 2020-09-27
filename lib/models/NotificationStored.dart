class NotificationStored {
  final int id;
  final String title;
  final String body;
  final String timestamp;

  NotificationStored({this.id, this.title, this.body, this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'timestamp': timestamp,
    };
  }
}
