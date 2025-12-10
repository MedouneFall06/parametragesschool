/// Modèle représentant un enseignant.
/// Extensible dans le futur si d'autres propriétés sont ajoutées.

class Enseignant {
  final String userId;     // Référence vers un User
  final String specialite; // Ex: "Mathématiques"

  Enseignant({
    required this.userId,
    required this.specialite,
  });
}
