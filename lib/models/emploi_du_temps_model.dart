/// Modèle représentant une séance dans l'emploi du temps d'une classe.

class EmploiDuTemps {
  final String id;
  final String classeId;
  final String matiereId;
  final String enseignantId;
  final String jour;   // ex: "Lundi"
  final String heure;  // ex: "08:00 - 10:00"

  EmploiDuTemps({
    required this.id,
    required this.classeId,
    required this.matiereId,
    required this.enseignantId,
    required this.jour,
    required this.heure,
  });
}
