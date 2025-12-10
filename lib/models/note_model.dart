/// Modèle représentant une note saisie par un enseignant.

class Note {
  final String id;
  final String etudiantId;
  final String matiereId;
  final double valeur;   // ex : 14.5
  final DateTime date;

  Note({
    required this.id,
    required this.etudiantId,
    required this.matiereId,
    required this.valeur,
    required this.date,
  });
}
