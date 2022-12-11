class RestaurantFavorite {
  String? id;
  String? name;
  String? city;
  String? address;
  String? pictureId;
  double? rating;

  RestaurantFavorite({
    this.id,
    this.name,
    this.city,
    this.address,
    this.pictureId,
    this.rating,
  });

  factory RestaurantFavorite.fromMap(Map<String, dynamic> map) =>
      RestaurantFavorite(
        id: map["id"],
        name: map["name"],
        city: map["city"],
        address: map["address"],
        pictureId: map["pictureId"],
        rating: map["rating"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "rating": rating,
      };
}
