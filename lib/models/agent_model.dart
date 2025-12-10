/// Modèle représentant un agent administratif.
/// Il hérite logiquement d'un utilisateur mais Flutter n’a pas d’héritage JSON automatique.
/// On garde donc des modèles simples et indépendants.

class Agent {
  final String userId;
  final String poste; // Ex: "Secrétaire", "Comptable"

  Agent({
    required this.userId,
    required this.poste,
  });
}
