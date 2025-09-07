class PostEntity {
  final int? id;
  final String? title;
  final String? description;
  final String? imageUrl;

  PostEntity({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
  });

  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  PostEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
  }) {
    return PostEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'PostEntity(id: $id, title: $title, description: $description, imageUrl: $imageUrl)';
  }
}