class AdEntity {
  final int? id;
  final String? imageUrl;
  final String? title;
  final String? description;

  const AdEntity({
    this.id,
    this.imageUrl,
    this.title,
    this.description,
  });

  factory AdEntity.fromJson(Map<String, dynamic> json) {
    return AdEntity(
      id: json['id'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      description: json['description'],
    );
  }

  @override
  String toString() {
    return 'AdEntity(id: $id, imageUrl: $imageUrl, title: $title, description: $description)';
  }
}
