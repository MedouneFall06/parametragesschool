/// Modèle représentant un bulletin scolaire.

class Bulletin {
  final String id;
  final String etudiantId;
  final String anneeId;
  final double moyenneGenerale;

  Bulletin({
    required this.id,
    required this.etudiantId,
    required this.anneeId,
    required this.moyenneGenerale,
  });
}
