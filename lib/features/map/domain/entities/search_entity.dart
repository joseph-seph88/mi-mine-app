class SearchEntity {
  final String placeId;
  final String primaryText;
  final String? secondaryText;
  final String? fullText;
  final String? address;
  final Map<String, dynamic>? latLng;
  final String? distance;
  final List<String>? placeType;

  SearchEntity({
    required this.placeId,
    required this.primaryText,
    this.secondaryText,
    this.fullText,
    this.address,
    this.latLng,
    this.distance,
    this.placeType,
  });

  SearchEntity copyWith({
    String? placeId,
    String? primaryText,
    String? secondaryText,
    String? fullText,
    String? address,
    Map<String, dynamic>? latLng,
    String? distance,
    List<String>? placeType,
  }) {
    return SearchEntity(
      placeId: placeId ?? this.placeId,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      fullText: fullText ?? this.fullText,
      address: address ?? this.address,
      latLng: latLng ?? this.latLng,
      distance: distance ?? this.distance,
      placeType: placeType ?? this.placeType,
    );
  }

  factory SearchEntity.fromJson(Map<String, dynamic> json) {
    return SearchEntity(
      placeId: json['placeId'] ?? '',
      primaryText: json['primaryText'] ?? '',
      secondaryText: json['secondaryText'] ?? '',
      fullText: json['fullText'] ?? '',
      address: json['address'] ?? '',
      latLng: json['latLng'] ?? {},
      distance: json['distanceMeters'] ?? '',
      placeType: json['types'] ?? [],
    );
  }

  @override
  String toString() {
    return 'SearchEntity(placeId: $placeId, primaryText: $primaryText, secondaryText: $secondaryText, fullText: $fullText, address: $address, latLng: $latLng, distance: $distance, placeType: $placeType)';
  }
}
