/// Modèle représentant une classe (ex: "3e A", "Terminale S2").

class Classe {
  final String id;
  final String nom;
  final String niveau;
  final String departementId;

  Classe({
    required this.id,
    required this.nom,
    required this.niveau,
    required this.departementId,
  });
}
