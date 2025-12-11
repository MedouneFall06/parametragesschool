/// Ceci est le modèle représentant un utilisateur générique du système.
/// C'est la base pour les enseignants, parents et agents.
/// Il permet de structurer les données de manière cohérente à travers l'application.

class User {
  // --- PROPRIÉTÉS ---

  /// Identifiant unique de l’utilisateur.
  final String id;

  /// Nom de famille de l’utilisateur.
  final String nom;

  /// Prénom de l’utilisateur.
  final String prenom;

  /// Adresse email utilisée pour l'authentification et les notifications.
  final String email;

  /// Le rôle de l’utilisateur (ex: "enseignant", "parent", "agent").
  final String role;

  // --- CONSTRUCTEUR ---

  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.role,
  });

  // AJOUTE ces méthodes manquantes
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'role': role,
    };
  }

}
