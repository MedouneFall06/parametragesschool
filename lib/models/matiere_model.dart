/// Modèle représentant une matière enseignée (ex: "Mathématiques").
/// La propriété "coefficient" permet les calculs des moyennes.

class Matiere {
  final String id;
  final String nom;
  final double coefficient;

  Matiere({
    required this.id,
    required this.nom,
    required this.coefficient,
  });
}
