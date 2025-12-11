class EnseignantMatiere {
  int? id;
  int enseignantId;
  int matiereId;
  DateTime? assignedAt;

  EnseignantMatiere({
    this.id,
    required this.enseignantId,
    required this.matiereId,
    this.assignedAt,
  });

  factory EnseignantMatiere.fromJson(Map<String, dynamic> json) {
    return EnseignantMatiere(
      id: json['id'],
      enseignantId: json['enseignant_id'] ?? json['enseignantId'],
      matiereId: json['matiere_id'] ?? json['matiereId'],
      assignedAt: json['assigned_at'] != null
          ? DateTime.parse(json['assigned_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'enseignant_id': enseignantId,
      'matiere_id': matiereId,
      'assigned_at': assignedAt?.toIso8601String(),
    };
  }
}