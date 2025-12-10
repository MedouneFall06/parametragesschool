/// Modèle représentant une absence d’étudiant.

class Absence {
  final String id;
  final String etudiantId;
  final DateTime date;
  final String motif;
  final bool justifie;

  Absence({
    required this.id,
    required this.etudiantId,
    required this.date,
    required this.motif,
    required this.justifie,
  });
}
