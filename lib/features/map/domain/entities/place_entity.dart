class PlaceEntity {
  final String placeId;
  final String name;
  final String address;
  final Map<String, dynamic> latLng;
  final List<String> placeType;
  final int? likeCount;
  final int? postCount;
  final String? imageUrl;

  PlaceEntity({
    required this.placeId,
    required this.name,
    required this.address,
    required this.latLng,
    required this.placeType,
    this.likeCount = 0,
    this.postCount = 0,
    this.imageUrl,
  });

  factory PlaceEntity.fromJson(Map<String, dynamic> json) {
    return PlaceEntity(
      placeId: json['placeId'],
      name: json['name'],
      address: json['address'],
      latLng: json['latLng'],
      placeType: json['placeType'],
      likeCount: json['likeCount'],
      postCount: json['postCount'],
      imageUrl: json['imageUrl'],
    );
  }

  PlaceEntity copyWith({
    String? placeId,
    String? name,
    String? address,
    Map<String, dynamic>? latLng,
    List<String>? placeType,
    int? likeCount,
    int? postCount,
    String? imageUrl,
  }) {
    return PlaceEntity(
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      address: address ?? this.address,
      latLng: latLng ?? this.latLng,
      placeType: placeType ?? this.placeType,
      likeCount: likeCount ?? this.likeCount,
      postCount: postCount ?? this.postCount,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'PlaceEntity(placeId: $placeId, name: $name, address: $address, latLng: $latLng, placeType: $placeType, likeCount: $likeCount, postCount: $postCount, imageUrl: $imageUrl)';
  }
}
