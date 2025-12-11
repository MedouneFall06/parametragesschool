class ClasseMatiere {
  int? id;
  int classeId;
  int matiereId;
  DateTime? createdAt;

  ClasseMatiere({
    this.id,
    required this.classeId,
    required this.matiereId,
    this.createdAt,
  });

  factory ClasseMatiere.fromJson(Map<String, dynamic> json) {
    return ClasseMatiere(
      id: json['id'],
      classeId: json['classe_id'] ?? json['classeId'],
      matiereId: json['matiere_id'] ?? json['matiereId'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'classe_id': classeId,
      'matiere_id': matiereId,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}