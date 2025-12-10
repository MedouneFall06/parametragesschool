/// Modèle représentant un étudiant dans une classe donnée.
/// Il peut être lié à un parent.

class Etudiant {
  final String id;
  final String nom;
  final String prenom;
  final String matricule;
  final String classeId;
  final String? parentId;

  Etudiant({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.matricule,
    required this.classeId,
    this.parentId,
  });
}
