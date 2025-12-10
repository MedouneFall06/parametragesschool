/// Représente une année académique.

class Annee {
  final String id;
  final String label;        // ex : "2024-2025"
  final DateTime dateDebut;
  final DateTime dateFin;

  Annee({
    required this.id,
    required this.label,
    required this.dateDebut,
    required this.dateFin,
  });
}
