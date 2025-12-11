class OfflineSync {
  String id;
  String tableName;
  String operation; // CREATE, UPDATE, DELETE
  Map<String, dynamic> data;
  DateTime createdAt;
  bool isSynced;
  DateTime? syncedAt;
  String? syncError;

  OfflineSync({
    required this.id,
    required this.tableName,
    required this.operation,
    required this.data,
    required this.createdAt,
    this.isSynced = false,
    this.syncedAt,
    this.syncError,
  });

  factory OfflineSync.fromJson(Map<String, dynamic> json) {
    return OfflineSync(
      id: json['id'],
      tableName: json['table_name'],
      operation: json['operation'],
      data: Map<String, dynamic>.from(json['data']),
      createdAt: DateTime.parse(json['created_at']),
      isSynced: json['is_synced'] ?? false,
      syncedAt: json['synced_at'] != null
          ? DateTime.parse(json['synced_at'])
          : null,
      syncError: json['sync_error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'table_name': tableName,
      'operation': operation,
      'data': data,
      'created_at': createdAt.toIso8601String(),
      'is_synced': isSynced,
      'synced_at': syncedAt?.toIso8601String(),
      'sync_error': syncError,
    };
  }
}

class SyncStatusModel {
  int pendingOperations;
  int syncedOperations;
  DateTime? lastSync;
  bool isSyncing;
  String? lastError;

  SyncStatusModel({
    required this.pendingOperations,
    required this.syncedOperations,
    this.lastSync,
    this.isSyncing = false,
    this.lastError,
  });
}