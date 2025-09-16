import 'package:equatable/equatable.dart';

enum MissionType {
  exploration, // 탐험 미션
  weekly, // 주간 미션
  monthly, // 월간 미션
}

enum MissionStatus {
  notStarted, 
  inProgress,
  completed, 
  expired, 
}

class MissionEntity extends Equatable {
  final String missionId;
  final String title;
  final String description;
  final MissionType type;
  final MissionStatus status;
  final int currentProgress;
  final int targetProgress;
  final int rewardPoints;
  final String? imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? completedAt;
  final List<String>? tags;
  final String? location; 

  const MissionEntity({
    required this.missionId,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.currentProgress,
    required this.targetProgress,
    required this.rewardPoints,
    this.imageUrl,
    required this.startDate,
    required this.endDate,
    this.completedAt,
    this.tags,
    this.location,
  });

  double get progressPercentage {
    if (targetProgress == 0) return 0.0;
    return (currentProgress / targetProgress).clamp(0.0, 1.0);
  }

  bool get isCompleted => status == MissionStatus.completed;
  bool get isExpired =>
      status == MissionStatus.expired || DateTime.now().isAfter(endDate);
  bool get isActive => status == MissionStatus.inProgress && !isExpired;

  String get typeDisplayName {
    switch (type) {
      case MissionType.exploration:
        return '탐험 미션';
      case MissionType.weekly:
        return '주간 미션';
      case MissionType.monthly:
        return '월간 미션';
    }
  }

  MissionEntity copyWith({
    String? missionId,
    String? title,
    String? description,
    MissionType? type,
    MissionStatus? status,
    int? currentProgress,
    int? targetProgress,
    int? rewardPoints,
    String? imageUrl,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? completedAt,
    List<String>? tags,
    String? location,
  }) {
    return MissionEntity(
      missionId: missionId ?? this.missionId,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      status: status ?? this.status,
      currentProgress: currentProgress ?? this.currentProgress,
      targetProgress: targetProgress ?? this.targetProgress,
      rewardPoints: rewardPoints ?? this.rewardPoints,
      imageUrl: imageUrl ?? this.imageUrl,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      completedAt: completedAt ?? this.completedAt,
      tags: tags ?? this.tags,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'missionId': missionId,
      'title': title,
      'description': description,
      'type': type.name,
      'status': status.name,
      'currentProgress': currentProgress,
      'targetProgress': targetProgress,
      'rewardPoints': rewardPoints,
      'imageUrl': imageUrl,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'tags': tags,
      'location': location,
    };
  }

  factory MissionEntity.fromJson(Map<String, dynamic> json) {
    return MissionEntity(
      missionId: json['missionId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: MissionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MissionType.exploration,
      ),
      status: MissionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => MissionStatus.notStarted,
      ),
      currentProgress: json['currentProgress'] as int? ?? 0,
      targetProgress: json['targetProgress'] as int? ?? 1,
      rewardPoints: json['rewardPoints'] as int? ?? 0,
      imageUrl: json['imageUrl'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>(),
      location: json['location'] as String?,
    );
  }

  @override
  List<Object?> get props => [
    missionId,
    title,
    description,
    type,
    status,
    currentProgress,
    targetProgress,
    rewardPoints,
    imageUrl,
    startDate,
    endDate,
    completedAt,
    tags,
    location,
  ];
}
