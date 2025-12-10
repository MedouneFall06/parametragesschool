/// Modèle représentant une notification envoyée à un utilisateur.

class NotificationModel {
  final String id;
  final String userId;
  final String type;     // ex: "note", "absence", "message"
  final String message;
  final DateTime date;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.message,
    required this.date,
  });
}
